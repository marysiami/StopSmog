import 'dart:convert';

import 'package:flutter/services.dart';

import 'entities/entities.dart';

class QuizLoader {
  Future<List<Quiz>> load() async {
    var widgets = (jsonDecode(
            await rootBundle.loadString('assets/data/widgets.json')) as List)
        .map<WidgetData>(
            (dynamic json) => WidgetData.fromJson(json as Map<String, dynamic>))
        .toList();
    var widgetsResult = widgets.where((w) => w.description != "").toList();
    return (widgetsResult..shuffle())
        .sublist(0, 10)
        .map<Quiz>((correct) => Quiz(
              correct: correct,
              others: (widgets..shuffle())
                  .where((w) => w.name != correct.name && w.id == correct.id)
                  .toList()
                  .sublist(0, 3),
            ))
        .toList();
  }
}
