import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Post_page.dart';

class PostIcon extends StatelessWidget {
  //TODO: dodać keywords

  final int id;
  final String title;
  final List<String> keyWords;
  final String author;
  final String content;
  final String imageUrl;

  PostIcon(this.id, this.title, this.keyWords, this.author,
      this.content, this.imageUrl);

  void selectPost(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(PostPage.routeName, arguments: {
      'id': id,
      'title': title,
      'keyWords': keyWords,
      'author': author,
      'content': content,
      'image': imageUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => selectPost(context), //nazwa funkcji!
        splashColor: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Bitter"),),
              Text(keyWords.join('\n'),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, fontFamily: "Raleway"),
              )
            ],
          ),

        ));
  }
}
