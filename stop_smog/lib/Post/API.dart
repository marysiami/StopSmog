
import 'dart:async';
import 'package:http/http.dart' as http;


class API {
  static Future getAllStations() {
    return http.get("http://api.gios.gov.pl/pjp-api/rest/station/findAll");
  }
  static Future getStationDetails(int id){
    return http.get('http://api.gios.gov.pl/pjp-api/rest/station/sensors/$id');
  }
  static Future getParamDetails(int id){
    return http.get('http://api.gios.gov.pl/pjp-api/rest/data/getData/$id');
  }
}