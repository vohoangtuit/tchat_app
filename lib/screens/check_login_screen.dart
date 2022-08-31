import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/providers/app_provider.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/main_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
import 'package:tchat/utils/utils.dart';
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
    getIdAccount().then((id) async {
      if(Utils.isNotEmpty(id)??true){
        log('uid:::::: $id');
        await userBloc.getAccountById(id!).then((user){
         // log('user:::::: ${user.toString()}');
          if(Utils.isNotEmpty(user!.uid!)??true){
            replaceScreen(MainScreen(synData: false, profile: user));
          }else{
            openLoginScreen();
          }
        });
      }else{
        log('Not login');
        openLoginScreen();
      }
    });
  }
}
