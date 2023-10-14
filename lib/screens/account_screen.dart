import 'package:flutter/material.dart';
import 'package:loddge_me/utils/auth.dart';
import 'package:loddge_me/utils/google_sign_in.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthProvider _auth = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No account available yet"),
          TextButton(
              onPressed: () {
                _auth.signOut();
                SignInWithGoogle.disconnect();
              },
              child: const Text('signout'))
        ],
      )),
    );
  }
}
