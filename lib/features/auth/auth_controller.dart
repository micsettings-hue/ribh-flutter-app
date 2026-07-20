import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../../data/repositories/providers.dart';

part 'auth_controller.g.dart';

/// The passwordless sign-in flow: enter email, then enter the emailed code.
/// A successful verification creates a session; the router's auth listener
/// takes over from there.
sealed class AuthFlow {
  const AuthFlow(this.failure);

  final Failure? failure;
}

class AuthEnterEmail extends AuthFlow {
  const AuthEnterEmail({Failure? failure}) : super(failure);
}

class AuthCodeSent extends AuthFlow {
  const AuthCodeSent(this.email, {Failure? failure}) : super(failure);

  final String email;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthFlow> build() => const AuthEnterEmail();

  Future<void> sendCode(String email) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).sendEmailOtp(email);
    state = AsyncData(switch (result) {
      Ok() => AuthCodeSent(email),
      Err(:final failure) => AuthEnterEmail(failure: failure),
    });
  }

  Future<void> verifyCode(String email, String code) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .verifyEmailOtp(email: email, code: code);
    state = AsyncData(switch (result) {
      Ok() => AuthCodeSent(email),
      Err(:final failure) => AuthCodeSent(email, failure: failure),
    });
  }

  /// Launches Google sign-in. On success the browser opens and the session
  /// arrives via the deep-link redirect, handled by the router's auth
  /// listener; only a launch failure surfaces here.
  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    state = AsyncData(switch (result) {
      Ok() => const AuthEnterEmail(),
      Err(:final failure) => AuthEnterEmail(failure: failure),
    });
  }

  void changeEmail() {
    state = const AsyncData(AuthEnterEmail());
  }
}
