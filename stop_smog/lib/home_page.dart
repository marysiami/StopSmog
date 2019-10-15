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
    return ListView(
      children: <Widget>[
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
                color: Colors.redAccent,
                size: 30.0,
              ),
              title: Text('Quiz'),
              onTap: () => selectItem(context, QuizPage.routeName)),
        ),

        Card(
          child: ListTile(
              leading: Icon(
                Icons.youtube_searched_for,
                color: Colors.pink,
                size: 30.0,
              ),
              title: Text('Youtube'),
              onTap: () => selectItem(context, YoutubePlayerPage.routeName)),
        )
      ],
    );
  }
}
