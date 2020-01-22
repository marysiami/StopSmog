import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/API/Api.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/Util/state_widget.dart';
import 'package:stop_smog/Quiz2/pages/quiz_page/quiz_page.dart';

import '../app_localizations.dart';
import 'API.dart';
import 'Models/Station.dart';

var api = Api("stations");
class MyPoints extends StatefulWidget {
  static const routeName = '/my_points';
  @override
  createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  StateModel appState;

  List<Map<dynamic, dynamic>> list = new List();

  initState() {
    super.initState();
  }

  void removeUserStationDB(String stationId, String name) async {
    FirebaseUser currentUser2 = await getCurrentFirebaseUser();
    DocumentReference documentReference2 =
        Firestore.instance.collection("stations").document(currentUser2.uid);
    DocumentSnapshot ds = await documentReference2.get();
    bool isLiked = ds.exists;

    List<int> stationsList = new List();
    List<String> stationListNames = new List();

    if (isLiked) {
      var currentItem = list.firstWhere((x) => x["id"] == currentUser2.uid);

      stationsList = currentItem["stations"].cast<int>();
      stationListNames = currentItem["stationsNames"].cast<String>();
      int id = int.parse(stationId);

      var l1 = stationsList.toList();
      var l2 = stationListNames.toList();
      l1.remove(id);
      l2.remove(name);

      await Firestore.instance
          .document("stations/${currentUser2.uid}")
          .updateData({"stations": l1, "stationsNames": l2});
    }
  }

  StationDetailsCard(int stationId, String stationName) {
    return Card(
        child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Container( child: AutoSizeText(
          stationName,
          style: TextStyle(fontSize: 16),
          maxLines: 2,
        ), width: 250,),

        new FlatButton(
          onPressed: () {
            String exception = "Usunięto stację z kolekcji";
            Flushbar(
              title: "Nowa aktywność",
              message: exception,
              duration: Duration(seconds: 10),
            )..show(context);
            var result = api
                .getDataCollection()
                .then((value) => HandleValue(value));
            removeUserStationDB(stationId.toString(), stationName);
          },
          child: new Icon(
            Icons.remove_circle,
            color: Colors.red,
            size: 22,
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    var details;
    if (appState.stationNames != null && appState.stationsId != null) {
      final stationIds = appState?.stationsId;
      for (var id in stationIds) {
        var index = stationIds.indexOf(id);
        details = ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: stationIds.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return StationDetailsCard(id, appState?.stationNames[index]);
            });
      }
    } else {
      details = "";
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: Text(AppLocalizations.of(context).translate('MyPoints')),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Container(child: details));
  }
}
