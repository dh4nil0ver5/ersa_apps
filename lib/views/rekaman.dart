import 'package:flutter/material.dart';

class Rekaman extends StatefulWidget {
  Rekaman({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RekamanState createState() => _RekamanState();
}

class _RekamanState extends State<Rekaman> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Text("Peta Order Jawa timur"),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Peta Order Jawa barat"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
