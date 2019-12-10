import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stop_smog/Quiz/Api.dart';
var api = Api("Quiz");
var resultapi = Api("points");
List<Map<dynamic, dynamic>> list = new List();
class Result extends StatelessWidget {
  final int resultScore;
  final int questionIndex;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler, this.questionIndex);
  String text = "";
  String userId = "";

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return Future.value(currentUser);
  }

  void addUserPointsDB(int points) async {

    FirebaseUser currentUser = await getCurrentFirebaseUser();
    DocumentReference documentReference = Firestore.instance.collection("points").document(currentUser.uid);
    DocumentSnapshot ds = await documentReference.get();
     bool isLiked = ds.exists;
    if(isLiked){
      Firestore.instance.document("points/${currentUser.uid}").updateData({"points": points.toString(),"id":currentUser.uid});
    }

    else{
    Firestore.instance
        .document("points/${currentUser.uid}")
        .setData({"points": points.toString(),"id":currentUser.uid});
    }


    userId = currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    var result = resultapi.getDataCollection().then((value) => HandleValue(value));
    addUserPointsDB(resultScore);

    return ListView(children: <Widget>[Padding(
      child: Column(
        children: <Widget>[
          Padding(
            child: Text(
              "Your final score is \n $resultScore / $questionIndex",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Dosis"),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(20.0),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('Aprprove'),
            icon: Icon(Icons.thumb_up),
            backgroundColor: Colors.green,
          ),
          Padding(child:FloatingActionButton.extended(
            onPressed: resetHandler,
            label: Text('Restart Quiz'),
            icon: Icon(Icons.refresh),
            backgroundColor: Colors.redAccent,

          ),
            padding:EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 30) ,),
          StreamBuilder(
              stream: Firestore.instance.collection('points').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                int i = 1;
                var currentItem = list.firstWhere((x)=>x["id"] == userId);
                var index = list.indexWhere((x)=>x["points"] == currentItem["points"]);
                text = "Obecnie zajmujesz "+ index.toString() +  " miejsce na " + list.length.toString();
                return new Text(currentItem["points"]);
              }
          )
        ],  
      ),
      padding:  EdgeInsets.only( top: 30, bottom: 30),
    )

    ],);
  }
}
HandleValue(QuerySnapshot value) {
  List<DocumentSnapshot> templist;

  templist = value.documents;

  list = templist.map((DocumentSnapshot docSnapshot){
    return docSnapshot.data;
  }).toList();
  list.sort((a,b)=>int.parse(a["points"]).compareTo(int.parse(b["points"])));
  return list;
}

