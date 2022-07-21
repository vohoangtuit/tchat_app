import 'package:flutter/material.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/allConstants/text_field_constants.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatScreen.dart';
import 'package:tchat/screens/home_page.dart';
import 'package:tchat/social_login/social_login.dart';
import 'package:tchat/utilities/colors.dart';
import 'package:tchat/widgets/general_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends TChatScreen<LoginScreen> {
  late SocialLoin socialLoin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.dimen_30,
              horizontal: Sizes.dimen_20,
            ),
            children: [
              vertical50,
              const Text(
                'Welcome to TChat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vertical30,
              const Text(
                'Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              vertical50,
              Center(child: Image.asset('assets/images/back.png')),
              vertical50,
              Container(width: 200,
              child: buttonSubmitWithColorIcon(
                  'Google', 'google_plus', AppColor.red, () {
                socialLoin.loginGoogle((user) {
                  log('user ${user.toString()}');
                  //_logInSuccess(user);
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
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socialLoin =SocialLoin.getInstance(context: this);
  }
  _logInSuccess(UserModel user)async{
    await realTimeDatabase.loginAccount(user);
  //  replaceScreen(const HomePage());
  //  addScreen(const HomePage());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage()));
  }
}
