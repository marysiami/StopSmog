import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

import 'Models/Video.dart';

class YoutubePlayerPage extends StatelessWidget {
  static const routeName = '/YoutubeVideo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Filmy o smogu"),
      ),
        body: ListView(
          children: getFilmsListview(context),
          padding: EdgeInsets.only(bottom: 20),
        ));
  }
}

List<Widget> getFilmsListview(BuildContext ctx) {
  final SampleVideoData = const [
    Video(title: "Cały ten smog", url: "https://youtu.be/16SlS7ecIWM"),
    Video(
        title: "Smog i jego konsekwencje", url: "https://youtu.be/SXbbowLXL9o"),
    Video(title: "Smog idzie po ciebie", url: "https://youtu.be/_h4S75k8ivI"),
    Video(
        title: "Smog a samochody - Mity smogowe #1 - Nauka. To lubię.",
        url: "https://youtu.be/lBCclOicHCo"),
    Video(
        title: "Czy smog szkodzi? - Mity smogowe #2 - Nauka. To lubię.",
        url: "https://youtu.be/W8Ad25ByaIw"),
    Video(
        title: "PUNKT KRYTYCZNY Trujące powietrze",
        url: "https://youtu.be/SYeGcIzbBjc")
  ];
  List<Widget> result = [];
  for (Video video in SampleVideoData) {
    List<Widget> film = [
      Padding(
        child: ListTile(
            title: Text(
          video.title,
          style: TextStyle(
              letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        padding: EdgeInsets.all(15),
      ),
      YoutubePlayer(
        context: ctx,
        source: video.url,
        quality: YoutubeQuality.HD,
        aspectRatio: 16 / 9,
        isLive: false,
        autoPlay: false,

//        showThumbnail: true,
      ),
    ];

    result += film;
  }
  return result;
}
