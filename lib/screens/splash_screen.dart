import 'package:flutter/material.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';

import 'account/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widgetLogo(),
           spaceHeight(20),
            Text('Welcome',style: textBlueLarge(),textAlign: TextAlign.center,)
          ],
        ),
      )),
    );
  }
  @override
  void initState() {
    super.initState();
    checkLogin();

  }
  checkLogin()async{
    // Future.delayed(Duration(seconds: 3),()async{
    //   await floorDB.getUserDao().getSingleUser().then((value){
    //     if(value!=null){
    //    //   print('floorDB.userDao '+value.toString());
    //       Navigator.of(context).pushReplacementNamed(TAG_MAIN_SCREEN);
    //     }else{
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    //     }
    //   });
    // });
  }
}
