import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Repositories are exercised against a real SupabaseClient whose HTTP layer
/// is mocked, so the full request/serialization path is under test.
SupabaseClient clientWith(MockClient httpClient) => SupabaseClient(
  'http://localhost:54321',
  'test-key',
  httpClient: httpClient,
);

// postgrest reads response.request, so every mock response must carry the
// originating request.
http.Response json200(Object body, http.Request request) => http.Response(
  jsonEncode(body),
  200,
  headers: {'content-type': 'application/json'},
  request: request,
);

http.Response postgrestError(
  String message,
  http.Request request, {
  int status = 400,
}) => http.Response(
  jsonEncode({
    'message': message,
    'code': 'P0001',
    'details': null,
    'hint': null,
  }),
  status,
  headers: {'content-type': 'application/json'},
  request: request,
);

void main() {
  group('unconfigured backend', () {
    test(
      'every call returns NotConfiguredFailure, never a fake success',
      () async {
        const repo = CampaignRepository(null);
        final result = await repo.campaigns();
        expect(result.failureOrNull, isA<NotConfiguredFailure>());
      },
    );
  });

  group('InvestmentRepository.invest', () {
    test('refuses locally without both risk acknowledgements', () async {
      // No HTTP handler should ever be hit.
      final repo = InvestmentRepository(
        clientWith(
          MockClient((request) async => fail('must not reach the network')),
        ),
      );
      final result = await repo.invest(
        campaignId: 'c1',
        amount: 1000,
        riskAck1: true,
        riskAck2: false,
      );
      final failure = result.failureOrNull;
      expect(failure, isA<ValidationFailure>());
      expect(failure!.message, 'risk_acknowledgements_required');
    });

    test(
      'calls the invest_in_campaign RPC and returns the investment id',
      () async {
        late http.Request seen;
        final repo = InvestmentRepository(
          clientWith(
            MockClient((request) async {
              seen = request;
              expect(request.url.path, endsWith('/rpc/invest_in_campaign'));
              return json200('investment-uuid-1', request);
            }),
          ),
        );

        final result = await repo.invest(
          campaignId: 'c1',
          amount: 40000,
          riskAck1: true,
          riskAck2: true,
        );

        expect(result.valueOrNull, 'investment-uuid-1');
        final params = jsonDecode(seen.body) as Map<String, dynamic>;
        expect(params['p_campaign_id'], 'c1');
        expect(params['p_amount'], 40000);
        expect(params['p_ack1'], true);
        expect(params['p_ack2'], true);
        expect(params['p_source'], 'wallet');
      },
    );

    test('maps insufficient_funds to InsufficientFundsFailure', () async {
      final repo = InvestmentRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('insufficient_funds', request),
          ),
        ),
      );
      final result = await repo.invest(
        campaignId: 'c1',
        amount: 999999,
        riskAck1: true,
        riskAck2: true,
      );
      expect(result.failureOrNull, isA<InsufficientFundsFailure>());
    });

    test('maps not_verified to NotVerifiedFailure', () async {
      final repo = InvestmentRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('not_verified', request),
          ),
        ),
      );
      final result = await repo.invest(
        campaignId: 'c1',
        amount: 1000,
        riskAck1: true,
        riskAck2: true,
      );
      expect(result.failureOrNull, isA<NotVerifiedFailure>());
    });

    test('maps campaign_not_open to ValidationFailure', () async {
      final repo = InvestmentRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('campaign_not_open', request),
          ),
        ),
      );
      final result = await repo.invest(
        campaignId: 'c1',
        amount: 1000,
        riskAck1: true,
        riskAck2: true,
      );
      expect(result.failureOrNull, isA<ValidationFailure>());
    });
  });

  group('CampaignRepository', () {
    test('parses a campaign list from PostgREST', () async {
      final repo = CampaignRepository(
        clientWith(
          MockClient((request) async {
            expect(request.url.path, endsWith('/campaigns'));
            return json200([
              {
                'id': 'c1',
                'business_id': null,
                'contract': 'murabaha',
                'sector': 'printing',
                'pool': 500000000,
                'raised': 210000000,
                'profit_per_lac': 1450000,
                'share': 60.0,
                'tenure': 6,
                'risk': 'moderate',
                'status': 'open',
                'created_at': '2026-07-01T00:00:00Z',
              },
            ], request);
          }),
        ),
      );

      final result = await repo.campaigns();
      final campaigns = result.valueOrNull;
      expect(campaigns, isNotNull);
      expect(campaigns!.single.status, CampaignStatus.open);
      expect(campaigns.single.fundingPercent, closeTo(42.0, 0.001));
    });

    test('filters by status using the exact database value', () async {
      late http.Request seen;
      final repo = CampaignRepository(
        clientWith(
          MockClient((request) async {
            seen = request;
            return json200(const [], request);
          }),
        ),
      );

      await repo.campaigns(status: CampaignStatus.inRecovery);
      expect(seen.url.queryParameters['status'], 'eq.in_recovery');
    });
  });

  group('WalletRepository', () {
    test('myBalance reads the derived balance RPC', () async {
      final repo = WalletRepository(
        clientWith(
          MockClient((request) async {
            expect(request.url.path, endsWith('/rpc/my_wallet_balance'));
            return json200(65000, request);
          }),
        ),
      );
      final result = await repo.myBalance();
      expect(result.valueOrNull, 65000);
    });

    test('myTransactions parses ledger rows newest first', () async {
      late http.Request seen;
      final repo = WalletRepository(
        clientWith(
          MockClient((request) async {
            seen = request;
            return json200([
              {
                'id': 't2',
                'wallet_id': 'w1',
                'kind': 'investment',
                'amount': 40000,
                'ref_type': 'investment',
                'ref_id': 'i1',
                'signature': null,
                'created_at': '2026-07-11T11:00:00Z',
              },
              {
                'id': 't1',
                'wallet_id': 'w1',
                'kind': 'deposit',
                'amount': 100000,
                'ref_type': 'payment',
                'ref_id': null,
                'signature': null,
                'created_at': '2026-07-11T10:00:00Z',
              },
            ], request);
          }),
        ),
      );

      final result = await repo.myTransactions();
      expect(seen.url.queryParameters['order'], startsWith('created_at.desc'));
      final ledger = result.valueOrNull;
      expect(ledger, isNotNull, reason: '${result.failureOrNull}');
      expect(ledger!.first.kind, TxKind.investment);
      expect(deriveBalance(ledger), 60000);
    });
  });
}
