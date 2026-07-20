import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../shared/failure_l10n.dart';
import 'auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  bool _validEmail(String value) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());

  void _sendCode() {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    if (!_validEmail(email)) {
      setState(() => _emailError = l10n.authInvalidEmail);
      return;
    }
    setState(() => _emailError = null);
    ref.read(authControllerProvider.notifier).sendCode(email);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final flowState = ref.watch(authControllerProvider);
    final AuthFlow? flow = flowState.value;
    final busy = flowState.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (flow is AuthEnterEmail || flow == null) ...[
            Text(
              l10n.authIntro,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              enabled: !busy,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                labelText: l10n.authEmailLabel,
                errorText: _emailError,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendCode(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: busy ? null : _sendCode,
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.authSendCode),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Divider(color: tokens.line)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.authOr,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
                  ),
                ),
                Expanded(child: Divider(color: tokens.line)),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () => ref
                        .read(authControllerProvider.notifier)
                        .signInWithGoogle(),
              icon: const Icon(Icons.g_mobiledata, size: 24),
              label: Text(l10n.authGoogle),
            ),
          ],
          if (flow is AuthCodeSent) ...[
            Text(
              l10n.authCodeSentTo(flow.email),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              enabled: !busy,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              decoration: InputDecoration(
                labelText: l10n.authCodeLabel,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => ref
                  .read(authControllerProvider.notifier)
                  .verifyCode(flow.email, _codeController.text.trim()),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: busy
                  ? null
                  : () => ref
                        .read(authControllerProvider.notifier)
                        .verifyCode(flow.email, _codeController.text.trim()),
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.authVerify),
            ),
            TextButton(
              onPressed: busy
                  ? null
                  : () {
                      _codeController.clear();
                      ref.read(authControllerProvider.notifier).changeEmail();
                    },
              child: Text(l10n.authChangeEmail),
            ),
          ],
          if (flow?.failure case final failure?) ...[
            const SizedBox(height: 16),
            Text(
              failureText(l10n, failure),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: tokens.danger),
            ),
          ],
        ],
      ),
    );
  }
}
