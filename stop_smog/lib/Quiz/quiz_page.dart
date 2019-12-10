import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_smog/Quiz/Api.dart';

import './quiz.dart';
import './result.dart';

import 'dart:developer';

var api = Api("Quiz");

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz';

  @override
  State<StatefulWidget> createState() {
    return QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {
  final _questions = GetQuestionList();
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),backgroundColor: Colors.transparent,
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _questionIndex,
          questions: _questions,
        )
            : Result(_totalScore, _resetQuiz,_questionIndex),
    );
  }
}

GetQuestionList  () {
 var result = api.getDataCollection().then((value) => HandleValue(value));
 
  final _questions = const [
     {
       'questionText': 'Kto jest super rowerzystką?',
       'answers': [
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 10},
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjraKo"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 5},
         {'text': 'IsiaIsiaIsiaIsiaIsiaIsiaIsia', 'score': 3},
         {'text': 'MarIsiaIsiaIsiaIsiaIsiaIsiaIsiaIsiaIsiacepanek', 'score': 1},
       ],
     },
     {
       'questionText': 'Najlepszy piesek na tej planecie to?',
       'answers': [
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 3},
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 11},
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 5},
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 9},
       ],
     },
     {
       'questionText': 'Czy napiszę inżynierkę w terminie?',
       'answers': [
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 1},
         {'text': 'Ko"jjjjjjjjjjjjjKo"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjrajjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 1},
         {'text': 'Ko"jjjjjjjjjjjjjjKo"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjrajjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 1},
         {'text': 'Ko"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjra', 'score': 1},
       ],
     },
   ];
   return _questions;
 }
 
  HandleValue(QuerySnapshot value) {
   // var docs = value.documents.first.data["Question"];
    List<DocumentSnapshot> templist;

    templist = value.documents;

    list = templist.map((DocumentSnapshot docSnapshot){
      return docSnapshot.data;
    }).toList();

    return list;
}