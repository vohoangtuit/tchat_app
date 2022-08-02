import 'package:flutter/material.dart';
import 'package:tchat/controller/my_router.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/screens/main_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
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
    checkLogin();
  }
  checkLogin()async{
    await initConfig();

    await SharedPre.getBoolKey(SharedPre.sharedPreIsLogin).then((value){
      if(value!=null){
        log('value $value');
        if(value){
         // Navigator.pushReplacementNamed(context, myRouterMain,arguments:false);
         getAccountFromFloorDB().then((account) => {
           replaceScreen(MainScreen(synData: false, profile: account))
         });
          //replaceScreen(screen)
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }
    });
  }
}
