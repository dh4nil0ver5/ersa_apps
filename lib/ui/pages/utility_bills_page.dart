import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ersa_apps/ui/pages/ListPage.dart';
import 'package:flutter/material.dart';
import 'package:ersa_apps/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ersa_apps/ui/pages/ChildList.dart';

class UtilityBillsPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const UtilityBillsPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListPage(
      onMenuTap: onMenuTap,
    );
  }
}
