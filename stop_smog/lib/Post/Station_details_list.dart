import 'dart:convert';

import 'package:flutter/material.dart';

import '../app_localizations.dart';
import 'API.dart';
import 'Models/StationDetails.dart';
import 'Param_history.dart';

class StationDetailsListScreen extends StatefulWidget {
  static const routeName = '/stations_repository';
  int stationId;
  StationDetailsListScreen({Key key, @required this.stationId})
      : super(key: key);

  method(int id) => stationId = id;

  @override
  _StationDetailsListScreenState createState() =>
      new _StationDetailsListScreenState();
}

class _StationDetailsListScreenState extends State<StationDetailsListScreen> {
  var stations = new List<StationDetails>();

  _getStations() {
    API.getStationDetails(widget.stationId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stations = list.map((model) => StationDetails.fromJson(model)).toList();
      });
    });
  }

  void selectItem(BuildContext ctx, String routeName, int id) {
    Navigator.of(ctx).pushNamed(routeName,
    arguments: {'stationId': id});
  }

  @override
  initState() {
    super.initState();
    _getStations();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: stations.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(stations[index].param.paramName),
          subtitle: Text(stations[index].param.paramFormula),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => {Navigator.push(context,MaterialPageRoute(builder: (context)=> ParamHistoryScreen(id:stations[index].id)))},
        );
      },
    );
  }
}
