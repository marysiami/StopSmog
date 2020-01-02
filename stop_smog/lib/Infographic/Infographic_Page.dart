import 'package:flutter/material.dart';

import '../app_localizations.dart';
class InfographicPage1 extends StatelessWidget {
  static const routeName = '/infographic';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              tabs: [
                Text(AppLocalizations.of(context).translate('Info1')),
                Text(AppLocalizations.of(context).translate('Info2')),
                Text(AppLocalizations.of(context).translate('Info3')),
              ],
            ),
            title: Text('Infografiki'),
          ),
          body: TabBarView(
            children: [
              ListView(children: <Widget>[
                Image.asset('assets/info/000.png'),
                Image.asset('assets/info/001.png'),
                Image.asset('assets/info/002.png'),
                Image.asset('assets/info/003.png'),
                Image.asset('assets/info/004.png'),
                Image.asset('assets/info/005.png')
              ]),
              ListView(children: <Widget>[
                Image.asset('assets/info2/info2001.png'),
              ]),
              ListView(children: <Widget>[
                Image.asset('assets/info3/info3001.png'),
                Image.asset('assets/info3/info3002.png'),
                Image.asset('assets/info3/info3003.png'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
