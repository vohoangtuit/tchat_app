

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tchat/bloc/user_bloc.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

import 'database/firestore_database.dart';


//typedef Int2VoidFunc = void Function(UserModel userModel);
class FirebaseUpload{
  final TChatBaseScreen screen;
  FirebaseUpload({required this.screen});
  Future uploadFileAvatar(UserBloc bloc,UserModel user,File avatarImageFile,VoidCallback success) async {
    Reference reference = FirebaseStorage.instance.ref().child(FirebaseService.getStringPathAvatar(user.id!));
    UploadTask uploadTask = reference.putFile(avatarImageFile);
    screen.showLoading(true);
    try {
      TaskSnapshot snapshot = await uploadTask;
        await snapshot.ref.getDownloadURL().then((value) {
          if(value.isNotEmpty){
            user.photoUrl =value;
              bloc.updateUserDatabase(user);
            screen.showLoading(false);
            success();
          }
        });

    } on FirebaseException catch (e) {
      screen.showLoading(false);
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }

  }
   Future uploadFileCover(UserBloc bloc,UserModel user,File avatarImageFile,VoidCallback success) async {
    Reference reference = FirebaseStorage.instance.ref().child(FirebaseService.getStringPathCover(user.id!));
    UploadTask uploadTask = reference.putFile(avatarImageFile);
    screen.showLoading(true);
    try {
      TaskSnapshot snapshot = await uploadTask;
      await snapshot.ref.getDownloadURL().then((value) {
       // print('value upload value ${value.toString()}');
        if(value.isNotEmpty){
          user.cover =value;
            bloc.updateUserDatabase(user);
          screen.showLoading(false);
          success();
        }

      });

    } on FirebaseException catch (e) {
      screen.showLoading(false);
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }

  }
}