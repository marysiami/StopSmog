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
          title: Text('Quiz'),
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
         {'text': 'Marysia', 'score': 10},
         {'text': 'Maria', 'score': 5},
         {'text': 'Isia', 'score': 3},
         {'text': 'Marcepanek', 'score': 1},
       ],
     },
     {
       'questionText': 'Najlepszy piesek na tej planecie to?',
       'answers': [
         {'text': 'Verdi', 'score': 3},
         {'text': 'Myszka', 'score': 11},
         {'text': 'Kizia', 'score': 5},
         {'text': 'Kora', 'score': 9},
       ],
     },
     {
       'questionText': 'Czy napiszę inżynierkę w terminie?',
       'answers': [
         {'text': 'tak', 'score': 1},
         {'text': 'si', 'score': 1},
         {'text': 'da', 'score': 1},
         {'text': 'qui', 'score': 1},
       ],
     },
   ];
   return _questions;
 }
 
  HandleValue(QuerySnapshot value) {
    var docs = value.documents.first.data["Question"];
    log('docs: $docs');
    return value.documents;
}