import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Post_page.dart';

class PostIcon  extends StatelessWidget {

 //TODO: dodać keywords 

  final int id;
  final String title;  
  final Color color;
  final List<String> keyWords;
  final String author;
  final String content;
  final String imageUrl;

  PostIcon(this.id, this.title, this.color, this.keyWords, this.author, this.content, this.imageUrl);
  

  void selectPost(BuildContext ctx){
    Navigator.of(ctx)
    // .push(MaterialPageRoute(builder: (_)
    // { //podkreslenie oznacza, że parametr nie bedzie potrzebny
    //   return PostPage(id,title,keyWords,author,content);
    // }
    // ));
    .pushNamed(
      PostPage.routeName,
      arguments: {'id': id,'title': title,'keyWords': keyWords,'author': author,'content': content,'image': imageUrl}
      );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: ()=>selectPost(context), //nazwa funkcji!
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        title,
//        style: Theme.of(context).textTheme.title
        ),
      decoration: BoxDecoration(gradient: LinearGradient(
        colors: [ color.withOpacity(0.1), color ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(15),
        ),
      )
    );
  }
}
