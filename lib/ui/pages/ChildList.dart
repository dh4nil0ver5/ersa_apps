import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersa_apps/src/file_picker_demo.dart';
import 'package:ersa_apps/ui/pages/ListPage.dart';
import 'package:ersa_apps/ui/pages/Vehicle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildList extends StatefulWidget {
  final double size_head;

  const ChildList({Key key, this.size_head}) : super(key: key);

  @override
  _ChildListState createState() => _ChildListState();
}

class _ChildListState extends State<ChildList> {
  int _groupValue = -1;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('firestore_ersa')
      .doc("menu")
      .collection("data")
      .snapshots();

  var isList = true;
  var isNotice = false;
  var isAdd = false;
  var getId = "";

  void _handleRadioValueChanged(int value) {
    setState(() {
      _groupValue = value;
      isNotice = !isNotice;
      isAdd = !isAdd;
      if (_groupValue == 0) {
      } else if (_groupValue == 1) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: file_picker_demo(userId: getId),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int _activeMeterIndex;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height - 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        color: Colors.blueAccent,
      ),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Visibility(
              visible: isList,
              child: AnimatedOpacity(
                opacity: isList ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      return
                        Flex(
                            direction: Axis.horizontal,
                            children: [Expanded(
                        child: new ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.size,
                            itemBuilder: (BuildContext context, int i) {
                              DocumentSnapshot user = snapshot.data.docs[i];
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: new ExpansionPanelList(
                                  expansionCallback: (int index, bool status) {
                                    setState(() {
                                      _activeMeterIndex =
                                      _activeMeterIndex == i ? null : i;
                                    });
                                  },
                                  children: [
                                    new ExpansionPanel(
                                      isExpanded: _activeMeterIndex == i,
                                      headerBuilder:
                                          (BuildContext context, bool isExpanded) {
                                        return new Container(
                                          padding:
                                          const EdgeInsets.only(left: 15.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child:
                                                new InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      getId = user.id;
                                                      isList = !isList;
                                                      isNotice = !isNotice;
                                                      _list(user.id, context);
                                                    });
                                                  },
                                                  child: Icon(Icons.add),
                                                ),
                                              ),
                                              new Text(
                                                user.get("nama"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      body: new Container(
                                        child: _page(i, user.id, context),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),],);

                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isNotice,
              child: AnimatedOpacity(
                opacity: isNotice ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  color: Colors.greenAccent,
                  width: size.width * 0.6,
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Pilihan :",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          new Radio(
                            focusColor: Colors.green,
                            activeColor: Colors.green,
                            value: 0,
                            groupValue: _groupValue,
                            onChanged: _handleRadioValueChanged,
                          ),
                          Text(
                            "Menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          new Radio(
                            focusColor: Colors.green,
                            activeColor: Colors.green,
                            value: 1,
                            groupValue: _groupValue,
                            onChanged: _handleRadioValueChanged,
                          ),
                          Text(
                            "Content menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isAdd,
              child: AnimatedOpacity(
                opacity: isAdd ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  child: isAdd ? _list(getId, context) : Text("isi"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(String keys, BuildContext context) {
    // print("233 " + keys);
    var size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc("menu")
        .collection("data")
        .doc(keys)
        .collection("content_menu_data")
        .snapshots();

    return Visibility(
      visible: isNotice ? isNotice : isNotice,
      child: AnimatedOpacity(
        opacity: isList ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                }

                return Container(
                  child: new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new ListTile(
                        title: GestureDetector(
                          child: Container(
                            width: size.width * 0.9,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: size.width * 0.65,
                                  child: new Text(
                                    "title: " + document.get("nama"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _page(int page, String keys, BuildContext context) {
    // return Text("ini ontext $page");
    final Stream<QuerySnapshot> _usersStream_ch = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc("menu")
        .collection("data")
        .doc(keys)
        .collection("content_menu_data")
        .snapshots();
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: _usersStream_ch,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          return Container(
            width: size.width,
            child: new ListView(
              shrinkWrap: true,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: GestureDetector(
                    child: Container(
                      width: size.width - widget.size_head,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: size.width * 0.66,
                            padding: EdgeInsets.all(10),
                            child: Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: "title: " + document.get("nama")),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.blueAccent,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
