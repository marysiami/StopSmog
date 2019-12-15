import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_smog/Quiz2/pages/quiz_page/quiz_page.dart';
import 'model/model.dart';

class Quiz2Main extends StatelessWidget {

  static const routeName = '/Quiz2';
  const Quiz2Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: QuizLoader()),
      ],
      child: MaterialApp(
        home: QuizPage(),
      ),
    );
  }
}
