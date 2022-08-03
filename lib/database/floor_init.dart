import 'package:tchat/database/last_message_dao.dart';
import 'package:tchat/database/tchat_database.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tchat/models/user_model.dart';
class FloorDatabase {
  static FloorDatabase? _instance;
  static TChatDatabase? database;
  static UserDao? userDao;
  static LastMessageDao? lastMessageDao;
  static Future<FloorDatabase> getInstance() async {
    _instance??=FloorDatabase();
    database ??= await $FloorTChatDatabase.databaseBuilder('TChatApp.db').build();
    userDao ??= database!.userDao;
    lastMessageDao ??= database!.lastMessageDao;
    return _instance!;
  }
   _init()async{
    database = await $FloorTChatDatabase.databaseBuilder('TChatApp.db').build();
    userDao = database!.userDao;
  }
  user() =>userDao;
  lastMessage() =>lastMessageDao;
  // Future<UserModel?>findUserById(String id)async{
  //  return await userDao!.findUserById(id);
  // }
  // insertUser(UserModel user)async{
  //   await userDao!.insertUser(user);
  // }
}