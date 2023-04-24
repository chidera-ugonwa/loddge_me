import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loddge_me/home/home_page.dart';
import 'package:loddge_me/authenticate/sign_up.dart';
//import 'package:loddge_me/authenticate/enter_otp.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return const HomePage();
    } else {
      return const SignUp();
    }
  }
}
