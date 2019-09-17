import 'package:flutter/material.dart';

class PostIcon  extends StatelessWidget {
  final String title;  
  final Color color;
  final Set<String> keyWords;

  PostIcon(this.title,this.color,this.keyWords);
  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.all(30),
      child: Text(title),
      decoration: BoxDecoration(gradient: LinearGradient(
        colors: [ color.withOpacity(0.1), color ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(15),
        ),
      
    );
  }
}