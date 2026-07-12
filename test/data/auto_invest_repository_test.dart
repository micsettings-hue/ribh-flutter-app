import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/auto_invest_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient clientWith(MockClient httpClient) => SupabaseClient(
  'http://localhost:54321',
  'test-key',
  httpClient: httpClient,
);

http.Response json200(Object body, http.Request request) => http.Response(
  jsonEncode(body),
  200,
  headers: {'content-type': 'application/json'},
  request: request,
);

http.Response postgrestError(String message, http.Request request) =>
    http.Response(
      jsonEncode({
        'message': message,
        'code': 'P0001',
        'details': null,
        'hint': null,
      }),
      400,
      headers: {'content-type': 'application/json'},
      request: request,
    );

void main() {
  group('AutoInvestRepository', () {
    test('approveQueueItem refuses locally without both acknowledgements '
        'and never reaches the network', () async {
      final repo = AutoInvestRepository(
        clientWith(
          MockClient((request) async => fail('must not reach the network')),
        ),
      );
      final result = await repo.approveQueueItem(
        itemId: 'q1',
        riskAck1: true,
        riskAck2: false,
      );
      final failure = result.failureOrNull;
      expect(failure, isA<ValidationFailure>());
      expect(failure!.message, 'risk_acknowledgements_required');
    });

    test('approveQueueItem calls the RPC with item id and both acks', () async {
      late http.Request seen;
      final repo = AutoInvestRepository(
        clientWith(
          MockClient((request) async {
            seen = request;
            expect(request.url.path, endsWith('/rpc/approve_queue_item'));
            return json200('investment-uuid-9', request);
          }),
        ),
      );
      final result = await repo.approveQueueItem(
        itemId: 'q1',
        riskAck1: true,
        riskAck2: true,
      );
      expect(result.valueOrNull, 'investment-uuid-9');
      final params = jsonDecode(seen.body) as Map<String, dynamic>;
      expect(params['p_item_id'], 'q1');
      expect(params['p_ack1'], true);
      expect(params['p_ack2'], true);
    });

    test('approveQueueItem maps insufficient_funds', () async {
      final repo = AutoInvestRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('insufficient_funds', request),
          ),
        ),
      );
      final result = await repo.approveQueueItem(
        itemId: 'q1',
        riskAck1: true,
        riskAck2: true,
      );
      expect(result.failureOrNull, isA<InsufficientFundsFailure>());
    });

    test('saveRule updates an existing rule in place', () async {
      late http.Request seen;
      final repo = AutoInvestRepository(
        clientWith(
          MockClient((request) async {
            seen = request;
            expect(request.url.path, endsWith('/auto_invest_rules'));
            return json200({
              'id': 'r1',
              'profile_id': 'u1',
              'strategy': 'short',
              'budget': 50000,
              'active': false,
              'created_at': '2026-07-12T10:00:00Z',
            }, request);
          }),
        ),
      );
      final result = await repo.saveRule(
        existingId: 'r1',
        strategy: 'short',
        budget: 50000,
        active: false,
      );
      expect(result.valueOrNull!.active, isFalse);
      expect(seen.method, 'PATCH');
      final body = jsonDecode(seen.body) as Map<String, dynamic>;
      expect(body['strategy'], 'short');
      expect(body['budget'], 50000);
      expect(body['active'], false);
    });

    test('myQueue parses items with status', () async {
      final repo = AutoInvestRepository(
        clientWith(
          MockClient(
            (request) async => json200([
              {
                'id': 'q1',
                'rule_id': 'r1',
                'campaign_id': 'c1',
                'status': 'pending',
                'created_at': '2026-07-12T10:00:00Z',
              },
              {
                'id': 'q2',
                'rule_id': 'r1',
                'campaign_id': 'c2',
                'status': 'declined',
                'created_at': '2026-07-11T10:00:00Z',
              },
            ], request),
          ),
        ),
      );
      final result = await repo.myQueue();
      final queue = result.valueOrNull!;
      expect(queue, hasLength(2));
      expect(queue.first.status, QueueStatus.pending);
      expect(queue.last.status, QueueStatus.declined);
    });
  });
}
