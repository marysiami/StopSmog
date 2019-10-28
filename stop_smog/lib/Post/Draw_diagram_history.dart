import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Post/Models/Values.dart';

import 'Models/HistoryChartParam.dart';

import 'package:charts_flutter/flutter.dart' as charts;

Drawdiagramhistory(List<Values> param) {
  if (param != null) {
    List<Values> refactoredList = new List<Values>();
    for (var p in param) {
      if (p.value != null && p.date != null) refactoredList.add(p);
    }
    var data = refactoredList
        .map((value) =>
            new HistoryParam(value.date, value.value.toInt(), Colors.indigo))
        .toList();

    var series = [
      new charts.Series(
        id: 'history',
        domainFn: (HistoryParam history, _) => history.date.substring(0,16),
        measureFn: (HistoryParam history, _) => history.value,
        colorFn: (HistoryParam history, _) => history.color,
        data: data,
        labelAccessorFn: (HistoryParam history, _) => history.value.toString(),
      ),
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(15.0),
      child: new SizedBox(
        height: 1200,
        child: chart,
      ),
    );
    return chartWidget;
  } else {
    return Text("Error: no connection");
  }
}
