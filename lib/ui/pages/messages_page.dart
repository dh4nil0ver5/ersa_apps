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
    TextEditingController nama_menu_ubah = TextEditingController();
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

    Future<void> updateUser(String id, String nama_update) {
      return users
          .doc(id)
          .update({'nama': nama_update})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
      ;
    }

    void showAlertDialog(BuildContext context) {
      FirebaseFirestore.instance
          .collection("firestore_ersa")
          .doc("menu")
          .collection("data");
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () => {},
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

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.white),
          onTap: onMenuTap,
        ),
        title: Center(
          child: Text(
            "Menu",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: InkWell(
              child: Icon(Icons.add, color: Colors.white),
              onTap: () async {
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
              },
            ),
          ),
        ],
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      /* drawer: Drawer(
          child: AppDrawer(),
        ),*/
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            color: Colors.redAccent,
            width: size.width,
            height: size.height,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: GestureDetector(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: new Text(
                                  "title: " + document.get("nama"),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.edit,
                                              color: Colors.redAccent),
                                        ),
                                        onTap: () async {
                                          bool result = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Edit : '),
                                                content: TextFormField(
                                                  controller: nama_menu_ubah,
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
                                                      updateUser(document.id,
                                                          nama_menu_ubah.text);
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
                                    ),
                                    Container(
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.delete,
                                              color: Colors.redAccent),
                                        ),
                                        onTap: () => deleteUser(document.id),
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
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
