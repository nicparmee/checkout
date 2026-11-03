import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/white_text_theme.dart';
import '../bloc/auth_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  void _signIn(BuildContext context) {
    context.read<AuthCubit>().signIn();
    context.canPop() ? context.pop() : context.go('/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: whiteTextTheme(Theme.of(context)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                const TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) => _signIn(context),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => _signIn(context),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
