import 'package:flutter/material.dart';

class Post{
  final int id;
  final String title;  
  final Color color;
  final List<String> keyWords;
  final String author;
  final String content;
  final String imageUrl;

  const Post({ 
    @required this.id,
    @required this.title,
    this.color = Colors.indigo, //do zmiany
    @required this.keyWords,
    @required this.author,
    @required this.content,
    @required this.imageUrl});

}