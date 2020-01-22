import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stop_smog/Post/API.dart';
import 'package:stop_smog/Post/Models/HistoryChartParam.dart';
import 'package:stop_smog/Post/Models/ParamDetails.dart';
import 'package:stop_smog/Post/Models/StationDetails.dart';
import 'package:stop_smog/Post/Models/Values.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../app_localizations.dart';

Map<int, ParamDetails> paramList = new Map();

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
        for (var station in stations) {
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

getBoxWithData(int id, String statnioName, String paramName,
    String paramFormula, ParamDetails param, BuildContext context) {
  var lineChart;
  var text1 = "brak danych", text2 = " ";
  Color color1 = Colors.blueGrey;
  Color color2 = Colors.black;
  Color back = Colors.grey;
  double val  =0.0;
  if (param != null) {
    if (param.values != null) {
      if (param.values.length != 0) {
        if(param.values.first.value !=null) {
          text1 = param.values.first.value.toString();
          text2 = param.values.first.date.toString();
          val = param.values.first.value;
        }
        else {text1 = param.values[1].value.toString();
        text2 = param.values[1].date.toString();
        val =  param.values[1].value;
        }


        bool status = true;
        switch (paramFormula) {
          case "PM10":
            if (val > 100) status = false;
            break;
          case "O3":
            if (val > 180) status = false;
            break;
          case "SO2":
            if (val > 500) status = false;
            break;
          case "NO2":
            if (val >400) status = false;
            break;
        }

        if (status == true) {
          color1 = Colors.lightGreen;
          color2 = Colors.teal;
          back = Colors.green[500];
        } else {
          color1 = Colors.redAccent;
          color2 = Colors.black;
          back = Colors.red;
        }
      }
    }

    if (param.values != null) {
      List<Values> refactoredList = new List<Values>();
      for (var p in param.values) {
        if (p.value != null && p.date != null) refactoredList.add(p);
      }
      var data = refactoredList
          .map((value) =>
              new HistoryParam(value.date, value.value.toInt(), Colors.black))
          .toList();

//    lineChart = new Container(
//      child: new LineChart(
//        lines: [
//          new Line<HistoryParam, String, String>(
//            data: data,
//            xFn: (datum) => datum.date,
//          yFn: (datum) => datum.value.toString(),
//          ),
//
//        ],
//        chartPadding: new EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 30.0),
//      ),
//      height: 300,
//    );

      lineChart = SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          //  title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <LineSeries<HistoryParam, String>>[
            LineSeries<HistoryParam, String>(
                dataSource: data,
                xValueMapper: (HistoryParam sales, _) => sales.date,
                yValueMapper: (HistoryParam sales, _) => sales.value,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]);
    }
  } else {
    lineChart = Text(
      AppLocalizations.of(context).translate('ParametrHistory'),
      style: TextStyle(fontSize: 30, color: Colors.red),
    );
  }

  return new Container(
      height: 170.0,
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
                  "\n" + paramName,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Row(children: <Widget>[
                  Container(child: new Text(
                    statnioName,textAlign: TextAlign.justify,
                    style: new TextStyle(fontSize: 16.0, color: Colors.white70),

                  ),
                  width: 210,)
                  ,
                  new FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  AppLocalizations.of(context).translate('History')  + paramName + " " + paramFormula),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(statnioName + "\n"),
                                    lineChart,
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    AppLocalizations.of(context).translate('Close'),
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
                ]),

                //ParamHistoryHomeScreen(id: id),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    paramFormula,
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
