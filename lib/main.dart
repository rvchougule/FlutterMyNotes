import 'package:flutter/material.dart';
import 'package:waste_collector/constants/routes.dart';
import 'package:waste_collector/services/auth/auth_service.dart';

import 'package:waste_collector/views/login_view.dart';
import 'package:waste_collector/views/notes_view.dart';
import 'package:waste_collector/views/register_view.dart';
import 'package:waste_collector/views/verify_email_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        VerifyEmailRoute: (context) => const VerifyEmail(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const LoginView();
            }
          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
        }
      },
    );
  }
}
