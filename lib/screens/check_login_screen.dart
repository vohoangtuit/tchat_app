import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/screens/main_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
import 'package:tchat/utilities/utils.dart';
import 'package:tchat/widgets/general_widget.dart';


class CheckLoginScreen extends StatefulWidget {
  const CheckLoginScreen({Key? key}) : super(key: key);
  @override
  State<CheckLoginScreen> createState() => _CheckLoginScreenState();
}
class _CheckLoginScreenState extends TChatBaseScreen<CheckLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // color: Colors.blue,
      appBar: appBarWithTitle(context,''),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              color: Colors.white,
              child:  Container(height: 1.0, color: Colors.grey[200]),
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }
  _checkLogin()async{
   await  userBloc.getAccountNotStream().then((user){
      if(user!=null){
        if(Utils.isNotEmpty(user.id)??true){
         replaceScreen(MainScreen(synData: false, profile: user));
        }else{
           openLoginScreen();
        }
      }else{
         openLoginScreen();
      }
    });
  }
}
