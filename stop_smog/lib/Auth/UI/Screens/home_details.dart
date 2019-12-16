import 'dart:convert';

import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Post/API.dart';
import 'package:stop_smog/Post/Models/HistoryChartParam.dart';
import 'package:stop_smog/Post/Models/ParamDetails.dart';
import 'package:stop_smog/Post/Models/StationDetails.dart';
import 'package:stop_smog/Post/Models/Values.dart';

Map<int,ParamDetails>paramList = new Map();

class HomeDetailsListScreen extends StatefulWidget {
  static const routeName = '/home_repository';
  int stationId;
  String stationName;
  HomeDetailsListScreen(
      {Key key, @required this.stationId, @required this.stationName})
      : super(key: key);

  method(int _id, String _stationName) {
    stationName = _stationName;
    stationId = _id;
  }

  @override
  _HomeDetailsListScreenState createState() =>
      new _HomeDetailsListScreenState();
}

class _HomeDetailsListScreenState extends State<HomeDetailsListScreen> {
  var stations = new List<StationDetails>();

  _getStations() {
    API.getStationDetails(widget.stationId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stations = list.map((model) => StationDetails.fromJson(model)).toList();
        for(var station in stations){
          var param;
          API.getParamDetails(station.id).then((response) {
            setState(() {
              param = ParamDetails.fromJson(json.decode(response.body));
              paramList[station.id] = param;
            });
          });
        }
      });
    });
  }

  void selectItem(BuildContext ctx, String routeName, int id) {
    Navigator.of(ctx).pushNamed(routeName, arguments: {'stationId': id});
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
    var param;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: stations.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        param = paramList[stations[index].id];
        return new Container(
          child: getBoxWithData(
              stations[index].id,
              widget.stationName,
              stations[index].param.paramName.toUpperCase(),
              stations[index].param.paramFormula,
              param,
              context),
        );
      },
    );
  }
}

getBoxWithData(int id, String statnioName, String city, String paramName, ParamDetails param,
    BuildContext context) {

  var lineChart;

  var text1 = "brak danych", text2 = " ";
//  Color color1 = Colors.redAccent;
//  Color color2 = Colors.black;
//  Color back = Colors.red;

  Color color1 = Colors.blueGrey;
  Color color2 = Colors.black;
  Color back = Colors.grey;

if(param != null){
  if (param.values != null) {
    if (param.values.length != 0) {
      text1 = param.values.first.value.toString();
      text2 = param.values.first.date.toString();
      color1 = Colors.lightGreen;
      color2 = Colors.teal;
      back = Colors.green;
    }
  }

  if (param.values  != null) {
    List<Values> refactoredList = new List<Values>();
    for (var p in param.values) {
      if (p.value != null && p.date != null) refactoredList.add(p);
    }
    var data = refactoredList
        .map((value) =>
    new HistoryParam(value.date, value.value.toInt(), Colors.black))
        .toList();
    lineChart = new Container(
      child: new LineChart(
        lines: [
          new Line<HistoryParam, String, String>(
            data: data,
            xFn: (datum) => datum.date,
          yFn: (datum) => datum.value.toString(),
          ),

        ],
        chartPadding: new EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 30.0),
      ),
      height: 300,
    );
  }
}
else{
  lineChart = Text("Brak historii parametru", style: TextStyle(fontSize: 30, color: Colors.red),);
}


  return new Container(
      height: 180.0,
      margin: new EdgeInsets.all(20.0),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: back,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(colors: [color1, color2]),
      ),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
            ),
            new Expanded(
                child: new ListView(
              children: <Widget>[
                new Text(
                  "\n" + city,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Text(
                  statnioName,
                  style: new TextStyle(fontSize: 16.0, color: Colors.white70),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 240),
                  child: new FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Historia ' + paramName),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(statnioName),
                                    lineChart,
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'Zamknij',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: new Icon(
                      Icons.history,
                      color: color1,
                      size: 30,
                    ),
                  ),
                ),
                new SizedBox(
                  height: 10.0,
                ),
                //ParamHistoryHomeScreen(id: id),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    paramName,
                    style: new TextStyle(fontSize: 10.0, color: Colors.white70),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    text1,
                    style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      text2,
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    )),
              ],
            ))
          ]));
}
