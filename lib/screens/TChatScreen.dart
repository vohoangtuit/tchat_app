import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/firebase/database/realtime_database.dart';
import 'package:tchat/general/genneral_screen.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/account/login_screen.dart';

import '../allConstants/firestore_constants.dart';

abstract class TChatBaseScreen  <T extends StatefulWidget> extends GeneralScreen<T> {
  bool isOnline = true;
  bool? isLoading = false;
  bool firstLoad = true;
  bool endData = false;

  late RealTimeDatabase realTimeDatabase;
  bool isLogin = false;
  Dialog? dialog;
  //late NotificationController notificationController;
  late SharedPreferences prefs;
  @override
  void initAll() {
    super.initAll();
    initFireBase();
  }
  initFireBase() async {
    realTimeDatabase = RealTimeDatabase.getInstance(context: context);
    prefs = await SharedPreferences.getInstance();
  }
  @override
  void disposeAll() {
    _disposeBloc();
    isLoading = false;
    firstLoad = true;
    endData = false;
    super.disposeAll();
  }
  void _disposeBloc(){

  }
  saveUser(UserModel user)async{
  await prefs.setString(FirestoreConstants.id, user.id!);
    await prefs.setString(
        FirestoreConstants.displayName, user.fullName ?? "");
    await prefs.setString(
        FirestoreConstants.photoUrl, user.photoUrl ?? "");
  }
  Future<bool> isLoggedIn() async {
    String? id = prefs.getString(FirestoreConstants.id);
    if (id!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  Future<String?> getIdAccount()async{
    await initFireBase();
    return  prefs.getString(FirestoreConstants.id);
  }
  Future<String?> getMePhotoUrl()async{
    await initFireBase();
    return  prefs.getString(FirestoreConstants.photoUrl);
  }
  Future<UserModel>getMeAccount()async {
    await initFireBase();
  UserModel getMe =UserModel();
  String? id = prefs.getString(FirestoreConstants.id)??"";
  String? photoUel = prefs.getString(FirestoreConstants.photoUrl)??"";
  String? fullName = prefs.getString(FirestoreConstants.displayName)??"";
    getMe.id =id;
    getMe.fullName =fullName;
    getMe.photoUrl =photoUel;
    return getMe;
  }
  void logOut()async{
     await  prefs.clear();
     replaceScreen(const LoginScreen());
  }

}
