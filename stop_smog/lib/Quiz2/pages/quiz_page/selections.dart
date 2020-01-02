import 'package:flutter/material.dart';
import 'package:stop_smog/Quiz2/model/model.dart';

import 'model.dart';

class Selections extends StatelessWidget {
  const Selections({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    if (model.quiz == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: model.quiz.answers
          .map((widget) => _buildButton(
                context,
                widget: widget,
                GoodAsnwer: model.quiz.description
              ))
          .toList(),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    @required String widget,
        @required String GoodAsnwer
  }) {
    final model = Provider.of<Model>(context);
    final currentAnswer = model.currentAnswer;
    final isCorrectAnswer = model.current == ProgressKind.correct;
    final answered = isCorrectAnswer || model.current == ProgressKind.incorrect;
    final isCorrectWidget = answered ? widget == GoodAsnwer : null;
    return RaisedButton(
      child: Text(widget),
      color: currentAnswer == null
          ? null
          : isCorrectWidget
              ? Colors.green
              : (currentAnswer == widget ? Colors.red : null),
      onPressed: () {
        model.answer(widget);
      },
    );
  }
}
