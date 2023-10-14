import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithFacebook {
  static Future signInWithFacebook() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ['public_profile, user_birthday']);

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await auth.signInWithCredential(facebookAuthCredential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //handle the error here
        return e.code;
      }

      if (e.code == 'invalid-credential') {
        //hanle the error here
        return e.code;
      }
    } catch (e) {
      //handle the error here
      debugPrint(e.toString());
      return null;
    }

    return user;
  }
}
