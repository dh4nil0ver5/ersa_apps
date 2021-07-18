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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: <Widget>[
              Container(
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Icon(Icons.menu, color: Colors.white),
                            onTap: widget.onMenuTap,
                          ),
                          Text("Utilities",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                          Icon(Icons.settings, color: Colors.transparent),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isBool ? isBool : isBool,
                      child: AnimatedOpacity(
                        opacity: isBool ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: new ChildList(size_head: size_head),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
