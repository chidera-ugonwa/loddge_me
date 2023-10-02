import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  Stream<User?> get user_ => auth.authStateChanges();

//reload page
  reload() async {
    return auth.currentUser?.reload();
  }

  var receivedID = '';
  int? updateToken = 0;

//sign in with Google
  void signInWithGoogle() {}

//update resend token
  void updateResendToken(int? resendToken) {
    updateToken = resendToken;
    notifyListeners();
  }

//change received id
  void changeReceivedId(String receivedId) {
    receivedID = receivedId;
    notifyListeners();
  }

  //verify user phoneNumber
  void verifyUserPhoneNumber(String userNumber) {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
              (value) => debugPrint('Logged In Successfully'),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        updateResendToken(resendToken);
        changeReceivedId(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //verify otpCode
  Future verifyOTPCode(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: otpCode,
    );
    debugPrint(receivedID);
    try {
      await auth
          .signInWithCredential(credential)
          .then((value) => debugPrint('User Login In Successful'));
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
