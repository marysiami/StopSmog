import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/Util/state_widget.dart';
import 'package:stop_smog/Quiz/Api.dart';
import '../app_localizations.dart';
import 'Models/City.dart';
import 'Station_details_list.dart';

var api = Api("stations");

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
  List<Map<dynamic, dynamic>> list = new List();
  StateModel appState;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Future.value(currentUser);
  }

  void addUserStationDB(String stationId, String name) async {
    List<int> listStation = new List<int>();
    List<String> listStationNames = new List<String>();
    FirebaseUser currentUser = await getCurrentFirebaseUser();
    DocumentReference documentReference =
    Firestore.instance.collection("stations").document(currentUser.uid);
    DocumentSnapshot ds = await documentReference.get();
    bool isLiked = ds.exists;

    if (isLiked) {
      var currentItem = list.firstWhere((x) => x["id"] == currentUser.uid);
      var tempList = currentItem["stations"];
      var tempListNames = currentItem["stationsNames"];

      bool isInBase = false;
      for (var ob in tempList) {
        if (ob == int.parse(stationId)) isInBase = true;
      }
      if (isInBase == false) {
        List<int> stationsList = currentItem["stations"].cast<int>();
        var tempOutput = new List<int>.from(stationsList);
        tempOutput.add(int.parse(stationId));

        List<String> stationListNames = currentItem["stationsNames"].cast<
            String>();
        var tempOutput2 = new List<String>.from(stationListNames);
        tempOutput2.add(name);

        tempList = tempOutput.toString();
        tempListNames = tempOutput2.toString();

        await Firestore.instance
            .document("stations/${currentUser.uid}")
            .updateData({"stations": tempList, "stationsNames": tempListNames});
      } else {
        listStation.add(int.parse(stationId));
        listStationNames.add(name);
        await Firestore.instance.document("stations/${currentUser.uid}")
            .setData({
          "stations": listStation,
          "id": currentUser.uid,
          "stationsNames": listStationNames
        });
      }
      if (appState?.stationNames != null && appState?.stationNames.length > 0) {
        var tempListappState = appState.stationNames;
        tempListappState.add(name);
        appState.stationNames = tempListappState;
      }

      if (appState?.stationsId != null && appState?.stationsId.length > 0) {
        var tempListappStateId = appState.stationsId;
        tempListappStateId.add(int.parse(stationId));
        appState.stationsId = tempListappStateId;
      }
    }
  }

  void removeUserStationDB(String stationId, String name) async {
  List<int> listStation2 = new List<int>();
  List<String> listStationNames2 = new List<String>();
  FirebaseUser currentUser2 = await getCurrentFirebaseUser();
  DocumentReference documentReference2 =
  Firestore.instance.collection("stations").document(currentUser2.uid);
  DocumentSnapshot ds = await documentReference2.get();
  bool isLiked = ds.exists;

  List<int> stationsList = new List();
  List<String> stationListNames = new List();
  var stationsListtemp = new List();
  var stationListNamestemp = new List();

  if(isLiked){
    var currentItem = list.firstWhere((x) => x["id"] == currentUser2.uid);

    stationsListtemp  = currentItem["stations"].split(',').map((String text){
      text = text.replaceAll("]", "");
      text = text.replaceAll("[", "");
      return int.parse(text);
    }).toList();
    stationListNamestemp =currentItem["stationsNames"].split(', ').map((String text){
      text = text.replaceAll("]", "");
      text = text.replaceAll("[", "");
      return text;
    }).toList();

    stationsList = stationsListtemp.cast<int>();
    stationListNames = stationListNamestemp.cast<String>();

    stationsList.remove(int.parse(stationId));
    stationListNames.remove(name);


    await Firestore.instance
        .document("stations/${currentUser2.uid}")
        .updateData({"stations": stationsList.toString(), "stationsNames": stationListNames.toString()});
  }
  }

  HandleValue(QuerySnapshot value) {
    List<DocumentSnapshot> templist;

    templist = value.documents;

    list = templist.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data;
    }).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
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
    ));
    final LatLng _center = LatLng(double.parse(gegrLat), double.parse(gegrLon));
    var details = StationDetailsListScreen(stationId: id);
    details.createState();

    return Scaffold(
        appBar: AppBar(
            title:
                Text(AppLocalizations.of(context).translate('StationDetails')),
            actions: <Widget>[
              // action button
              IconButton(
                  icon: Icon(Icons.add_circle),
                  autofocus: true,
                  tooltip: "Dodaj stację do swojej kolekcji",
                  onPressed: () {
                    String exception = "Dodano stację do kolekcji";
                    Flushbar(
                      title: "Nowa aktywność",
                      message: exception,
                      duration: Duration(seconds: 10),
                    )..show(context);

                    var result = api
                        .getDataCollection()
                        .then((value) => HandleValue(value));
                    addUserStationDB(id.toString(), stationName);
                  }),
              IconButton(
                  icon: Icon(Icons.remove_circle),
                  autofocus: true,
                  tooltip: "Usuń stację ze swojej kolekcji",
                  onPressed: () {
                    String exception = "Usunięto stację z kolekcji";
                    Flushbar(
                      title: "Nowa aktywność",
                      message: exception,
                      duration: Duration(seconds: 10),
                    )..show(context);

                    var result = api
                        .getDataCollection()
                        .then((value) => HandleValue(value));
                    removeUserStationDB(id.toString(), stationName);
                  })
            ]),
        body: ListView(children: <Widget>[
          Card(
              child: ListTile(
                title: Text(
                  stationName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(addressStreet + ' ' + city.name),
              ),
              margin: EdgeInsets.only(left: 10, right: 10, top: 15)),

          Container(
              child: GoogleMap(
                markers: _markers,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                mapType: MapType.normal,
              ),
              height: 200,
              margin: EdgeInsets.all(10)), //tu dodać mapę z google maps

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
