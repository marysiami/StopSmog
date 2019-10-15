import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Blog_menu_page.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Quiz/Quiz_page.dart';
import 'package:stop_smog/Video/Youtube_player.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text("Home")),
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
                    title: Text('Devices'),
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
                    title: Text('YouTube movies'),
                    onTap: () =>
                        selectItem(context, YoutubePlayerPage.routeName)),
              )
            ],
          ),
        ));
  }
}
