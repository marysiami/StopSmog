import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Models/Post.dart';
import 'package:stop_smog/Blog/Post_icon.dart' show PostIcon;
import 'package:stop_smog/Blog/sample_data_blog.dart';
import 'package:stop_smog/UI/text_style.dart';

import 'Post_page.dart';

class BlogMenuPage extends StatelessWidget {
  static const routeName = '/blog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog"),
        ),
        body: ListView(children: GetPostsList(context)));
  }
}

List<Widget> GetPostsList(BuildContext context) {

  List<PostIcon> data = SampleDataBlog.map(
    (postData) => PostIcon(postData.id, postData.title, postData.keyWords,
        postData.author, postData.content, postData.imageUrl),
  ).toList();

  List<Container> result = [];
  for (PostIcon post in data) {

    void selectPost(BuildContext ctx){
      Navigator.of(ctx)
          .pushNamed(
          PostPage.routeName,
          arguments: {'id': post.id,'title': post.title,'keyWords': post.keyWords,'content': post.content,'author': post.author,'image': post.imageUrl}
      );
    }
    final icon = new Container(
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(post.imageUrl)),
        ),
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        height: 100.0,
        width: 90.0);

    final postCard = GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap:  ()=>selectPost(context),
        child: new Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF355566),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 20.0),
          ),
        ],
      ),
    ));

    final postCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(110.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            post.title,
            style: Style.headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text(post.author, style: Style.baseTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)),
          new Container(
            child: Row(
              children: <Widget>[
                new Icon(
                  Icons.bookmark,
                  size: 12,
                ),
                new Container(width: 8.0),
                new Text(
                  post.keyWords.reduce((value, element) => value + ', ' + element),
                  style: Style.baseTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
    Container container = new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            postCard,
            icon,
            postCardContent
          ],
        ),
    );

    result.add(container);
  }
  return result;
}
