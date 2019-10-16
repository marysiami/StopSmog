import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Blog_menu_page.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Quiz/Quiz_page.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

import 'Post/New_point_steps.dart';
import 'Post/Station_List.dart';
import 'app_localizations.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text("StopSmog"), centerTitle: true,),
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
                    color: Colors.lightGreenAccent,
                    size: 30.0,
                  ),
                  title: Text('Dodaj punkt'),
                  onTap: () => selectItem(context, NewPointSteps.routeName),
                ),
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
                      Icons.devices_other,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    title: Text(AppLocalizations.of(context).translate('Devices')),
                    onTap: () => selectItem(context, DeviceMenuPage.routeName)),
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
                      Icons.movie,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    title: Text(AppLocalizations.of(context).translate('Movies')),
                    onTap: () =>
                        selectItem(context, YoutubePlayerPage.routeName)),
              ),
              Card(
                child: ListTile(
                    leading: Icon(
                      Icons.map,
                      color: Colors.deepOrangeAccent,
                      size: 30.0,
                    ),
                    title: Text("Stacje"),
                    onTap: () =>
                        selectItem(context, StationListScreen.routeName)),
              )
            ],
          ),
        ));
  }
}
