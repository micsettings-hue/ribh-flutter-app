import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
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

void main() {
  group('CampaignRepository watchlist', () {
    test('myWatchlist returns the saved id set', () async {
      final repo = CampaignRepository(
        clientWith(
          MockClient((request) async {
            expect(request.url.path, endsWith('/campaign_watchlist'));
            return json200([
              {'campaign_id': 'c1'},
              {'campaign_id': 'c3'},
            ], request);
          }),
        ),
      );
      final result = await repo.myWatchlist();
      expect(result.valueOrNull, {'c1', 'c3'});
    });

    test('campaigns parse includes the new title column', () async {
      final repo = CampaignRepository(
        clientWith(
          MockClient(
            (request) async => json200([
              {
                'id': 'c1',
                'business_id': null,
                'title': 'Printing Zone',
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
            ], request),
          ),
        ),
      );
      final result = await repo.campaigns();
      expect(result.valueOrNull!.single.title, 'Printing Zone');
    });

    test('title missing from older rows falls back to empty', () async {
      final repo = CampaignRepository(
        clientWith(
          MockClient(
            (request) async => json200([
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
            ], request),
          ),
        ),
      );
      final result = await repo.campaigns();
      expect(result.valueOrNull!.single.title, '');
    });
  });
}
