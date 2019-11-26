import 'package:flutter/material.dart';

class InfographicPage1 extends StatelessWidget {
  static const routeName = '/infographic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: ListView(children: <Widget>[Image.asset('assets/info1.png')]));
  }
}

class InfographicPage2 extends StatelessWidget {
  static const routeName = '/infographic2';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: ListView(children: <Widget>[Image.asset('assets/info2.png')]));
  }
}

class InfographicPage3 extends StatelessWidget {
  static const routeName = '/infographic3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,),
        body: ListView(children: <Widget>[Image.asset('assets/info3.png')]));
  }
}