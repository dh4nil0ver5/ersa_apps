import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ersa_apps/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersa_apps/ui/pages/BaseAlertDialog.dart';

bool USE_FIRESTORE_EMULATOR = false;

class MessagesPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const MessagesPage({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc('menu')
        .collection("data")
        .snapshots();
    CollectionReference users = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc('menu')
        .collection("data");
    TextEditingController nama_menu = TextEditingController();
    Future<void> addUser() {
      return users
          .add({
            'link': "", // John Doe
            'nama': nama_menu.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> deleteUser(String id) {
      return users
          .doc(id)
          .delete() // <-- Delete
          .then((_) => print('Deleted'))
          .catchError((error) => print('Delete failed: $error'));
    }

    Future<void> updateUser(String id) {
      return users
          .doc(id)
          .update({'nama': "mencoba"})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
      ;
    }

    void formUpdate(String id) {}
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        color: Colors.redAccent,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    child: Icon(Icons.menu, color: Colors.white),
                    onTap: onMenuTap,
                  ),
                  Text("Menu",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  Icon(Icons.settings, color: Colors.transparent),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                height: size.height * 0.8,
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
                                    Container(
                                      width: size.width * 0.15,
                                      child: Row(
                                        children: <Widget>[
                                          InkWell(
                                            child: Icon(Icons.edit,
                                                color: Colors.white),
                                            onTap: () async {
                                              bool result = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Masukkan jenis layanan'),
                                                    content: TextFormField(
                                                      controller: nama_menu,
                                                    ),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop(
                                                                  false); // dismisses only the dialog and returns false
                                                        },
                                                        child: Text('Batal'),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          addUser();
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop(
                                                                  true); // dismisses only the dialog and returns true
                                                        },
                                                        child: Text('Simpan'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          InkWell(
                                            child: Icon(Icons.delete,
                                                color: Colors.white),
                                            onTap: () =>
                                                deleteUser(document.id),
                                          ),
                                        ],
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
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Color(0XFF0D325E),
                child: Icon(Icons.add),
                onPressed: () async {
                  bool result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Masukkan jenis layanan'),
                        content: TextFormField(
                          controller: nama_menu,
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop(
                                  false); // dismisses only the dialog and returns false
                            },
                            child: Text('Batal'),
                          ),
                          FlatButton(
                            onPressed: () {
                              addUser();
                              Navigator.of(context, rootNavigator: true).pop(
                                  true); // dismisses only the dialog and returns true
                            },
                            child: Text('Simpan'),
                          ),
                        ],
                      );
                    },
                  );

                  if (result) {
                  } else {}
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
