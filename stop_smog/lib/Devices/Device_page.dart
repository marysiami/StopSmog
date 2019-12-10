import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevicePage extends StatelessWidget {
  static const routeName = '/device';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments
        as Map<String, Object>; //argumenty z RouteName (routes w main.dart)
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final List<String> links = routeArgs['links'];
    final deviceCathegoryId = routeArgs['deviceCathegoryId'];
    final content = routeArgs['content'];
    final imageUrl = routeArgs['imageUrl'];
    final name = routeArgs['name'];

    return Scaffold(
        appBar: AppBar(
          title: Text(name),backgroundColor: Colors.transparent,
        ),
        body: ListView(children: [
          CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: imageUrl,
          ),
          Padding(child: ListTile(
              title: Text(title, style: TextStyle(letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
          ),
            padding:  EdgeInsets.all(20),),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(content,textAlign: TextAlign.justify, style: TextStyle(fontFamily: "Raleway")),
                ),
              )),
          Padding(
              padding:
                  EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 30),
              child: MaterialButton(
                child: ListTile(
                    leading: Icon(Icons.shopping_basket),
                    title: Text("SHOP NOW",textAlign: TextAlign.center,)),
                // onPressed: _launchURL(links[0]), //TODO: sprawdzić czemu nie działa otwieranie linków w nowej karcie!
                onPressed: () {},
                padding: EdgeInsets.all(10.0),
                color: Colors.amberAccent,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ))
        ]));
  }
}

// _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
