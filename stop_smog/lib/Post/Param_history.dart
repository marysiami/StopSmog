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
    String warring = " ";
    if (param.key != null) {
      switch (param.key) {
        case "C6H6":
          warring =
              AppLocalizations.of(context).translate('yearWarring') + " 5 µg/m3";
          break;
        case "NO2":
          warring = AppLocalizations.of(context).translate('yearWarring') +
              " 40 µg/m3 \n1" +
              AppLocalizations.of(context).translate('hourWarring') +
              " 200 µg/m3";
          break;
        case "SO2":
          warring = "1 " +
              AppLocalizations.of(context).translate('hourWarring') +
              " 350 µg/m3 \n24" +
              AppLocalizations.of(context).translate('hourWarring') +
              " 125 µg/m3";
          break;
        case "CO":
          warring = "8 " +
              AppLocalizations.of(context).translate('hourWarring') +
              " 10 000 µg/m3";
          break;
        case "PM10":
          warring = AppLocalizations.of(context).translate('yearWarring') +
              " 40 µg/m3 \n24" +
              AppLocalizations.of(context).translate('hourWarring') +
              " 50 µg/m3";
          break;
        case "PM2.5":
          warring =
              AppLocalizations.of(context).translate('yearWarring') + " 20 µg/m3";
          break;
        case "Pb":
          warring =
              AppLocalizations.of(context).translate('yearWarring') + " 0,5 µg/m3";
          break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(param.key == null ? " " : param.key),
        ),
        body: ListView(children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                param.key == null ? " " : param.key,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(AppLocalizations.of(context)
                          .translate('ParametrHistory') ==
                      null
                  ? " "
                  : AppLocalizations.of(context).translate('ParametrHistory') + "\n \n" +
                      warring),
            ),
          ),
          Drawdiagramhistory(param.values)
        ]));
  }
}
