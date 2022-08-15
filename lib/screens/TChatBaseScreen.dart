import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/bloc/message_bloc.dart';
import 'package:tchat/bloc/user_bloc.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/dialogs/dialog_controller.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/firebase/upload.dart';
import 'package:tchat/general/base_dialog.dart';
import 'package:tchat/general/genneral_screen.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
import 'package:tchat/utils/camera_library_open.dart';

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
  BaseDialog baseDialog=BaseDialog();
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
  Future<UserModel> getProfileFromFirebase(UserModel user,{required bool saveLocal} ) async {
    UserModel? userModel;
    await userBloc.getProfileFromFirebase(user).then((user){
      userModel = user;
    });
    if(saveLocal){
      if(userModel!=null){
        saveAccountToDB(userModel!);
      }
    }
    return userModel!;
  }
   updateUserAccount(UserModel user)async{

    await  userBloc.updateUserDatabase(user);
  }

   logOut() async {
    await SharedPre.clearData();
   // await messageBloc.deleteAllLastMessage();
    replaceScreen(const LoginScreen());
  }
  openLoginScreen(){
    replaceScreen(const LoginScreen());
  }
  viewDialogPicture(int type, int chooseFrom,VoidCallback reload) async{// todo type: 1 avatar,2 cover || choose : 1 take picture,2 library
  // log('type: $type choose: $chooseFrom');
    if(type==Const.pictureTypeAvatar){
      if(chooseFrom ==Const.choosePictureCamera){
        CameraLibraryOpening.cameraOpen(type,(file){
          uploadFile(type,file,(){
           reload();
          });
        });
      }else if(chooseFrom ==Const.choosePictureViewPicture){
        await  Future.delayed(Duration.zero, () async {
          DialogController(context).showDialogViewSingleImage(baseDialog, account.photoUrl!);
        });
      }
      else{
        CameraLibraryOpening.libraryOpen(type,(file){
          uploadFile(type,file,(){
            reload();
          });
        });
      }

    }else if(type==Const.pictureTypeCover){
      if(chooseFrom ==Const.choosePictureCamera){
        CameraLibraryOpening.cameraOpen(type,(file){
          uploadFile(type,file,(){
            reload();
          });
        });
      }else if(chooseFrom ==Const.choosePictureViewPicture){
        Future.delayed(Duration.zero, () async {
          DialogController(context).showDialogViewSingleImage(baseDialog, account.cover!);
        });
      }
      else{
        CameraLibraryOpening.libraryOpen(type,(file){
          uploadFile(type,file,(){
            reload();
          });
        });
      }
    }
  }
  uploadFile(int type,File file,VoidCallback reload)async{
   await getAccountDB();
  // log('uploadFile $type');
   if(type ==Const.pictureTypeAvatar){
     FirebaseUpload(screen: this).uploadFileAvatar(userBloc,account, file,(){
       reload();
     });
   }else{
     FirebaseUpload(screen: this).uploadFileCover(userBloc,account, file,(){
       reload();
     });
   }
  }
}
