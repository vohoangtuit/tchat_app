import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tchat/bloc/base_bloc.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/providers/app_provider.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';

class UserBloc extends BaseBloc with ChangeNotifier{

  UserBloc({required AppProvider appProvider, required TChatBaseScreen screen}) : super(appProvider:appProvider, screen:screen);
  final getAccount = PublishSubject<UserModel?>();

  Stream<UserModel?> get accountStream => getAccount.stream;

  @override
  void dispose() {
    super.dispose();
    getAccount.close();
  }
  Future<void> userLogin(UserModel user,ValueChanged<UserModel>valueUser)async{
   await firebase.userLogin(user,(userLogin){
     valueUser(userLogin);
   });
  }
  Future<UserModel?> getProfileFromFirebase(UserModel userModel)async{
    UserModel? account;
    await firebase.getProfile(user: userModel).then((user){
      account =user;
    });
    return account;
  }
  Future<void> getAccountStream() async {
    UserModel? model;
    await floorDB.getInstance();
    await  floorDB.userDao!.getSingleUser().then((value){
      model =value;
    });
    if(!getAccount.isClosed) {
      getAccount.sink.add(model);
    }
  }
  Future<UserModel?> getAccountNotStream()async{

    UserModel? account;
    try {
      await floorDB.userDao!.getSingleUser().then((value){
        account =value;
      });
    } on Exception catch (exception) {
      screen.log('Exception ${exception.toString()}');
    } catch (error) {
      screen.log('error ${error.toString()}');
    }
    return account;
  }
  Future<UserModel?> getAccountById(String id)async{
    await floorDB.getInstance();
    UserModel? account;
    await floorDB.userDao!.findUserById(id).then((value){
      print('value findUserById ${value!.toString()}');
      account =value;
    });
    // try {
    //   await floorDB.userDao!.findUserById(id).then((value){
    //     print('value findUserById ${value!.id!}');
    //     account =value;
    //   });
    // } on Exception catch (exception) {
    //   screen.log('Exception ${exception.toString()}');
    // } catch (error) {
    //   screen.log('error getAccountById ${error.toString()}');
    // }
    return account;
  }
  Future<List<UserModel>> getAllUser()async{
    await floorDB.getInstance();
    List<UserModel> list =<UserModel>[];
    await floorDB.userDao!.findAllUsers().then((value){

      list =value;
    });
    return list;
  }

  Future<void> saveAccount(UserModel user) async {
    await  sharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    await floorDB.userDao!.findUserById(user.id!).then((value) {
     // print('value::::: ${value!.toString()}');
      if (value != null) {
        print('saveAccount value  ${value.toString()}');
        if(value.idDB==null){
          print('saveAccount insertUser  ${user.toString()}');
          floorDB.userDao!.insertUser(user);
        }else{
          print('saveAccount Update ${user.toString()}');
          user.idDB =value.idDB;
          floorDB.userDao!.updateUser(user);
        }
      } else {
        print('saveAccount insertUser 1 ${user.toString()}');
        floorDB.userDao!.insertUser(user);
      }
    });
  }
  updateUserDatabase(UserModel user)async{
    String time =DateTime.now().millisecondsSinceEpoch.toString();
    user.lastUpdated=time;
    user.lastLogin=time;
    user.isLogin =true;
    await firebase.updateUser(user);
    await updateUserLocalDB(user);
  }
 updateUserLocalDB(UserModel user)async{
    await sharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    await floorDB.userDao!.updateUser(user);
  }
  createUserOnline(String myId,UserModel user, bool online){
    firebase.createUserOnline(myId, user, online);
  }

}