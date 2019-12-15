import 'package:firebase_auth/firebase_auth.dart';
import 'package:stop_smog/Auth/Models/settings.dart';
import 'package:stop_smog/Auth/Models/user.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;
  List<String> stationNames;
  List<int>stationsId;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
    this.stationNames,
    this.stationsId
  });
}