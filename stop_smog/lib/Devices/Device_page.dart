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


    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(children: [
          CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: imageUrl,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white,),
              textAlign: TextAlign.center,
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Card(
              child: Container(padding:  EdgeInsets.all(10) ,
                child: Text(content),
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 70, top:10, bottom: 30) ,
            child:
              MaterialButton(
                child: Text("ZOBACZ PRODUKT!"),
               // onPressed: _launchURL(links[0]), //TODO: sprawdzić czemu nie działa otwieranie linków w nowej karcie!
                onPressed: (){},
                padding: EdgeInsets.all(20.0),
                color: Colors.amber,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              )
          )


        ]));
  }
}
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
