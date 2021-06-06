import 'dart:async';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage/views/HexColor.dart';
import 'package:storage/views/NavigationScreen.dart';
import 'package:storage/views/maps.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key, required this.title, required this.nmr_hp})
      : super(key: key);

  final String title;
  final String nmr_hp;

  @override
  _MyHomepage createState() => _MyHomepage();
}

class _MyHomepage extends State<Homepage> with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  final List<String> label = [
    "Home",
    "Legalitas",
    "Order",
    "Rekaman",
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  Widget bodyFunction() {
    switch (_bottomNavIndex) {
      case 0:
        return NavigationScreen(iconList[_bottomNavIndex], _bottomNavIndex);
        break;
      case 1:
        return Container(color: Colors.blue);
        break;
      case 2:
        return Container(color: Colors.orange);
        break;
      default:
        return Maps();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var titles = widget.title;
    var nmrhp = widget.nmr_hp;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 50,
          leading: Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 80,
          ),
          title: Container(
            child: Column(
              children: [
                Text(
                  titles,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: InkWell(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content: const Text('AlertDialog description'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: bodyFunction(),
        // body: NavigationScreen(iconList[_bottomNavIndex], _bottomNavIndex),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          elevation: 10,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? HexColor('#FFA400') : Colors.white;
            // final color = isActive ? Colors.black : Colors.grey;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    label[index],
                    maxLines: 1,
                    style: TextStyle(color: color),
                    group: autoSizeGroup,
                  ),
                )
              ],
            );
          },
          backgroundColor: HexColor('#373A36'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }
}
