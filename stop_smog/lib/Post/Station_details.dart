import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/City.dart';

class StationDetails extends StatelessWidget{
  static const routeName = '/stations_details';
  @override

  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments
    as Map<String, Object>;
    final id = routeArgs['id'];
    final String stationName = routeArgs['stationName'];
    final String gegrLat = routeArgs['gegrLat'];
    final String gegrLon = routeArgs['gegrLon'];
    final City city = routeArgs['city'];
    final String addressStreet = routeArgs['addressStreet'];


    return Scaffold(
        appBar: AppBar(
          title: Text("Stations details"),
        ),
          body: ListView(
            children: <Widget>[
              Card(child: ListTile(
                title: Text(stationName),
                subtitle: Text(addressStreet + ' ' + city.name),
                  trailing:Text(gegrLat +", " + gegrLon )
              ),),
              Card()
            ],

          )
        );
  }

}
