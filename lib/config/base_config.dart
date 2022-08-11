import 'package:tchat/database/floor_init.dart';
import 'package:tchat/database/last_message_dao.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

abstract class BaseConfig{
    FloorDatabase floorDB=FloorDatabase();
    FirebaseService  firebaseService = FirebaseService.getInstance();
   // late UserDao userDao;
   // late LastMessageDao lastMessageDao;
  //  final TChatBaseScreen screen;
  BaseConfig.internal(){
    //floorDB.getInstance();
   // screen.s =floorDB.userDao
    //print('BaseConfig');
    // floorDB.getInstance();
     //floorDB.init();
    // userDao =floorDB.userDao!;
    // lastMessageDao =floorDB.lastMessageDao!;
  }
}