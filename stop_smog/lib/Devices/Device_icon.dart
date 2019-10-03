import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Post_page.dart';
import 'package:stop_smog/Devices/Device_page.dart';


class DeviceIcon  extends StatelessWidget {
 
  final int id;
  final String title;
  final List<String> links;
  final String content;
  final int deviceCathegoryId;
  final String imageUrl;

  DeviceIcon(this.id,this.title, this.links, this.content, this.deviceCathegoryId, this.imageUrl);
  

  void selectPost(BuildContext ctx){
    Navigator.of(ctx)
    // .push(MaterialPageRoute(builder: (_)
    // { //podkreslenie oznacza, że parametr nie bedzie potrzebny
    //   return PostPage(id,title,keyWords,author,content);
    // }
    // ));
    .pushNamed(
      DevicePage.routeName,
      arguments: {'id': id,'title': title,'links': links,'content': content,'deviceCathegoryId': deviceCathegoryId,'imageUrl': imageUrl}
      );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: ()=>selectPost(context), //nazwa funkcji!
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(13),
        child: Text(
          title,
          style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Nunito Sans'
        ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(gradient: LinearGradient(
          colors: [ Color.fromARGB(0xFF,0xB1,0x8E,0xA6).withOpacity(0.1), Color.fromARGB(0xFF,0xB1,0x8E,0xA6) ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(15),
          ),
      )
    );
  }
}