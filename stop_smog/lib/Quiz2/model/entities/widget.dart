import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';

class WidgetData {
  WidgetData({
    @required this.name,
    @required this.description,
    @required this.link,
    @required this.id
  });

  WidgetData.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String,
        link = json['link'] as String,
        id = json['id'] as int;

  final String name;
  final String description;
  final String link;
  final int id;
}
