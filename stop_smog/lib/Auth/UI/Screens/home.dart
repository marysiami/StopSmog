import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fcharts/fcharts.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/UI/Screens/sign_in.dart';
import 'package:stop_smog/Auth/UI/Widgets/loading.dart';
import 'package:stop_smog/Auth/Util/state_widget.dart';
import 'package:stop_smog/Blog/Blog_menu_page.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Infographic/Infographic_Page.dart';
import 'package:stop_smog/Post/New_point_steps.dart';
import 'package:stop_smog/Post/StationList_Filter.dart';
import 'package:stop_smog/Quiz/Api.dart';
import 'package:stop_smog/Quiz/quiz_page.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

import '../../../app_localizations.dart';

var api = Api("stations");
List<Map<dynamic, dynamic>> list = new List();

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  bool _loadingVisible = false;
  List<int> stationsList = new List();
  List<String> stationListNames = new List();

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Future.value(currentUser);
  }

  void getStations() async {
    FirebaseUser currentUser = await getCurrentFirebaseUser();
    DocumentReference documentReference =
        Firestore.instance.collection("stations").document(currentUser.uid);
    DocumentSnapshot ds = await documentReference.get();
    bool isLiked = ds.exists;
    if (isLiked) {
      var currentItem = list.firstWhere((x) => x["id"] == currentUser.uid);
      stationsList =
          (jsonDecode(currentItem["stations"]) as List<dynamic>).cast<int>();
      stationListNames =
          (jsonDecode(currentItem["stationsNames"]) as List<dynamic>)
              .cast<String>();
    }
  }

  @override
  void initState() {
    super.initState();
    var result = api.getDataCollection().then((value) => HandleValue(value));
    getStations();
  }

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }

      const myData = [
        ["A", "✔"],
        ["B", "❓"],
        ["C", "✖"],
        ["D", "❓"],
        ["E", "✖"],
        ["F", "✖"],
        ["G", "✔"],
      ];

      Container lineChart = new Container(
        child: new LineChart(
          lines: [
            new Line<List<String>, String, String>(
              data: myData,
              xFn: (datum) => datum[0],
              yFn: (datum) => datum[1],
            ),
          ],
          chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
        ),
        height: 250,
      );

      final signOutButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          focusColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            StateWidget.of(context).logOutUser();
          },
          padding: EdgeInsets.all(12),
          color: Theme.of(context).primaryColor,
          child: Text(AppLocalizations.of(context).translate('SignOut'),
              style: TextStyle(color: Colors.white)),
        ),
      );

      final email = appState?.firebaseUserAuth?.email ?? '';
      final firstName = appState?.user?.firstName ?? '';
      final lastName = appState?.user?.lastName ?? '';
      String names = "";
      for (var st in stationListNames) {
        names = st + ", ";
      }
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            title: Text("Let's Stop Smog Now!"),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  accountName: new Text(
                    firstName + " " + lastName,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: new Text(email),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: new Text(
                        firstName.substring(0, 1) + lastName.substring(0, 1),
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.pin_drop,
                      color: Colors.indigoAccent,
                      size: 30.0,
                    ),
                    title: Text('Dodaj punkt'),
                    onTap: () => selectItem(context, NewPointSteps.routeName),
                  ),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.map,
                        color: Colors.teal,
                        size: 30.0,
                      ),
                      title: Text(AppLocalizations.of(context)
                          .translate('AllStations')),
                      onTap: () =>
                          selectItem(context, StationFilter.routeName)),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.thumbs_up_down,
                        color: Colors.amber,
                        size: 30.0,
                      ),
                      title: Text('Quiz'),
                      onTap: () => selectItem(context, QuizPage.routeName)),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      title:
                          Text(AppLocalizations.of(context).translate('Info1')),
                      subtitle: Text("Infografika"),
                      onTap: () =>
                          {selectItem(context, InfographicPage1.routeName)}),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      title:
                          Text(AppLocalizations.of(context).translate('Info2')),
                      subtitle: Text("Infografika"),
                      onTap: () =>
                          {selectItem(context, InfographicPage2.routeName)}),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      title:
                          Text(AppLocalizations.of(context).translate('Info3')),
                      subtitle: Text("Infografika"),
                      onTap: () =>
                          {selectItem(context, InfographicPage3.routeName)}),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.devices_other,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      title: Text(
                          AppLocalizations.of(context).translate('Devices')),
                      onTap: () =>
                          selectItem(context, DeviceMenuPage.routeName)),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Colors.indigoAccent,
                      size: 30.0,
                    ),
                    title: Text('Blog'),
                    onTap: () => selectItem(context, BlogMenuPage.routeName),
                  ),
                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.movie,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      title: Text(
                          AppLocalizations.of(context).translate('Movies')),
                      onTap: () =>
                          selectItem(context, YoutubePlayerPage.routeName)),
                ),
                signOutButton
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back5.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: LoadingScreen(
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      child: ListTile(
                        title: Text(
                          "Witaj \n$firstName!",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text("Masz wybrane następujące stacje: " + names),
                      ),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 50),
                    ),
                    new Container(
                        child: getBoxWithData(
                            Colors.teal,
                            Colors.grey,
                            Colors.teal,
                            "Nazwa stacji testowa",
                            "Nazwa miasta test",
                            "PM 2,5",
                            "100,222",
                            context,
                            lineChart)),
                    new Container(
                        child: getBoxWithData(
                            Colors.redAccent,
                            Colors.black,
                            Colors.red,
                            "Nazwa stacji testowa2",
                            "Nazwa miasta test",
                            "PM 10",
                            "177752",
                            context,
                            lineChart)),
                    // SimpleLineChart.withSampleData()
                  ],
                ),
                inAsyncCall: _loadingVisible),
          ));
    }
  }
}

