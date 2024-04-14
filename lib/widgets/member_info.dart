import 'package:flutter/material.dart';

class MemberInfo extends StatefulWidget {
  @override
  _MemberInfoState createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Info'),
      ),
      body: Center(
        child: Text('Member Info Screen'),
      ),
    );
  }
}