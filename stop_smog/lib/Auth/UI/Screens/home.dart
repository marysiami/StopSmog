import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fcharts/fcharts.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/UI/Screens/home_details.dart';
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
import 'package:stop_smog/Quiz2/Quiz2Main.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

import '../../../app_localizations.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  bool _loadingVisible = false;

  @override
  void initState() {
    super.initState();
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
      var details;
      final email = appState?.firebaseUserAuth?.email ?? '';
      final firstName = appState?.user?.firstName ?? '';
      final lastName = appState?.user?.lastName ?? '';
      String names = "";
      String finalNames = "";
      if(appState?.stationNames != null || appState?.stationNames?.length != 0 ){
        for(var st in appState?.stationNames){
          names += st.toString() + "\n";
        }
        if(names != null){

          finalNames  = "\nMasz wybrane następujące stacje: \n" + names;

          final stationIds = appState?.stationsId;
          details = HomeDetailsListScreen(stationId: stationIds.first, stationName: appState?.stationNames.first,);
          details.createState();
        }
      }
      else {
        finalNames = "Nie masz wybranych stacji, przejdź do listy stacji i wybierz!";
        details = Text(" ");
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
                        Icons.thumbs_up_down,
                        color: Colors.lightGreen,
                        size: 30.0,
                      ),
                      title: Text('Quiz2'),
                      onTap: () => selectItem(context, Quiz2Main.routeName)),
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
                              fontSize: 42, fontWeight: FontWeight.bold),
                        ),
                        subtitle:

                            Text(finalNames,style: TextStyle(fontWeight:FontWeight.bold, color: Colors.orange,fontSize: 18 ),),
                      ),
                      margin: new EdgeInsets.only(left: 10,right: 10,top:60)
                    ),

                    Container(
                      child: details,
                    ),


                    // SimpleLineChart.withSampleData()
                  ],
                ),
                inAsyncCall: _loadingVisible),
          ));
    }
  }
}
