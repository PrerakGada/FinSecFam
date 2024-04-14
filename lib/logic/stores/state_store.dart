// Create a class AuthStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'dart:convert';

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

  List<Transaction> transactions = [];

  final Dio dio = Dio();

  // Get Transactions and put the logic in a try catch block
  void getTransactions() async {
    try {
      final response = await client.get(Uri.parse('$apiUrl/transactions'));
      logger.d(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        notifyListeners();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  // /// Create User Profile with required Basic Details
  // Future<FeedPostModel?> createFeedPost({
  //   List<String>? mediaUrls,
  //   required String caption,
  //   String? fileUrl,
  // }) async {
  //   log("FeedRepo | createFeedPost");
  //   try {
  //     final tokens = await Tokens().getTokens();
  //     final response = await client.post(
  //       '$apiUrl/posts',
  //       data: {
  //         "mediaUrls": mediaUrls,
  //         "caption": caption,
  //         "fileUrl": fileUrl,
  //       },
  //       options: Options(headers: {'Cookie': 'accessToken=${tokens[0]}; refreshToken=${tokens[1]}'}),
  //     );
  //     if (response.statusCode == 200) {
  //       logger.d("FeedRepo | createFeedPost | ${prettyJSON(response.data)}");
  //       return FeedPostModel.fromJSON(response.data['data']);
  //     }
  //   } catch (e, st) {
  //     logger.d("FeedRepo | createFeedPost | Error | $e");
  //     logger.d("FeedRepo | createFeedPost | Error | $st");
  //   }
  //   return null;
  // }

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
