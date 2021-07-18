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
  TextEditingController nama_menu = TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('firestore_ersa')
      .doc("menu")
      .collection("data")
      .snapshots();

  var isList = true;
  var isNotice = false;
  var getId = "";
  int _groupValue = -1;
  int _activeMeterIndex;

  void _handleRadioValueChanged(int value) {
    setState(() {
      _groupValue = value;
      isNotice = !isNotice;
      if (_groupValue == 0) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: file_picker_demo(
              userId: getId,
              childs: "",
              cmd: "tambah_baru_per_item",
            ),
          ),
        );
        setState(() {
          isList = !isList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var size_top = MediaQuery.of(context).size.height * 0.3;
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Visibility(
        visible: isList,
        child: AnimatedOpacity(
          opacity: isList ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
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
                return new ListView.builder(
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
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: new Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
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
                                        ],
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
                  },
                );
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
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
              width: size.width * 0.6,
              margin: EdgeInsets.only(top: size_top),
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
                        "Content menu",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: RaisedButton(
                        child: Text("back"),
                        onPressed: () {
                          setState(() {
                            isList = !isList;
                            isNotice = !isNotice;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _list(String keys, BuildContext context) {
    // print(keys + " 116");
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
                            child: Row(
                              children: <Widget>[
                                Container(
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
    final Stream<QuerySnapshot> _usersStream_ch = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc("menu")
        .collection("data")
        .doc(keys)
        .collection("content_menu_data")
        .snapshots();
    String tex = keys;
    String getIdChild;
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
                String nama = document.get("nama").toString();
                getIdChild = document.id;
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: nama),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: file_picker_demo(
                                      userId: keys,
                                      childs: getIdChild,
                                      cmd: "ubah_per_item"),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () =>
                                showAlertDialog(context, tex, getIdChild),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, String parent, String text) {
    print(text);
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => hapus(context, parent, text),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notifikasi"),
      content: Text("data dihapus ?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  hapus(BuildContext context, String parent, String text) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    FirebaseFirestore.instance
        .collection("firestore_ersa")
        .doc("menu")
        .collection("data")
        .doc(parent)
        .collection("content_menu_data")
        .doc(text)
        .delete()
        .then((value) => {print('oke')})
        .catchError((error) => {print('error')});
  }
}
