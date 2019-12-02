import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stop_smog/Post/Models/Station.dart';

import '../app_localizations.dart';
import 'API.dart';
import 'Station_details.dart';

class StationFilter extends StatefulWidget {
  static const routeName = '/stations_filter';
  @override
  _StationFilterState createState() => new _StationFilterState();
}

class _StationFilterState extends State<StationFilter> {
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;
  List stations = new List();

  _StationFilterState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  _getStations() {
    API.getAllStations().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        stations = list.map((model) => Station.fromJson(model)).toList();
        this._getNames();
      });
    });
  }

  @override
  void initState() {
    this._getStations();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: Row(
          children: <Widget>[
            new IconButton(
              icon: _searchIcon,
              onPressed: _searchPressed,
            ),

          ],
        ));
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .stationName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
            title: Text(filteredNames[index].stationName),
            subtitle: Text(filteredNames[index].city == null
                ? filteredNames[index].stationName
                : filteredNames[index].city.name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.of(context)
                    .pushNamed(StationDetails.routeName, arguments: {
                  'id': filteredNames[index].id,
                  'stationName': filteredNames[index].stationName,
                  'gegrLat': filteredNames[index].gegrLat != null
                      ? filteredNames[index].gegrLat
                      : AppLocalizations.of(context).translate('NoInfo'),
                  'gegrLon': filteredNames[index].gegrLon != null
                      ? filteredNames[index].gegrLon
                      : AppLocalizations.of(context).translate('NoInfo'),
                  'city': filteredNames[index].city,
                  'addressStreet': filteredNames[index].addressStreet != null
                      ? filteredNames[index].addressStreet
                      : "",
                }));
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: AppLocalizations.of(context).translate('Search')),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle =
            new Text(AppLocalizations.of(context).translate('Search'));
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = stations;
    List tempList = new List();
    for (int i = 0; i < response.length; i++) {
      tempList.add(response[i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
