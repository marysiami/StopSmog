import 'dart:convert';

import 'package:flutter/material.dart';
import '../app_localizations.dart';
import 'API.dart';
import 'Draw_diagram_history.dart';
import 'Models/ParamDetails.dart';

class ParamHistoryScreen extends StatefulWidget {
  static const routeName = '/param_history';
  @override
  ParamHistoryScreen({Key key, this.id}) : super(key: key);
  final int id;
  _ParamHistoryScreenState createState() => new _ParamHistoryScreenState();
}

class _ParamHistoryScreenState extends State<ParamHistoryScreen> {
  static ParamDetails param = new ParamDetails();

  _getStations(int i) {
    API.getParamDetails(i).then((response) {
      setState(() {
        param = ParamDetails.fromJson(json.decode(response.body));
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getStations(widget.id);
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(param.key == null? " ": param.key),
        ),
        body: ListView(children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                param.key== null? " ": param.key,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  AppLocalizations.of(context).translate('ParametrHistory')== null?" " : AppLocalizations.of(context).translate('ParametrHistory')),
            ),
          ),
          Drawdiagramhistory(param.values)
        ]));
  }
}
