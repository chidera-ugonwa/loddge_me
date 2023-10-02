import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loddge_me/customIcons/mail_icons.dart';
import 'package:loddge_me/providers/authentication_provider.dart';
import 'package:jumping_dot/jumping_dot.dart';

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
  late Timer _timer;
  int _start = 60;
  bool isLoading = false;
  bool enableResend = false;
  bool buttonEnabled = false;

//snackBar widget
  void showSnackBar(context) {
    const snackBar = SnackBar(
      content: Text('InvalidOTP'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//timer function
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            enableResend = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

//handle form message
  Widget handleFormMessage() {
    if (otpFieldVisibility) {
      if (enableResend) {
        return TextButton(
            style: TextButton.styleFrom(
                alignment: Alignment.topLeft,
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 12)),
            child: const Text('Resend OTP'),
            onPressed: () async {
              _auth.verifyUserPhoneNumber(userNumber);
              setState(() => _start = 60);
              startTimer();
              setState(() {
                enableResend = false;
                buttonEnabled = false;
              });
            });
      } else {
        return Text('OTP sent. Resend OTP in $_start seconds.',
            style: const TextStyle(fontSize: 12));
      }
    } else {
      return const Text(
          "We'll send an OTP to confirm your number. Standard message and data rates apply",
          style: TextStyle(fontSize: 12));
    }
  }

  //elevated button child
  Widget elevatedButtonChild() {
    if (isLoading) {
      return JumpingDots(
        color: Colors.white,
        radius: 10,
        numberOfDots: 3,
        animationDuration: const Duration(milliseconds: 200),
      );
    } else {
      return Text(
        otpFieldVisibility ? 'Verify' : 'Continue',
      );
    }
  }

//dispose
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                  if (userNumber.length > 13) {
                    setState(() => buttonEnabled = true);
                  }
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
                      onChanged: (val) {
                        if (val.length > 5) {
                          setState(() => buttonEnabled = true);
                        }
                      },
                    ),
                  )),
              SizedBox(width: 300, child: handleFormMessage()),
              const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: buttonEnabled
                        ? () async {
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
                              if (userNumber.length > 13) {
                                setState(() => otpFieldVisibility = true);
                                startTimer();
                                setState(() => buttonEnabled = false);
                              }
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        : null,
                    child: elevatedButtonChild()),
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
