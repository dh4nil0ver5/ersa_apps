import 'package:flutter/material.dart';
import 'package:ersa_apps/bloc/navigation_bloc/navigation_bloc.dart';

class MyCardsPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const MyCardsPage({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.blueAccent),
          onTap: onMenuTap,
        ),
        title: Center(
          child: Text(
            "Dashboard",
            style: TextStyle(fontSize: 24, color: Colors.blueAccent),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Text("Welcome"),
            ),
          ),
        ),
      ),
    );
  }
}