getBoxWithData(
    Color color1,
    Color color2,
    Color back,
    String statnioName,
    String city,
    String paramName,
    String value,
    BuildContext context,
    Container lineChart) {
  return new Container(
      height: 200.0,
      margin: new EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: back,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(colors: [color1, color2]),
      ),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0),
            ),
            new Expanded(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      city,
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                    new SizedBox(
                      height: 8.0,
                    ),
                    new Text(
                      statnioName,
                      style:
                          new TextStyle(fontSize: 12.0, color: Colors.white70),
                    ),
                    new SizedBox(
                      height: 10.0,
                    ),
                    new Row(
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
                            new Text('powietrze jest super czyste',
                                style: new TextStyle(
                                    fontSize: 12.0, color: Colors.white)),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left: 50.0, right: 10.0),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  value,
                                  style: new TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold),
                                ),
                                new Text(
                                  paramName,
                                  style: new TextStyle(
                                      fontSize: 14.0, color: Colors.white70),
                                ),
                                new FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
//                                      return AlertDialog(
//                                          title: new Text("Alert Dialog title"),
//                                        content: SingleChildScrollView(
//                                      child: ListBody(
//                                      children: <Widget>[
//                                          lineChart,
//                                          new FlatButton(
//                                            child: new Text("Close"),
//                                            onPressed: () {
//                                              Navigator.of(context).pop();
//                                            },
//                                          )
//                                        ],),),
//                                        contentPadding: EdgeInsets.all(8.0),
//
//                                      );
                                          return AlertDialog(
                                            title: Text('Rewind and remember'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'You will never be satisfied.'),
                                                  Text(
                                                      'You\’re like me. I’m never satisfied.'),
                                                  lineChart,
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  'Zamknij',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: new Icon(
                                    Icons.history,
                                    color: color1,
                                    size: 30,
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ]),
            )
          ]));
}

HandleValue(QuerySnapshot value) {
  List<DocumentSnapshot> templist;

  templist = value.documents;

  list = templist.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();
  return list;
}
