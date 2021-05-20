import 'dart:io';
// import 'package:ersa_apps/views/splashscreen.dart';
import 'package:ersa_apps/views/legalitas.dart';
import 'package:ersa_apps/views/BottomNavigationTabBarView.dart';
import 'package:ersa_apps/views/order.dart';
import 'package:ersa_apps/views/rekaman.dart';
import 'package:ersa_apps/views/home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title, this.no_hp}) : super(key: key);

  final String title;
  final String no_hp;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {

  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  var lastIndex;

  @override
  Widget build(BuildContext context) {

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    void _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Informasi"),
                content: new Text("Pilih tindakan :"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close me!'),
                    onPressed: () => exit(0),
                  )
                ],
              ),
            );
    }

    getCurrentPage(int index) {
      if (index == 0) {
        return Home();
      } else if (index == 1) {
        return Legalitas();
      } else if (index == 2) {
        return Order();
      } else if (index == 3) {
          return Rekaman();
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[Text(widget.title), Text(widget.no_hp)],
        ), 
        automaticallyImplyLeading: false,
        // leading: InkWell(
        //   child: Icon(Icons.arrow_back),
        //   onTap: () => exit(0),
        //   onTap: _showMaterialDialog,
        // ),
        actions: <Widget>[
          InkWell(
            onTap: () => exit(0),
            child: Icon(Icons.close_rounded, color: Colors.white,),
          )
        ],
      ),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          getCurrentPage(_currentIndex),
        ],
      ),
      bottomNavigationBar:
        BottomNavigationTabBarView(_currentIndex, onTabChange: (index) {
          _currentIndex = index;
          setState(() {});
          if (_currentIndex == 3 && _currentIndex == lastIndex) {}
          lastIndex = index;
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.home),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Legalitas',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Order',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'Rekaman',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Tentang',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   showSelectedLabels: true,
      //   unselectedLabelStyle: TextStyle(color: Colors.grey[500]),
      //   unselectedItemColor: Colors.grey,
      //   selectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      // ),
      floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
