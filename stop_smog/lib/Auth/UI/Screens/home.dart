import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/UI/Screens/home_details.dart';
import 'package:stop_smog/Auth/UI/Screens/sign_in.dart';
import 'package:stop_smog/Auth/UI/Widgets/loading.dart';
import 'package:stop_smog/Auth/Util/state_widget.dart';
import 'package:stop_smog/Blog/Blog_menu_page.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Infographic/Infographic_Page.dart';
import 'package:stop_smog/Post/StationList_Filter.dart';
import 'package:stop_smog/Quiz2/Quiz2Main.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

import '../../../app_localizations.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();

  static const routeName = '/home';
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  bool _loadingVisible = false;

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  getStateNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context)
      {
        // return object of type Dialog
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('Attention')),
          content:
          SingleChildScrollView(child: Text(AppLocalizations.of(context).translate('NoNet') )),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('Close'),
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStateNet();
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
      String shortName = "";
      if (firstName != "" && lastName != "") {
        shortName = firstName.substring(0, 1) + lastName.substring(0, 1);
      }

      if (appState.stationNames != null) {
        if (appState.stationNames.length > 0) {
          for (var st in appState?.stationNames) {
            names += st.toString() + "\n";
          }
          if (names != null) {
            finalNames =AppLocalizations.of(context).translate('HaveStation')  + names;

            final stationIds = appState?.stationsId;
            for (var id in stationIds) {
              var index = stationIds.indexOf(id);
              details = ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: stationIds.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HomeDetailsListScreen(
                        stationId: id,
                        stationName: appState?.stationNames[index]);
                  });
            }

          }
        }
      } else {
        finalNames =
            AppLocalizations.of(context).translate('NoStation');
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
                    child: new Text(shortName, style: TextStyle(fontSize: 20)),
                  ),
                ),
//                Card(
//                  child: ListTile(
//                    leading: Icon(
//                      Icons.pin_drop,
//                      color: Colors.indigoAccent,
//                      size: 30.0,
//                    ),
//                    title: Text('Moje punkty'),
//                    onTap: () => selectItem(context, NewPointSteps.routeName),
//                  ),
//                ),
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
//                Card(
//                  child: ListTile(
//                      leading: Icon(
//                        Icons.thumbs_up_down,
//                        color: Colors.amber,
//                        size: 30.0,
//                      ),
//                      title: Text('Quiz'),
//                      onTap: () => selectItem(context, QuizPage.routeName)),
//                ),
                Card(
                  child: ListTile(
                      leading: Icon(
                        Icons.thumbs_up_down,
                        color: Colors.lightGreen,
                        size: 30.0,
                      ),
                      title: Text('Quiz'),
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
                          subtitle: Text(
                            finalNames,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 18),
                          ),
                        ),
                        margin:
                            new EdgeInsets.only(left: 10, right: 10, top: 60)),

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
