import 'package:flutter/material.dart';

final privacyPolicy =
    TextButton(child: const Text('Privacy Policy'), onPressed: () {});

final nonDiscriminationPolicy = TextButton(
    child: const Text('Non Discrimination Policy, '), onPressed: () {});

final termsOfService =
    TextButton(child: const Text('Terms of Service, '), onPressed: () {});

final paymentsTermsOfService = TextButton(
  child: const Text('Payments Terms of Service '),
  onPressed: () {},
);

const agreeAndContinue =
    Text('Agree and Continue, ', style: TextStyle(fontWeight: FontWeight.bold));
