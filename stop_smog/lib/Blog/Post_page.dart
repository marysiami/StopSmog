import 'package:flutter/material.dart';

class PostPage extends StatelessWidget{
  static const routeName = '/post'; 
  // final int id;
  // final String title; 
  // final List<String> keyWords;
  // final String author;
  // final String content;

  // PostPage(this.id, this.title, this.keyWords, this.author, this.content);  //cntrl+K+C komentowanie

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
      appBar: AppBar(title: Text(title),
      ),
      body: Center(child: Text(content),)
    );
    
  }
}