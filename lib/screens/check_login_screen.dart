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
    // FloorDatabase floorDatabase =FloorDatabase();
    // await floorDatabase.userDao!.findUserById('8AC6oXq9WAcGm4pZgKjMtqV09d53').then((user) =>{
    // log('user:::::: ${user.toString()}')
    // });
    getIdAccount().then((id) async {
      if(Utils.isNotEmpty(id)??true){
        log('id:::::: $id');
        //replaceScreen(MainScreen(synData: false, profile: user));
        await userBloc.personDao.searchById(id!).then((person) {
          log('person:::::: ${person.toString()}');
          //openLoginScreen();
        });
        await userBloc.userDao.findUserById(id).then((user){
          log('user:::::: ${user.toString()}');
        });
      }else{
        log('Not login');
        openLoginScreen();
      }
    });
    // await userBloc.getAllUser().then((value) => {
    // log('all User ::: ${value.toString()}')
    // });

   // await  userBloc.getAccountNotStream().then((user){
   //   //log('user ${user.toString()}');
   //    if(user!=null){
   //      if(Utils.isNotEmpty(user.id)??true){
   //       replaceScreen(MainScreen(synData: false, profile: user));
   //      }else{
   //         openLoginScreen();
   //      }
   //    }else{
   //       openLoginScreen();
   //    }
   // });
  }
}
