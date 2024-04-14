// Create a class AuthRepo that uses singleton pattern.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  AuthRepo._();
  static final AuthRepo _instance = AuthRepo._();
  factory AuthRepo() => _instance;

  // Create a google auth function
  Future<bool> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          registerFcmToken(token);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  // fcm token registration
  Future<void> registerFcmToken(String token) async {
    try {
      // connect to firestore

      logger.d("token: $token");
      final String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "fcm_token": token,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      logger.d(e);
    }
  }
}
