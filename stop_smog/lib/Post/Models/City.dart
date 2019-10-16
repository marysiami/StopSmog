import 'package:json_annotation/json_annotation.dart';
import 'package:stop_smog/Post/Models/Commune.dart';
part 'City.g.dart';

@JsonSerializable()
class City {
  final int id;
  final String name;
  final Commune commune;

  City({this.id, this.name, this.commune});
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);

}