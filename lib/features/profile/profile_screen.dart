import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double balance = 0.0;

  void calculateBalance() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data() as Map<String, dynamic>;
          final bankAccounts = data['bank_accounts'] as List<dynamic>;
          var totalBalance = 0;
          for (var account in bankAccounts) {
            totalBalance += account['balance'] as int;
          }
          setState(() {
            balance = totalBalance.toDouble();
          });
        } else {
          print('Document does not exist on the database');
        }
      });
    } catch (e) {
      print('Error Reading Balance on profile screen accounts not added');
    }
  }

  @override
  void initState() {
    super.initState();
    calculateBalance();
  }

  @override
  Widget build(BuildContext context) {
    // read the balance from firestore

    return const SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
