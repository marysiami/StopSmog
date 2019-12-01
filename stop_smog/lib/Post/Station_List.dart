import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stop_smog/Post/Models/Station.dart';

import '../app_localizations.dart';
import 'API.dart';
import 'Station_details.dart';

class StationListScreen extends StatefulWidget {
  static const routeName = '/stations_repository';
  @override
  createState() => _StationListScreenState();
}

class _StationListScreenState extends State {
  var stations = new List<Station>();

  _getStations() {
    API.getAllStations().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stations = list.map((model) => Station.fromJson(model)).toList();
      });
    });
  }

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  initState() {
    super.initState();
    _getStations();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(stations[index].stationName),
              subtitle: Text(stations[index].city == null
                  ? stations[index].stationName
                  : stations[index].city.name),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () =>
                  Navigator.of(context)
                      .pushNamed(StationDetails.routeName, arguments: {
                    'id': stations[index].id,
                    'stationName': stations[index].stationName,
                    'gegrLat': stations[index].gegrLat != null ? stations[index]
                        .gegrLat : AppLocalizations.of(context).translate(
                        'NoInfo'),
                    'gegrLon': stations[index].gegrLon != null ? stations[index]
                        .gegrLon : AppLocalizations.of(context).translate(
                        'NoInfo'),
                    'city': stations[index].city,
                    'addressStreet': stations[index].addressStreet != null
                        ? stations[index].addressStreet
                        : "",
                  })
          );
        }
    );

  }
}
