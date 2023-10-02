import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loddge_me/customIcons/mail_icons.dart';
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

  void showSnackBar(context) {
    const snackBar = SnackBar(
      content: Text('InvalidOTP'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 56,
              ),
              const Text('Log in or sign up to LodgeMe',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              IntlPhoneField(
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
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                  )),
              const SizedBox(
                width: 300,
                child: Text(
                    "We'll send an OTP to confirm your number. Standard message and data rates apply",
                    style: TextStyle(fontSize: 12)),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (otpFieldVisibility) {
                      dynamic isError =
                          await _auth.verifyOTPCode(otpController.text);
                      debugPrint("$isError");
                      if (isError == null) {
                        if (context.mounted) {
                          showSnackBar(context);
                        }
                      }
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
                    otpFieldVisibility ? 'Verify' : 'Continue',
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              const Row(children: <Widget>[
                Expanded(child: Divider()),
                Text("  or  "),
                Expanded(child: Divider()),
              ]),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    fixedSize: const Size.fromHeight(52),
                    side: const BorderSide(color: Colors.black)),
                child: const ListTile(
                    leading: Icon(Mail.mail, color: Colors.black),
                    title: Text('Continue with Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(bottom: 14)),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    fixedSize: const Size.fromHeight(52),
                    side: const BorderSide(color: Colors.black)),
                child: const ListTile(
                    leading: Icon(Icons.facebook, color: Colors.blue),
                    title: Text('Continue with Facebook',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(bottom: 14)),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(52),
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black)),
                child: ListTile(
                    leading: Image.asset('assets/googlelogo.png', height: 28),
                    title: const Text('Continue with Google',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
                onPressed: () {},
              ),
              const Padding(padding: EdgeInsets.only(bottom: 14)),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    fixedSize: const Size.fromHeight(52),
                    side: const BorderSide(color: Colors.black)),
                child: const ListTile(
                    leading: Icon(Icons.apple, color: Colors.black),
                    title: Text('Continue with Apple',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
