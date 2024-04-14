// Create a class AuthStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../models/models.dart';

class StateStore extends ChangeNotifier {
  StateStore._();

  static final StateStore _instance = StateStore._();

  factory StateStore() {
    return _instance;
  }

  final String apiUrl = "https://app.engaze.in";

  bool isAuthenticated = false;

  UserCredential? userCredential;

  int indexofstock = 0;

  final client = http.Client();

  void change(int index) {
    indexofstock = index;
    notifyListeners();
  }

  int getIdx() {
    return indexofstock;
  }

  void getInvestments() async {
    final response = await http.get(Uri.parse('$apiUrl/investments'));
    print(response.body);
  }

  List<Transaction?> transactions = [];

  final Dio dio = Dio();

  // Get Transactions and put the logic in a try catch block
  // void getTransactions() async {
  //   try {
  //     final response = await client.get(Uri.parse('$apiUrl/transactions'));
  //     logger.d(response.body);
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);

  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  Future<List<Transaction?>?> getTransactions() async {
    log("FeedRepo | createFeedPost");
    try {
      final response = await dio.get(
        '$apiUrl/transactions',
        data: {},
      );
      if (response.statusCode == 200) {
        logger.d("FeedRepo | createFeedPost | ${prettyJSON(response.data)}");
        final List<Transaction?> datas = [];
        // response.data['data'].map((e) => Transaction.fromJson(e)).toList();

        for (final e in response.data['data']) {
          try {
            datas.add(Transaction.fromJson(e));
          } catch (e) {
            print("Errrrrr");
          }
        }

        if (datas.isNotEmpty) transactions = datas;
        return datas;

        // return Transaction.fromJson(response.data['data']);
      }
    } catch (e, st) {
      logger.d("FeedRepo | createFeedPost | Error | $e");
      logger.d("FeedRepo | createFeedPost | Error | $st");
    }
    return null;
  }

  Future<void> createTransaction(Transaction transaction) async {
    try {
      final response = await client.get(Uri.parse('$apiUrl/transactions'));
      logger.d(response.body);
    } catch (e) {
      logger.e(e);
    }
    print('Transaction created');
    getTransactions();
  }
}
