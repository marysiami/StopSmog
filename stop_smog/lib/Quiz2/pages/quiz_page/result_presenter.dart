import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_localizations.dart';
import 'model.dart';

class ResultPresenter {
  Future show(
    BuildContext context, {
    @required Model model,
    @required bool correct,
  }) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          final quiz = model.quiz;
          final correctWidget = quiz.correct;
          return AlertDialog(
            title: SizedBox(
              height: 60,
              child: FlareActor(
                'assets/animation/${correct ? 'success' : 'failure'}.flr',
                animation: 's',
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(correctWidget.description),
                const SizedBox(height: 8),
                Text(
                  correctWidget.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                child:  Text(AppLocalizations.of(context).translate('Doc')),
                onPressed: () => launch(correctWidget.link),
              ),
              FlatButton(
                child:  Text(AppLocalizations.of(context).translate('NEXT')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
