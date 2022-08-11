import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/bloc/message_bloc.dart';
import 'package:tchat/bloc/user_bloc.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/general/base_dialog.dart';
import 'package:tchat/general/genneral_screen.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';

abstract class TChatBaseScreen<T extends StatefulWidget>
    extends GeneralScreen<T> {
  bool isOnline = true;
  bool? isLoading = false;
  bool firstLoad = true;
  bool endData = false;

  FirebaseService firebaseService = FirebaseService.getInstance();

   UserModel account = UserModel();
  SharedPre sharedPre = SharedPre();

  bool isLogin = false;
  Dialog? dialog;
  BaseDialog? baseDialog;
  late UserBloc userBloc;
  late MessageBloc messageBloc;
  @override
  initAll(){
    initBloc();
    super.initAll();
    initOther();
  }
   initBloc(){
    userBloc =UserBloc(screen: this);
    messageBloc =MessageBloc(screen: this);
    SharedPre.getInstance();
  //  log('${getNameScreenOpening()} initBloc()');
  }
  initOther(){
    getAccountDB();
  }

  @override
  void disposeAll() {
    isLoading = false;
    firstLoad = true;
    endData = false;
    super.disposeAll();
  }

  Future<String?> getIdAccount() async {
    return SharedPre.getStringKey(SharedPre.sharedPreID);
  }
  saveAccountToDB(UserModel user) async {
    await  userBloc.saveAccount(user);
    getAccountDB();
  }
  updateUserDatabase(UserModel user) async {
    await userBloc.updateUserDatabase(user);
  }

  Future<UserModel> getAccountDB() async {
    userBloc.getAccountNotStream().then((value){
      if(value!=null){
        if (mounted) {
          setState(() {
            account = value;
          });
        }
      }
    });
    return account;
  }

   logOut() async {
    await SharedPre.clearData();
    await messageBloc.deleteAllLastMessage();
    replaceScreen(const LoginScreen());
  }
  openLoginScreen(){
    replaceScreen(const LoginScreen());
  }
}
