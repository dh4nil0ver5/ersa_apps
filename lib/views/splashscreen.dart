import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storage/views/Homepage.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    setState(() {
      new Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage(title: "Yudistira App", nmr_hp: "123",),));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', width: 100, height: 100,),
          ],
        ),
      ),
    );
  }
}
