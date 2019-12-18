import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_smog/Auth/UI/Screens/home.dart';
import 'package:stop_smog/Quiz/Api.dart';
import 'package:stop_smog/Quiz2/model/model.dart';
import 'package:stop_smog/Quiz2/pages/quiz_page/selections.dart';

import 'model.dart';
import 'progress.dart';
import 'question.dart';
import 'result_presenter.dart';

String text = "";
String userId = "";
var api = Api("Quiz");
var resultapi = Api("points");
List<Map<dynamic, dynamic>> list = new List();

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Model(
        quizLoader: Provider.of<QuizLoader>(context, listen: false),
      ),
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({Key key}) : super(key: key);

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  Model get _model => Provider.of<Model>(context, listen: false);
  final _resultPresenter = ResultPresenter();

  static const double _horizontalMargin = 16;

  @override
  void initState() {
    super.initState();

    _model.answered.listen((correct) async {
      await _resultPresenter.show(context, model: _model, correct: correct);
      _model.next();
    });
  }

  void selectItem(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Quiz'),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => selectItem(context, "/home")),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final model = Provider.of<Model>(context);
    return SafeArea(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: model.quizListLoaded
            ? model.hasQuiz ? _buildQuiz() : _buildResult()
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildQuiz() {
    return Column(
      children: const [
        Progress(),
        Divider(
          indent: _horizontalMargin,
          endIndent: _horizontalMargin,
          height: 0,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(_horizontalMargin),
            physics: AlwaysScrollableScrollPhysics(),
            child: Question(),
          ),
        ),
        Padding(
          child: Selections(),
          padding: EdgeInsets.symmetric(horizontal: _horizontalMargin),
        ),
      ],
    );
  }

  Widget _buildResult() {
    final model = Provider.of<Model>(context);
//    model
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Gratulacje!",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          Text("Twój wynik to: \n",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          Text(
            '⭕️ ${model.progress.where((p) => p == ProgressKind.correct).length} / 10',
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: model.progress
                .asMap()
                .map((index, p) => MapEntry(
                    index,
                    Text(
                        '${p == ProgressKind.correct ? '⭕️' : '❌'} ${model.quizList[index].correct.name}')))
                .values
                .toList(),
          ),
          const SizedBox(height: 8),
          RaisedButton(
            child: Text('Spróbuj jeszcze raz!'),
            onPressed: model.load,
          ),
          RaisedButton(
              color: Colors.teal,
              child: Text('Sprawdź swoje miejsce w rankingu!'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => getOtherPoints(
                        model.progress
                            .where((p) => p == ProgressKind.correct)
                            .length,
                        context));
              })
        ],
      ),
    );
  }
}

getOtherPoints(int resultScore, BuildContext context) {
  var result =
      resultapi.getDataCollection().then((value) => HandleValue(value));
  addUserPointsDB(resultScore);

  return new AlertDialog(
      title: Text("Wyniki"),
      content: StreamBuilder(
          stream: Firestore.instance.collection('points').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            int i = 1;
            var currentItem = list.firstWhere((x) => x["id"] == userId);
            var index =
                list.indexWhere((x) => x["points"] == currentItem["points"]) +1;
            text = "Gratulacje!\nObecnie zajmujesz " +
                index.toString() +
                " miejsce na " +
                list.length.toString() +"!";
            return new Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Zamknij',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]);
}

Future<FirebaseUser> getCurrentFirebaseUser() async {
  FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  return Future.value(currentUser);
}

void addUserPointsDB(int points) async {
  FirebaseUser currentUser = await getCurrentFirebaseUser();
  DocumentReference documentReference =
      Firestore.instance.collection("points").document(currentUser.uid);
  DocumentSnapshot ds = await documentReference.get();
  bool isLiked = ds.exists;
  if (isLiked) {
    Firestore.instance
        .document("points/${currentUser.uid}")
        .updateData({"points": points.toString(), "id": currentUser.uid});
  } else {
    Firestore.instance
        .document("points/${currentUser.uid}")
        .setData({"points": points.toString(), "id": currentUser.uid});
  }
  userId = currentUser.uid;
}

HandleValue(QuerySnapshot value) {
  List<DocumentSnapshot> templist;

  templist = value.documents;

  list = templist.map((DocumentSnapshot docSnapshot) {
    return docSnapshot.data;
  }).toList();
  list.sort((a, b) => int.parse(a["points"]).compareTo(int.parse(b["points"])));
  return list;
}
