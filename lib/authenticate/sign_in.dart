import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loddge_me/utils/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn(this.email, {super.key});

  final String? email;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthProvider _auth = AuthProvider();
  bool _obscureText = true;
  bool isLoading = false;
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailController.text = "${widget.email}";
    super.initState();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //snackBar widget
  void showSnackBar(context) {
    const snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: 300,
      backgroundColor: Colors.white,
      content: Text('Reset link sent, check your email',
          style: TextStyle(color: Colors.black)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //reset password
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    //Email Field
    final emailField = TextFormField(
        controller: emailController,
        readOnly: true,
        decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));

    //PassWord Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _obscureText,
      validator: (val) => val!.length < 8
          ? 'Password must contain at least 8 characters'
          : null,
      onSaved: (val) {
        passwordEditingController.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        suffix: InkWell(
          onTap: _toggle,
          child: Text(_obscureText ? 'Show' : 'Hide',
              style: const TextStyle(color: Colors.black)),
        ),
      ),
    );

    //elevated button widget
    final continueButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            _auth.signInWithEmailAndPassword(
                emailController.text, passwordEditingController.text);
          },
          child: isLoading
              ? JumpingDots(
                  color: Colors.white,
                  radius: 6,
                  numberOfDots: 3,
                  verticalOffset: 10,
                  animationDuration: const Duration(milliseconds: 100),
                )
              : const Text('Continue')),
    );

    //forgot password text button
    final forgotPassword = TextButton(
      child: const Text('Forgot password',
          style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black)),
      onPressed: () async {
        await resetPassword();
        if (context.mounted) {
          showSnackBar(context);
        }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Log in',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            emailField,
            const SizedBox(
              height: 20,
            ),
            passwordField,
            const SizedBox(
              height: 20,
            ),
            continueButton,
            const SizedBox(
              height: 20,
            ),
            Center(child: forgotPassword)
          ],
        ),
      ),
    );
  }
}
