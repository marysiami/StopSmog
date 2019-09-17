import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Post_icon.dart' show PostIcon;
import 'package:stop_smog/Blog/sample_data_blog.dart';

class BlogMenuPage  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blog"),),
      body: GridView(
      padding: const EdgeInsets.all(30),
      children:SampleDataBlog.map((postData)=>PostIcon(
        postData.title,
        postData.color,
        postData.keyWords)).toList(), 
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200, //szerokość
      childAspectRatio: 3/2,
      crossAxisSpacing:20, // odstepy pomiedzy kafelkami wszerz
      mainAxisSpacing: 20, //odstępy pomiedzy kafelkami wys
      ),
    )
    );
  }
}