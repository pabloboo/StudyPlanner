import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_planner/screens/home_page.dart';
import 'package:study_planner/services/auth_services.dart';

class UserPage extends StatefulWidget {
  final User? user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Study Planner')),
      ),
      body : userInfo(),
    );
  }

  Widget userInfo() {
    User? user = widget.user;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user!.photoURL!),
              ),
            ),
          ),
          Text(user.email!),
          Text(user.displayName ?? ""),
          MaterialButton(
            color: Colors.red,
            onPressed: () async {
              await _authServices.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text("Sign Out"),
          )
        ],
      ),
    );
  }

}