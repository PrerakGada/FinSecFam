// Create a class AuthStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'package:finsec/logic/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../utils/const.dart';

class AuthStore extends ChangeNotifier {
  AuthStore._();

  static final AuthStore _instance = AuthStore._();

  factory AuthStore() {
    return _instance;
  }

  bool isAuthenticated = false;

  UserCredential? userCredential;

  Future<void> init() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isAuthenticated = true;
      AuthRepo().registerFcmToken(await FirebaseMessaging.instance.getToken() ?? '');
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    return await AuthRepo().googleAuth();
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      isAuthenticated = true;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      logger.d(e);
      return false;
    }
    return false;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      isAuthenticated = true;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.d('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        logger.d('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    isAuthenticated = false;
    notifyListeners();
  }
}
