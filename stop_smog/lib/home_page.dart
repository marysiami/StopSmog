import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Blog_menu_page.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Infographic/Infographic_Page.dart';
import 'package:stop_smog/Quiz/Quiz_page.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

import 'Post/New_point_steps.dart';
import 'Post/StationList_Filter.dart';
import 'app_localizations.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  static const myData = [
    ["A", "✔"],
    ["B", "❓"],
    ["C", "✖"],
    ["D", "❓"],
    ["E", "✖"],
    ["F", "✖"],
    ["G", "✔"],
  ];

  Container lineChart =new  Container(child: new LineChart(
    lines: [
      new Line<List<String>, String, String>(
        data: myData,
        xFn: (datum) => datum[0],
        yFn: (datum) => datum[1],
      ),
    ],
    chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
  ),
  height: 250,);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("StopSmog"),
          centerTitle: true,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Maria Zimnoch"),
                accountEmail: new Text("mariazimnoch@email.com"),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text("MZ"),
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
                    title: Text(
                        AppLocalizations.of(context).translate('AllStations')),
                    onTap: () => selectItem(context, StationFilter.routeName)),
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
                    title:
                        Text(AppLocalizations.of(context).translate('Devices')),
                    onTap: () => selectItem(context, DeviceMenuPage.routeName)),
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
                    title:
                        Text(AppLocalizations.of(context).translate('Movies')),
                    onTap: () =>
                        selectItem(context, YoutubePlayerPage.routeName)),
              ),
            ],
          ),
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              child: ListTile(
                  title: Text(
                    "Witaj  Maria!",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Masz wybrane następujące stacje: ...."),
                ),

              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            ),
            new Container(
                child: getBoxWithData(
                    Colors.teal,
                    Colors.amberAccent,
                    Colors.green,
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
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
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
                                                child: Text('Zamknij', style: TextStyle(color: Colors.black),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: new Icon(Icons.history, color: color1, size: 30,) ,
                                ),
                              ]),
                        )
                      ],
                    ),
                  ]),
            )
          ]));
}
