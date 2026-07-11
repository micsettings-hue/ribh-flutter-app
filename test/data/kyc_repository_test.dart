import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/kyc_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('NID validation', () {
    test('accepts 10, 13, and 17 digit numbers', () {
      expect(isValidNidNumber('1234567890'), isTrue);
      expect(isValidNidNumber('1234567890123'), isTrue);
      expect(isValidNidNumber('12345678901234567'), isTrue);
    });

    test('rejects other lengths and non-digits', () {
      expect(isValidNidNumber(''), isFalse);
      expect(isValidNidNumber('12345'), isFalse);
      expect(isValidNidNumber('123456789012'), isFalse);
      expect(isValidNidNumber('12345abcde'), isFalse);
    });
  });

  test('hashNid produces the sha-256 hex digest', () {
    // Known vector: sha256('1234567890').
    expect(
      hashNid('1234567890'),
      'c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646',
    );
    expect(hashNid('1234567890').length, 64);
  });

  group('submitKyc', () {
    test(
      'refuses an invalid NID locally, never touching the network',
      () async {
        final repo = KycRepository(
          SupabaseClient(
            'http://localhost:54321',
            'test-key',
            httpClient: MockClient(
              (request) async => fail('must not reach network'),
            ),
          ),
        );
        final result = await repo.submitKyc(
          nidNumber: '12345',
          sourceOfFunds: KycSource.salary,
        );
        expect(result.failureOrNull, isA<ValidationFailure>());
      },
    );

    test(
      'sends the hash, never the raw NID, and the db source value',
      () async {
        late http.Request seen;
        final repo = KycRepository(
          SupabaseClient(
            'http://localhost:54321',
            'test-key',
            httpClient: MockClient((request) async {
              seen = request;
              return http.Response(
                jsonEncode('submission-1'),
                200,
                headers: {'content-type': 'application/json'},
                request: request,
              );
            }),
          ),
        );

        final result = await repo.submitKyc(
          nidNumber: '1234567890',
          sourceOfFunds: KycSource.businessIncome,
        );

        expect(result.valueOrNull, 'submission-1');
        expect(seen.url.path, endsWith('/rpc/submit_kyc'));
        final params = jsonDecode(seen.body) as Map<String, dynamic>;
        expect(
          params['p_nid_hash'],
          'c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646',
        );
        expect(params['p_source_of_funds'], 'business_income');
        expect(params['p_selfie_captured'], false);
        expect(seen.body.contains('1234567890'), isFalse);
      },
    );
  });
}
