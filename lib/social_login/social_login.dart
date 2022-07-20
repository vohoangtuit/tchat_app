
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:tchat/models/user_model.dart';

import '../screens/TChatScreen.dart';
class SocialLoin{
  // todo google
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email','https://www.googleapis.com/auth/contacts.readonly']);
 final FirebaseAuth _auth = FirebaseAuth.instance;
  // todo facebook
  //FacebookAuth _facebookAuth=FacebookAuth.instance;
  AccessToken? _accessToken;
  final TChatScreen? context;
  SocialLoin.getInstance({this.context}){
   // _innitFacebook();
    _initGoogle();
  }
  Future<void> _innitFacebook() async {
  //  await _logOutFaceBook();
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
    //  print('accessToken ${accessToken.token}');
      await FacebookAuth.instance.logOut();// disconnect user
    }else{
   //   print('accessToken null');
    }
  }
  Future<void> _logOutFaceBook() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
  }
  _initGoogle(){
    _googleSignIn.signOut();
  }
  Future<void> loginFB(ValueChanged<UserModel> user ) async {
    context!.showLoading(true);
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      print('credential ${credential.toString()}');
      await _auth.signInWithCredential(credential);
      String id =credential.providerId;

      final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${_accessToken!.token}'));
      final profile = JSON.jsonDecode(graphResponse.body);
   //   print('profile facebook $profile');
      UserModel userModel =UserModel();
      userModel.id =id;
      userModel.email =profile['email'];
      userModel.fullName =profile['name'];
      userModel.photoUrl=profile['picture']['data']['url'];
      userModel.birthday='';
      userModel.phone='';
      userModel.address='';
      userModel.createdAt=DateTime.now().millisecondsSinceEpoch.toString();
      userModel.updatedAt=DateTime.now().millisecondsSinceEpoch.toString();
      userModel.isOnline=false;
      userModel.socialIdType=1;
      user(userModel);

    } else {
      context!.showLoading(false);
     // context!.showMessage('', 'Không thể đăng nhập, vui lòng thử lại');
      Fluttertoast.showToast(msg: 'Can not Login');
      print(result.status);
      print(result.message);
    }
  }

  Future<void> loginGoogle(ValueChanged<UserModel> user_)async{
    context!.showLoading(true);
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      //   GoogleSignInAccount googleSignInAccount = await (_googleSignIn.signIn() as FutureOr<GoogleSignInAccount>);
      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final UserCredential authResult =
      await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      print('user $user');
     // context!.showLoading(false);
      if(user!=null){
     //   print("_user email: " + user.email!);
        UserModel userModel =UserModel();
        userModel.id =user.uid;// todo 8AC6oXq9WAcGm4pZgKjMtqV09d53
        userModel.fullName =user.displayName;
        userModel.email =user.email;
        userModel.photoUrl =user.photoURL;
        userModel.birthday='';
        userModel.phone='';
        userModel.address='';
        userModel.createdAt=DateTime.now().millisecondsSinceEpoch.toString();
        userModel.updatedAt=DateTime.now().millisecondsSinceEpoch.toString();
        userModel.isOnline=false;
        userModel.socialIdType=2;
        user_(userModel);
        context!.showLoading(false);
      }
    } catch (error) {
      context!.showLoading(false);
      Fluttertoast.showToast(msg: 'Can not Login');
      print(error);
    }
  }

}