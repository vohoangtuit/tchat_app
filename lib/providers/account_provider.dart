import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/models/user_model.dart';

import '../database/floor_init.dart';

class AccountProvider extends ChangeNotifier{
  final FirebaseService firebaseService;
  final FloorDatabase floorDatabase;
  final SharedPreferences sharedPre;

  AccountProvider({required this.firebaseService,required this.floorDatabase,required this.sharedPre});
  late UserModel myProfile ;
  late UserModel userOtherProfile ;

  bool userUpdated =false;

  getMyAccount() => myProfile;
  getOtherAccount() => userOtherProfile;

  getUserUpdated()=>userUpdated;

  setMyAccount(UserModel userModel){
    this.myProfile =userModel;
    print('my accou notifyListeners');
    notifyListeners();
  }
  setOtherAccount(UserModel userModel){
    userOtherProfile =userModel;
    notifyListeners();
  }
  setUserUpdated(bool update){
   userUpdated =update;
  }
}