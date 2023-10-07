import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loddge_me/models/user.dart';

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

  //create user object based on firebase user
  UserId? _userFromFirebaseUser(User? user) {
    return user != null ? UserId() : null;
  }

//sign in with email and password
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User users = result.user!;
      if (!users.emailVerified) {
        await users.sendEmailVerification();
      }
      return _userFromFirebaseUser(users);
    } on FirebaseAuthException catch (e) {
      String error = e.message.toString();
      return error;
    }
  }

//sign up with email and password
  Future registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      String error = e.message.toString();
      return error;
    }
  }

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
