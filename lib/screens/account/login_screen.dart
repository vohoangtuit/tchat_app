import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
import 'package:tchat/social_login/social_login.dart';
import 'package:tchat/utilities/colors.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends TChatBaseScreen<LoginScreen> {
  late SocialLoin socialLoin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              children: [
                spaceHeight(50),
                const Text(
                  'Welcome to TChat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        spaceHeight(20),
                const Text(
                  'Login to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceHeight(50),
                // Center(child: Image.asset('assets/images/back.png')),
                // vertical50,
                SizedBox(width: 200,
                child: buttonSubmitWithColorIcon(
                    'Google', 'google_plus', AppColor.red, () {
                  socialLoin.loginGoogle((user) {
                    //log('user ${user.toString()}');
                    _logInSuccess(user);
                  });
                }),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: buttonSubmitWithColorIcon(
                //           'Google', 'google_plus', AppColor.red, () {
                //         socialLoin.loginGoogle((user) {
                //           // analytics.loginBySocial(user.SocialId!,'google');
                //          // _postLogin(user);
                //           log('user ${user.toString()}');
                //         });
                //       }),
                //     ),
                //     spaceWidth(20),
                //    Expanded(
                //       child: buttonSubmitWithColorIcon(
                //           'Facebook', 'facebook', Colors.blue[800]!, () {
                //         socialLoin.loginFB((user) {
                //           //analytics.loginBySocial(user.SocialId!,'facebook');
                //           log('user ${user.toString()}');
                //          // _postLogin(user);
                //         });
                //       }),
                //     ),
                //   ],
                // )
              ],
            ),

          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socialLoin =SocialLoin.getInstance(context: this);
  //  initStore();
  }
  _logInSuccess(UserModel user)async{
  //await firebaseService.userLogin(user);
  await userBloc.userLogin(user);
  await saveAccountToDB(UserModel.fromLogin(user));
  await SharedPre.saveBool(SharedPre.sharedPreIsLogin,true);
 // replaceScreen(const HomeScreen());
  replaceScreen( MainScreen(synData: false,profile: user,));
  }
}
