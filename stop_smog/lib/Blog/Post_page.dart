import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget{
  static const routeName = '/post'; 

  @override
  Widget build (BuildContext context){
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,Object>; //argumenty z RouteName (routes w main.dart)
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final keyWords = routeArgs['keyWords'];
    final author = routeArgs['author'];
    final content = routeArgs['content'];
    final imageUrl  = routeArgs['image'];

    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: <Widget>[
        Padding(child: ListTile(
            title: Text(title, style: TextStyle(letterSpacing: 3, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
        ),
          padding:  EdgeInsets.all(20),),
        CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: imageUrl,
        ),
        Padding(child: ListTile(
          title: Text(author, style: TextStyle(letterSpacing: 3,fontSize: 10 ),textAlign: TextAlign.center,)
        ),
        padding:  EdgeInsets.all(1),),

        Padding(
          child: Text(content, style: TextStyle(fontSize: 14 )),
          padding:  EdgeInsets.only(right: 20, left:20),
        )
      ],)
    );
    
  }
}