import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:loddge_me/providers/authentication_provider.dart';
//import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthProvider _auth = AuthProvider();

  String userNumber = '';

  bool otpFieldVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IntlPhoneField(
              controller: phoneController,
              initialCountryCode: 'NG',
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                userNumber = val.completeNumber;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Visibility(
              visible: otpFieldVisibility,
              child: TextField(
                controller: otpController,
                decoration: const InputDecoration(
                  hintText: 'OTP Code',
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ),
          ElevatedButton(
            onPressed: () {
              if (otpFieldVisibility) {
                _auth.verifyOTPCode(otpController.text);
              } else {
                _auth.verifyUserPhoneNumber(userNumber);
                debugPrint(userNumber);
                if (userNumber.length > 13) {
                  setState(() => otpFieldVisibility = true);
                }
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Text(
              otpFieldVisibility ? 'Login' : 'Verify',
            ),
          )
        ],
      ),
    );
  }
}
