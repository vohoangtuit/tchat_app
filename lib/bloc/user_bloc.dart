import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tchat/bloc/base_bloc.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';

class UserBloc extends BaseBloc{
  UserBloc({required super.screen});

  final getAccount = PublishSubject<UserModel?>();
  Stream<UserModel?> get accountStream => getAccount.stream;

  @override
  void dispose() {
    super.dispose();
    getAccount.close();
  }
  Future<void> userLogin(UserModel user,ValueChanged<UserModel>valueUser)async{
    //print('UserBloc login');
   await firebaseService.userLogin(user,(userLogin){
     valueUser(userLogin);
   });
  }
  Future<UserModel?> getProfileFromFirebase(UserModel userModel)async{
    UserModel? account;
    await firebaseService.getProfile(user: userModel).then((user){
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
    await floorDB.getInstance();
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

  Future<void> saveAccount(UserModel user) async {
    await SharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    await floorDB.getInstance();
    await floorDB.userDao!.findUserById(user.id!).then((value) {
      if (value == null) {
        floorDB.userDao!.insertUser(user);
      } else {
        floorDB.userDao!.updateUser(user);
      }
    });
  }
  updateUserDatabase(UserModel user)async{
    String time =DateTime.now().millisecondsSinceEpoch.toString();
    user.lastUpdated=time;
    user.lastLogin=time;
    user.isLogin =true;
    await firebaseService.updateUser(user);
    await updateUserLocalDB(user);
  }
 updateUserLocalDB(UserModel user)async{
    await SharedPre.saveString(SharedPre.sharedPreUSer, jsonEncode(user));
    await floorDB.getInstance();
    await floorDB.userDao!.updateUser(user);
  }
  createUserOnline(String myId,UserModel user, bool online){
    firebaseService.createUserOnline(myId, user, online);
  }

}