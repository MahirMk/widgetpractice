import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../UI/other/RoughPage.dart';
import '../widgets/MyAlertDialouge.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //SIGN UP METHOD
  Future<User?> fireAuthSignUp(BuildContext context, String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailAddress, password: password,);
      return credential.user;

    }
    on FirebaseAuthException catch (e) {
      simpleDialogue(context, '${e.message}',);
    }
    return null;
  }

//SIGN IN METHOD
  Future<User?> fireAuthSignIn(BuildContext context, String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password,
      );

      print(credential);
      return credential.user;
    }
    on
    FirebaseAuthException catch (e) {
      simpleDialogue(context, '${e.message}',);
    }
    return null;
  }

  //SIGN IN METHOD
  fireAuthSignOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    await FacebookAuth.instance.logOut();

  }

  //Social Auth
  socialAuth() {
    Future<UserCredential> signInWithGoogle(googleUser) async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<User?> googleAuth() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      print(user);
      return result.user;
    }
    return null;
  }

  Future<User?> faceBookAuth(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential result = await auth.signInWithCredential(facebookAuthCredential);
      User? user = result.user;
      print(user);
      return result.user;
    }
    on
    FirebaseAuthException catch (e) {
      simpleDialogue(context, '${e.message}',);
    }
    return null;
  }

  Future<User?> verifyOTP(BuildContext context,String otp,String verificationID) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otp);
      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      print(user);

      return result.user;
    }
    on
    FirebaseAuthException catch (e) {
      simpleDialogue(context, '${e.message}',);
    }
    return null;
  }
}

