// order page with state
// states:
// order on hold
// order - payment successful
// order - payment unsuccessful
// order - expired
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Sign In')));
  }
}
