import 'package:flutter/material.dart';

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
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromARGB(0xFF,0xB1,0x8E,0xA6),
          ),
          body2: TextStyle(color: Color.fromARGB(0xFF,0xB1,0x8E,0xA6),
        ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold)


        )
      ),
      home: BlogMenuPage(),  //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
      routes:{
        // '/': (ctx) =>HomePage(), //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
        BlogMenuPage.routeName: (ctx) => BlogMenuPage(),
        PostPage.routeName: (ctx) => PostPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold( //Scaffold definiuje strone 
      appBar: AppBar(
     
        title: Text(widget.title),
      ),
      body: Center(       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
 