import 'package:flutter/material.dart';
import 'package:ersa_apps/views/homepage.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {


  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage(title: "Yudistira App", no_hp: ""),),
        );
      },);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/tester.png"),
            SizedBox(height:10 ,),
            CircularProgressIndicator(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
