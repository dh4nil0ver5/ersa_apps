import 'package:flutter/material.dart';

class Legalitas extends StatefulWidget {
  Legalitas({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LegalitasState createState() => _LegalitasState();
}

class _LegalitasState extends State<Legalitas> {

    @override
    void initState() {}

    @override
    Widget build(BuildContext context) {
      return Container(
        alignment: Alignment.center ,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text("NPWP")),
                    Center(child: Text("SIUP")),
                  ],
                ),
              ),
             ),
           ),
        ),
      );
    }
}
