import 'package:flutter/material.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Devices/Device_page.dart';

import 'Blog/Blog_menu_page.dart';
import 'Blog/Post_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(  
        primarySwatch: Colors.teal,
        accentColor: Color(0xFFB6E6BD),
        canvasColor: Color.fromARGB(0xFF,0xB2,0xE4,0xD5),
        fontFamily: 'Raleway',
//        textTheme: ThemeData.light().textTheme.copyWith(
//          body1: TextStyle(color: Color.fromARGB(0xFF,0xB1,0x8E,0xA6),
//          ),
//          body2: TextStyle(color: Color.fromARGB(0xFF,0xB1,0x8E,0xA6),
//        ),
//          title: TextStyle(
//            fontSize: 20,
//            fontFamily: 'RobotoCondensed',
//            fontWeight: FontWeight.bold)
//
//
//        )
      ),
      home: DeviceMenuPage(),  //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
      routes:{
        // '/': (ctx) =>HomePage(), //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
        BlogMenuPage.routeName: (ctx) => BlogMenuPage(),
        PostPage.routeName: (ctx) => PostPage(),
        DeviceMenuPage.routeName: (ctx) => DeviceMenuPage(),
        DevicePage.routeName: (ctx) => DevicePage()
      }
    );
  }
}


 