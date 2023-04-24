import 'package:flutter/material.dart';
import 'package:loddge_me/providers/authentication_provider.dart';

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
              },
              child: const Text('signout'))
        ],
      )),
    );
  }
}
