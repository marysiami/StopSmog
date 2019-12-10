import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        textColor: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: new Text(answerText,
              style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
