import 'package:flutter/material.dart';
import 'package:loddge_me/utils/google_sign_in.dart';

class AccountExists extends StatefulWidget {
  const AccountExists(this.email, {super.key});

  final String? email;

  @override
  State<AccountExists> createState() => _AccountExistsState();
}

class _AccountExistsState extends State<AccountExists> {
  @override
  Widget build(BuildContext context) {
    //google sign in button
    final googleSignInButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size.fromHeight(52),
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black)),
      child: ListTile(
          leading: Image.asset('assets/googlelogo.png', height: 28),
          title: const Text('Continue with Google',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ))),
      onPressed: () async {
        await SignInWithGoogle.signInWithGoogle(context: context);
      },
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text('Account exists',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text('Looks like you already have an account.'),
                    const SizedBox(height: 20),
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey.shade300,
                      size: 130,
                    ),
                    const SizedBox(height: 10),
                    Text("${widget.email}"),
                    const SizedBox(height: 30),
                    googleSignInButton,
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Log in with a different account',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black)),
              )
            ],
          ),
        ));
  }
}
