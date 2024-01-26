import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:study_planner/services/auth_services.dart';
import 'package:study_planner/screens/main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthServices _authServices = AuthServices();
  late StreamSubscription<User?> _authSubscription;
  // ignore: unused_field
  late User? _user;

  @override
  void initState() {
    super.initState();
    _authSubscription = _authServices.authStateChanges.listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel(); // Detener la escucha de cambios al salir del widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google SignIn"),
      ),
      body: googleSignInButton(),
    );
  }

  Widget googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: () async {
            UserCredential? userCredential = await _authServices.signInWithGoogle();
            if (userCredential != null) {
              // Navigate to MainScreen passing the user
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen(user: userCredential.user)),
              );
            }
          },
        ),
      ),
    );
  }

}