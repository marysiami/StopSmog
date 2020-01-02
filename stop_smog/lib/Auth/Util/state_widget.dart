import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stop_smog/Auth/Models/settings.dart';
import 'package:stop_smog/Auth/Models/state.dart';
import 'package:stop_smog/Auth/Models/user.dart';
import 'package:stop_smog/Auth/Util/auth.dart';
import 'package:stop_smog/Quiz/Api.dart';

var api = Api("stations");
List<Map<dynamic, dynamic>> list = new List();

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
    as _StateDataWidget)
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  StateModel state;
  //GoogleSignInAccount googleAccount;
  //final GoogleSignIn googleSignIn = new GoogleSignIn();

  List<int> stationsList = new List();
  List<String> stationListNames = new List();
  var stationsListtemp = new List();
 var stationListNamestemp = new List();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }
  HandleValue(QuerySnapshot value) {
    List<DocumentSnapshot> templist;

    templist = value.documents;

    list = templist.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data;
    }).toList();
    return list;
  }
  void getStations() async {
    FirebaseUser currentUser = await Auth.getCurrentFirebaseUser();
    if(currentUser != null){
      DocumentReference documentReference =
      Firestore.instance.collection("stations").document(currentUser.uid);
      DocumentSnapshot ds = await documentReference.get();
      bool isLiked = ds.exists;
      if (isLiked) {
        var currentItem = list.firstWhere((x) => x["id"] == currentUser.uid);

        stationsListtemp  = currentItem["stations"].split(',').map((String text){
          text = text.replaceAll("]", "");
          text = text.replaceAll("[", "");
          return int.parse(text);
        }).toList();
        stationListNamestemp =currentItem["stationsNames"].split(',').map((String text){
          text = text.replaceAll("]", "");
          text = text.replaceAll("[", "");
          return text;
        }).toList();

        stationsList = stationsListtemp.cast<int>();
        stationListNames = stationListNamestemp.cast<String>();
      }
    }

  }
  Future<Null> initUser() async {
    var result = api.getDataCollection().then((value) => HandleValue(value));
    await getStations();

    FirebaseUser firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    User user = await Auth.getUserLocal();
    Settings settings = await Auth.getSettingsLocal();
    setState(() {
      state.isLoading = false;
      state.firebaseUserAuth = firebaseUserAuth;
      state.user = user;
      state.settings = settings;
      state.stationNames = stationListNames;
      state.stationsId = stationsList;
    });
  }

  Future<void> logOutUser() async {
    await Auth.signOut();
    FirebaseUser firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    setState(() {
      state.user = null;
      state.settings = null;
      state.firebaseUserAuth = firebaseUserAuth;
    });
  }

  Future<void> logInUser(email, password) async {
    String userId = await Auth.signIn(email, password);
    User user = await Auth.getUserFirestore(userId);
    await Auth.storeUserLocal(user);
    Settings settings = await Auth.getSettingsFirestore(userId);
    await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}