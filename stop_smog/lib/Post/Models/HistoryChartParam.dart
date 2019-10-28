import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;

class HistoryParam {
  final String date;
  final int value;
  final charts.Color color;

  HistoryParam(this.date, this.value, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}