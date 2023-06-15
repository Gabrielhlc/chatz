import 'package:flutter/material.dart';

import 'package:chatz/core/models/chat_user.dart';

import 'package:chatz/pages/auth_page.dart';
import 'package:chatz/pages/chat_page.dart';
import 'package:chatz/pages/loading_page.dart';

import '../core/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
