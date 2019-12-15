import 'dart:convert';

import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Post/API.dart';
import 'package:stop_smog/Post/Models/ParamDetails.dart';
import 'package:stop_smog/Post/Models/StationDetails.dart';

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

  static const myData = [
    ["A", "✔"],
    ["B", "❓"],
    ["C", "✖"],
    ["D", "❓"],
    ["E", "✖"],
    ["F", "✖"],
    ["G", "✔"],
  ];

  Container lineChart = new Container(
    child: new LineChart(
      lines: [
        new Line<List<String>, String, String>(
          data: myData,
          xFn: (datum) => datum[0],
          yFn: (datum) => datum[1],
        ),
      ],
      chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
    ),
    height: 250,
  );

  @override
  build(context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: stations.length,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return new Container(
          child: getBoxWithData(
              stations[index].param.idParam,
              Colors.redAccent,
              Colors.black,
              Colors.red,
              widget.stationName,
              stations[index].param.paramName.toUpperCase(),
              stations[index].param.paramFormula,
              context,
              lineChart),
        );
      },
    );
  }
}

//new Container(
//child: getBoxWithData(
//Colors.teal,
//Colors.grey,
//Colors.teal,
//"Nazwa stacji testowa",
//"Nazwa miasta test",
//"PM 2,5",
//"100,222",
//context,
//lineChart)),

getBoxWithData(
    int id,
    Color color1,
    Color color2,
    Color back,
    String statnioName,
    String city,
    String paramName,
    BuildContext context,
    Container lineChart) {
  ParamDetails param = new ParamDetails();
  API.getParamDetails(id).then((response) {
    param = ParamDetails.fromJson(json.decode(response.body));
  });
  var text1 = "brak danych", text2 = " ";

  if (param.values != null) {
    if (param.values.length != 0) {
      text1 = param.values.first.value.toString();
      text2 = param.values.first.date.toString();
    }
  }

  return new Container(
      height: 200.0,
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
//                                      return AlertDialog(
//                                          title: new Text("Alert Dialog title"),
//                                        content: SingleChildScrollView(
//                                      child: ListBody(
//                                      children: <Widget>[
//                                          lineChart,
//                                          new FlatButton(
//                                            child: new Text("Close"),
//                                            onPressed: () {
//                                              Navigator.of(context).pop();
//                                            },
//                                          )
//                                        ],),),
//                                        contentPadding: EdgeInsets.all(8.0),
//
//                                      );
                            return AlertDialog(
                              title: Text('Rewind and remember'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('You will never be satisfied.'),
                                    Text(
                                        'You\’re like me. I’m never satisfied.'),
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
                        fontSize: 15.0,
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
                          fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.right,
                    )),
              ],
            ))
          ]));
}
