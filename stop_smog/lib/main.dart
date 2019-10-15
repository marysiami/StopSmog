import 'package:flutter/material.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Devices/Device_page.dart';
import 'package:stop_smog/home_page.dart';

import 'Blog/Blog_menu_page.dart';
import 'Blog/Post_page.dart';
import 'Quiz/Quiz_page.dart';
import 'Video/Youtube_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.grey[100],
        canvasColor: Colors.grey[100],
        fontFamily: 'Raleway',

      ),
      home: HomePage(),  //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
      routes:{
        // '/': (ctx) =>HomePage(), //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
        BlogMenuPage.routeName: (ctx) => BlogMenuPage(),
        PostPage.routeName: (ctx) => PostPage(),
        DeviceMenuPage.routeName: (ctx) => DeviceMenuPage(),
        DevicePage.routeName: (ctx) => DevicePage(),
        HomePage.routeName:(ctx) => HomePage(),
        QuizPage.routeName:(ctx) => QuizPage(),
        YoutubePlayerPage.routeName:(ctx) =>YoutubePlayerPage()
      }
    );
  }
}


 