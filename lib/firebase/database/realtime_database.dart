import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/models/user_model.dart';

class RealTimeDatabase extends  ChangeNotifier{
  String tagTChatApp = 'TChatApp';
  String tagUser= 'Users';


  late BuildContext? context;

  late DatabaseReference databaseReference;

  late FirebaseApp app;

  late FirebaseDatabase database;

  late SharedPreferences prefs;

  RealTimeDatabase.getInstance({this.context}) {
    initDB();
  }
  void initDB() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase.instance;
    databaseReference = database.ref(tagTChatApp);// todo root
    prefs = await SharedPreferences.getInstance();
  }
  Future<void> loginAccount(UserModel userModel) async {
    var query = databaseReference
        .child('$tagUser/${userModel.id}');
    query.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        DataSnapshot dataValues = snapshot.snapshot;
        Map<dynamic, dynamic> values =
        dataValues.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          databaseReference
              .child(
              '$tagUser/${userModel.id!}')
              .update({'lastLogin':DateTime.now().microsecondsSinceEpoch.toString()});
        });
      } else {
        databaseReference
            .child(
            '$tagUser/${userModel.id}')// todo .push(): id tự generate từ firebase
            .set(userModel.toJson())
            .then((value) => {});
      }
    });
  }
}