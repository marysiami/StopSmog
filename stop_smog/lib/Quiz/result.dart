import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final int questionIndex;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler, this.questionIndex);

//  String get resultPhrase {
//   String resultText = "Twój wynik to $resultScore" ;
////    if (resultScore <= 8) {
////      resultText = 'You are awesome and innocent!';
////    } else if (resultScore <= 12) {
////      resultText = 'Pretty likeable!';
////    } else if (resultScore <= 16) {
////      resultText = 'You are ... strange?!';
////    } else {
////      resultText = 'You are so bad!';
////    }
//    return resultText;
//  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          padding:EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 30) ,)

        ],
      ),
      padding:  EdgeInsets.only( top: 30, bottom: 30),
    );
  }
}
