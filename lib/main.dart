import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ersa_apps/ui/pages/Loading.dart';
import 'package:ersa_apps/ui/pages/Error.dart';
import 'menu_dashboard_layout/menu_dashboard_layout.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;

// void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Error();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: MenuDashboardLayout());
        }

        return Loading();
      },
    );
  }
}
