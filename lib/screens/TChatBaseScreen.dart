import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/firebase/database/realtime_database.dart';
import 'package:tchat/firebase/notification/notification_controller.dart';
import 'package:tchat/general/genneral_screen.dart';
import 'package:tchat/models/last_message_model.dart';
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
  FloorDatabase floorDB=FloorDatabase();

  late SharedPreferences prefs;
  late UserModel account=UserModel();
  // UserModel? myProfile;
   SharedPre sharedPre=SharedPre();

  bool isLogin = false;
  Dialog? dialog;

  @override
  void initAll() {
    super.initAll();
    //initConfig();
    getAccountFromFloorDB();
  }
  initConfig() async {
    await  floorDB.getInstance();
    await SharedPre.getInstance();
    prefs = await SharedPreferences.getInstance();
    //log('initConfig');
   // await  getAccountFromFloorDB();
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
    await floorDB.userDao!.findUserById(user.id!).then((value)  {
      if(value==null){
       // print('InsertUser');
        floorDB.userDao!.insertUser(user);

      }else{
     //   print('updateUser');
        floorDB.userDao!.updateUser(user);
      }
    });
    getAccountFromFloorDB();
  }
  updateUserDatabase(UserModel user)async{
    await SharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    floorDB.userDao!.updateUser(user);
    if(mounted){
      setState(() {
        account =user;
      });
    }

  }
Future<UserModel>getAccountFromFloorDB()async{
  await initConfig();
    if(account.id==null){
      await floorDB.userDao!.getSingleUser().then((value) {
        if(value!=null){
          account =value;
          if(mounted){
            setState(() {
              account =value;
            });
          }
        }
      });
    }
    return account;
  }
   updateLastMessageByID(LastMessageModel message) async{
    await floorDB.lastMessageDao!.getLastMessageById(message.idReceiver!).then((value){
      if(value!=null){
        message.idDB =value.idDB;
        floorDB.lastMessageDao!.updateLastMessageById(message).then((value) {
        });
      }else{
        floorDB.lastMessageDao!.insertMessage(message).then((value) => {
        });
      }
    });
  }
  void logOut()async{
     await initConfig();
     await SharedPre.clearData();
     await floorDB.userDao!.deleteAllUsers();
     replaceScreen(const LoginScreen());
  }

}
