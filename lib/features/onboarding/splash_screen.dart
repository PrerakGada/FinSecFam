// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:finsec/logic/stores/state_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/utils.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    );
    _animationController.forward();
    super.initState();
    handleNavigation();
  }

  Future<void> initApis() async {
    log("SplashScreen | initApis");

    context.read<StateStore>().getTransactions();

    // ask for notification permission\

    // Declaration of variables
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (Platform.isIOS) {
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    // AccountRepo().init();

    // ask for camera and location permission
    print("Camera Status: ${(await Permission.camera.request()).toString()}");
    print("Location Status: ${(await Permission.location.request()).toString()}");

    // gallery permission
    // print("Gallery Status: ${(await Permission.photos.request()).toString()}");

    if (!context.read<AuthStore>().isAuthenticated) {
      await context.read<AuthStore>().init();
    }
  }

  void handleNavigation() async {
    await initApis();

    // wait 1 second
    await Future.delayed(const Duration(milliseconds: 3000));

    if (FirebaseAuth.instance.currentUser != null) {
      if (true) {
        if (context.mounted) {
          AutoRouter.of(context).replace(const MainScaffoldRoute());
        }
      }
    } else {
      if (context.mounted) {
        AutoRouter.of(context).replace(LoginRoute());
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Image(
                  image: const AssetImage('assets/logos/finsec.png'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const Text('FinSecFam', style: Typo.displayMedium),
            ],
          ),
        ),
      ),
    );
  }
}
