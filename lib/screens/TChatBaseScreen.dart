import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/firebase/database/realtime_database.dart';
import 'package:tchat/firebase/notification/notification_controller.dart';
import 'package:tchat/general/genneral_screen.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';

import '../allConstants/firestore_constants.dart';

abstract class TChatBaseScreen  <T extends StatefulWidget> extends GeneralScreen<T> {
  bool isOnline = true;
  bool? isLoading = false;
  bool firstLoad = true;
  bool endData = false;

 // late RealTimeDatabase realTimeDatabase;
  FirebaseDataFunc firebaseDataFunc=FirebaseDataFunc.getInstance();
  late  FloorDatabase floorDB;

  late SharedPreferences prefs;
  late UserModel account;
  late SharedPre sharedPre;

  bool isLogin = false;
  Dialog? dialog;

  @override
  void initAll() {
    super.initAll();
    //initConfig();
  }
  initConfig() async {
    floorDB = await FloorDatabase.getInstance();
    sharedPre = await SharedPre.getInstance();
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
  await SharedPre.saveBool(SharedPre.sharedPreIsLogin,true);
  await SharedPre.saveString(SharedPre.sharedPreID,user.id!);
  await saveAccountToDB(user);
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
    await initConfig();
    return  prefs.getString(FirestoreConstants.id);
  }
  Future<String?> getMePhotoUrl()async{
    await initConfig();
    return  prefs.getString(FirestoreConstants.photoUrl);
  }
  Future<UserModel>getMeAccount()async {
    await initConfig();
  UserModel getMe =UserModel();
  String? id = prefs.getString(FirestoreConstants.id)??"";
  String? photoUel = prefs.getString(FirestoreConstants.photoUrl)??"";
  String? fullName = prefs.getString(FirestoreConstants.displayName)??"";
    getMe.id =id;
    getMe.fullName =fullName;
    getMe.photoUrl =photoUel;
    return getMe;
  }
  Future<UserModel>getAccountFromSharedPre() async{
    Map<String, dynamic>? userShared;
    final String? userStr = await SharedPre.getStringKey(SharedPre.sharedPreUSer);
    if (userStr != null) {
      userShared = jsonDecode(userStr) as Map<String, dynamic>;
    }
    if (userShared != null) {
      if(mounted){
        setState(() {
          account =UserModel.fromJson(userShared!);
        });
      }
    }
    return account;
  }
  saveAccountToDB(UserModel user)async{
    await SharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    await floorDB.user().findUserById(user.id!).then((value)  {
      if(value==null){
       // print('InsertUser');
        floorDB.user().insertUser(user);
      }else{
     //   print('updateUser');
        floorDB.user().updateUser(user);
      }
    });
    getAccountFromFloorDB();
  }
  updateUserDatabase(UserModel user)async{
    await SharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    floorDB.user().updateUser(user);
    if(mounted){
      setState(() {
        account =user;
      });
    }

  }
  Future<UserModel>getAccountFromFloorDB()async{
    await floorDB.user().getSingleUser().then((value) {
      if(value!=null){
        account =value;
        if(mounted){
          setState(() {
            account =value;
          });
        }
      }
    });
    return account;
  }

  void logOut()async{
     await  prefs.clear();
     replaceScreen(const LoginScreen());
  }

}
