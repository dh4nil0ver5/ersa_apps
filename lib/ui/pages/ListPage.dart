import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersa_apps/ui/pages/ChildList.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final Function onMenuTap;
  const ListPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _groupValue = -1;
  var isBool = true;
  var isDial = false;
  var isChoiceAdd = false;

  void _handleRadioValueChanged(int value) {
    setState(() {
      _groupValue = value;
      print(_groupValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double size_head = 100;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          color: Colors.blueAccent,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  child: Icon(Icons.menu, color: Colors.white),
                  onTap: widget.onMenuTap,
                ),
                Text("Utilities",
                    style: TextStyle(fontSize: 24, color: Colors.white)),
                Icon(Icons.settings, color: Colors.transparent),
              ],
            ),
            Visibility(
              visible: isBool ? isBool : isBool,
              child: AnimatedOpacity(
                opacity: isBool ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: new ChildList(size_head: size_head),
              ),
            ),

            // Visibility(
            //   visible: isDial,
            //   child: AnimatedOpacity(
            //     opacity: isDial ? 1.0 : 0.0,
            //     duration: Duration(milliseconds: 500),
            //     child: Center(
            //       child: Container(
            //         margin: EdgeInsets.only(top: 100),
            //         width: size.width * 0.5,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(10),
            //           ),
            //           color: Colors.blue.shade700,
            //         ),
            //         child: Column(
            //           children: <Widget>[
            //             Center(
            //               child: Text(
            //                 "Pilihan :",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //             Row(
            //               children: [
            //                 new Radio(
            //                   focusColor: Colors.green,
            //                   activeColor: Colors.green,
            //                   value: 0,
            //                   groupValue: _groupValue,
            //                   onChanged: _handleRadioValueChanged,
            //                 ),
            //                 Text(
            //                   "Menu",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 new Radio(
            //                   focusColor: Colors.green,
            //                   activeColor: Colors.green,
            //                   value: 1,
            //                   groupValue: _groupValue,
            //                   onChanged: _handleRadioValueChanged,
            //                 ),
            //                 Text(
            //                   "Content menu",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ],
            //             ),
            //             Container(
            //               width: 50,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(10),
            //                 ),
            //                 color: Colors.blueAccent,
            //               ),
            //               padding: EdgeInsets.all(3),
            //               child: Center(
            //                 child: InkWell(
            //                   child: Text(
            //                     "pilih",
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   onTap: () {
            //                     setState(() {
            //                       isDial = !isDial;
            //                       isChoiceAdd = !isChoiceAdd;
            //                     });
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: new FloatingActionButton(
      //   elevation: 0.0,
      //   child: new Icon(Icons.add),
      //   backgroundColor: new Color(0xFFE57373),
      //   onPressed: () {
      //     setState(() {
      //       isBool = !isBool;
      //       isDial = !isDial;
      //       isChoiceAdd = !isChoiceAdd;
      //     });
      //   },
      //   tooltip: 'Toggle Opacity',
      // ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
