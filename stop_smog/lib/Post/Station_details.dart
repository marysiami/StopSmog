import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';
import 'Models/City.dart';
import 'Station_details_list.dart';

class StationDetails extends StatelessWidget {
  static const routeName = '/stations_details';

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
          ),
          Row(
            children: <Widget>[
              Card(), //tu dodać mapę z google maps
              Container(
                color: Colors.blue[50],
                height: 80,
                width: 120,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text("  " + gegrLat + "\n" + "  " + gegrLon)
                  ],
                ),
              )
            ],
          ),
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
