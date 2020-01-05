import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';
import 'API.dart';
import 'Models/Station.dart';

class MyPoints extends StatefulWidget {
  static const routeName = '/my_points';
  @override
  createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: Text(AppLocalizations.of(context).translate('MyPoints')),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView( children: <Widget>[Card(
      ),],
      ),
    );
  }
}
