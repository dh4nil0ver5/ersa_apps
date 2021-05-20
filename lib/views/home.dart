import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final div_height = 20.0;
    final div_doc1 = 100.0;
    final div_doc2 = size.height - (div_height + div_height);
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/doc1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          new SizedBox(height: div_height),
          new Container(
            height: div_doc1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/doc1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SizedBox(height: div_height),
          new Container(
            padding: EdgeInsets.all(10),
            height: div_doc2 - 238,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/doc2.png"),
                  fit: BoxFit.fill,
                  scale: 1),
            ),
          ),
        ],
      ),
    );
  }
}
