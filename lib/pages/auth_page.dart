import 'package:flutter/material.dart';

import 'package:chatz/components/auth_form.dart';

import 'package:chatz/core/models/auth_form_data.dart';

import '../core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        // Login
        await AuthService().login(formData.email, formData.password);
      } else {
        // SignUp
        await AuthService().signUp(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      // Tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
