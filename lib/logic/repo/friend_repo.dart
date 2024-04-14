import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Friend {
  final String uid;
  final String name;
  final String email;

  Friend({required this.name, required this.email, required this.uid});

  // write a toString method to display the name and email of the friend
  @override
  String toString() {
    return 'Name: $name, Email: $email, UID: $uid';
  }
}

class FriendRepo {
  // remove everyone's all friends and friend requests
  Future<void> removeAllFriendsAndFriendRequests() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(element['uid'])
            .update({'friends': [], 'friend_requests': []});
      }
    });
  }

  // delete friend request from uid
  Future<void> deleteFriendRequest(String uid) async {
    // remove from friend request list
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'friend_requests': FieldValue.arrayRemove([uid])
    });
  }

  Future<List<Friend>> getPossibleFriends() async {
    List<Friend> friends = [];

    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }
        // dont add the user's friends
        // first check if user has friends
        if (element['friends'] != null) {
          if (element['friends']
              .contains(FirebaseAuth.instance.currentUser!.uid)) {
            continue;
          }
        }

        friends.add(Friend(
            name: element['name'],
            email: element['email'],
            uid: element['uid']));
      }
    });

    return friends;
  }

  // get a list of all friends
  Future<List<Friend>> getFriends() async {
    List<Friend> friends = [];

    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }
        // dont add the user's friends
        if (element['friends']
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          friends.add(Friend(
              name: element['name'],
              email: element['email'],
              uid: element['uid']));
        }
      }
    });

    return friends;
  }

  Future<void> sendFriendRequest(Friend friend) async {
    // send friend request by adding uid of the friend to the user's friend_request list
    FirebaseFirestore.instance.collection('users').doc(friend.uid).update({
      'friend_requests': FieldValue.arrayUnion([friend.uid])
    });
  }

  Future<void> addFriend(Friend friend) async {
    // add friend by adding uid of the friend to the user's friends list
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'friends': FieldValue.arrayUnion([friend.uid])
    });

    // remove from friend request list
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'friend_requests': FieldValue.arrayRemove([friend.uid])
    });
  }

  Future<void> removeFriend(Friend friend) async {
    // remove friend by removing uid of the friend from the user's friends list
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'friends': FieldValue.arrayRemove([friend.email])
    });
  }

  // write a get friend_requests method
  Future<List<Friend>> getFriendRequests() async {
    List<Friend> friendRequests = [];

    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }
        // dont add the user's friends
        if (element['friend_requests']
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          friendRequests.add(Friend(
              name: element['name'],
              email: element['email'],
              uid: element['uid']));
        }
      }
    });

    return friendRequests;
  }

  // write a method to accept a friend request and send a notification
  Future<void> acceptFriendRequest(String uid) async {
    // load the friend from the uid, via firebasefirestore
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      Friend friend =
          Friend(name: value['name'], email: value['email'], uid: value['uid']);
      // add friend by adding uid of the friend to the user's friends list
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'friends': FieldValue.arrayUnion([friend.uid])
      });

      // remove from friend request list
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'friend_requests': FieldValue.arrayRemove([friend.uid])
      });
    });
  }
}
