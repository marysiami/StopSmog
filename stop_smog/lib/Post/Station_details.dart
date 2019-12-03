import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../app_localizations.dart';
import 'Models/City.dart';
import 'Station_details_list.dart';

class StationDetails extends StatefulWidget {
  static const routeName = '/stations_details';

  @override
  State<StatefulWidget> createState() {
    return _StationDetailsextends();
  }
}

class _StationDetailsextends extends State<StationDetails> {
  GoogleMapController mapController;
  final Set<Marker> _markers = Set();

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final id = routeArgs['id'];
    final String stationName = routeArgs['stationName'];
    final String gegrLat = routeArgs['gegrLat'];
    final String gegrLon = routeArgs['gegrLon'];
    final City city = routeArgs['city'];
    final String addressStreet = routeArgs['addressStreet'];
    _markers.add(Marker(
      markerId: MarkerId('newyork'),
      position: LatLng(double.parse(gegrLat), double.parse(gegrLon)),
    ))
    ;
    final LatLng _center = LatLng(double.parse(gegrLat), double.parse(gegrLon));
    var details = StationDetailsListScreen(stationId: id);
    details.createState();

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('StationDetails')),
        ),
        body: ListView(children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                stationName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(addressStreet + ' ' + city.name),
            ),
              margin: EdgeInsets.only(left: 10, right: 10,top: 15)
          ),

              Container(
                child: GoogleMap(
                  markers:_markers ,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  mapType: MapType.normal,
                ),
                height:200,
                  margin: EdgeInsets.all(10)

              ), //tu dodać mapę z google maps


          Container(
              child: Text(
                  AppLocalizations.of(context).translate('MeasuringStations'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
              margin: EdgeInsets.all(10)),
          Container(
            child: details,
          ),
        ]));
  }
}
