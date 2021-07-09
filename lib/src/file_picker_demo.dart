import 'package:ersa_apps/ui/pages/ListPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

enum UploadType {
  string,
  file,
  clear,
}

class file_picker_demo extends StatefulWidget {

  final String userId;

  const file_picker_demo({Key key, this.userId}) : super(key: key);

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<file_picker_demo> {
  List<firebase_storage.UploadTask> _uploadTasks = [];

  String _fileName = '...';
  String _path = '...';
  String _DownloadURL = '...';
  String _extension;
  String _hasTxt = "...";
  bool _hasValidMime = false;
  bool _hasFinish = false;

  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    var dir = await getExternalStorageDirectory();

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = (millSeconds.toString() + "_101");
    final String today = ('$month-$date');
    int size = 0;
    int isTransferred = 0;
    final int _progress = 0;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("video")
        .child(today)
        .child(storageId);

    CollectionReference users = FirebaseFirestore.instance
        .collection('firestore_ersa')
        .doc("menu")
        .collection("data")
        .doc(widget.userId)
        .collection("content_menu_data");

    UploadTask uploadTask;
    if (_pickingType != FileType.custom || _hasValidMime || result != null) {
      try {
        File file = File(result.files.single.path);
        if (file.path.isEmpty) {
          print('kosong');
        } else {
          final metadata = firebase_storage.SettableMetadata(
              contentType: 'video/mp4',
              customMetadata: {'picked-file-path': file.path});
          uploadTask = ref.putFile(file, metadata);
          uploadTask.snapshotEvents.listen(
              (firebase_storage.TaskSnapshot snapshot) {
                setState(() {
                  size = snapshot.totalBytes;
                  isTransferred = snapshot.bytesTransferred;
                  _hasTxt =
                  'Progress: ${((isTransferred / size) * 100).toStringAsFixed(2)} %';
                });
          },onError: (e) {
            if (e.code == 'permission-denied') {
              print(
                  'User does not have permission to upload to this reference.');
            }
          });
          _path = file.uri.path;

        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      _fileName = _path != null ? _path.split('/').last : '...';

      uploadTask.whenComplete(() async{
        String files = "";
        try{
          files = await ref.getDownloadURL();

          users.add({
            'link': files, // John Doe
            'nama': _fileName, // Stokes and Sons
            'size_data': size // 42
          });
          print(files);
        }catch(onError){
          print("Error");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userId);
    var size = MediaQuery.of(context).size;
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Upload form'),
        ),
        body: SingleChildScrollView(
          child: new Center(
              child: new Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: new RaisedButton(
                    onPressed: () {
                      setState(() {
                        _hasFinish = !_hasFinish;
                      });
    setState(() {
    _openFileExplorer();
    });
                    },
                    child: new Text("Open file picker"),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: new Text(
                    'URI PATH ',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Visibility(
                  visible: _hasFinish,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 25),
                      width: size.width,
                      child: Column(
                        children: [
                          new CircularProgressIndicator(),
                          new Text(_hasTxt, style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
