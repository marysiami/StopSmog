import 'package:flutter/material.dart';

class Post{
  final int id;
  final String title;
  final List<String> keyWords;
  final String author;
  final String content;
  final String imageUrl;

  const Post({ 
    @required this.id,
    @required this.title,
    @required this.keyWords,
    @required this.author,
    @required this.content,
    @required this.imageUrl});

}