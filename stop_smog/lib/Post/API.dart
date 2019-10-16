
import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrlStations = "http://api.gios.gov.pl/pjp-api/rest/station/findAll";

class API {
  static Future getAllStations() {
    return http.get(baseUrlStations);
  }
}