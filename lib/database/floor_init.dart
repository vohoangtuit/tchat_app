import 'package:tchat/database/tchat_database.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
class FloorInitialize {
  TChatDatabase? database;
  UserDao? userDao;

   init()async{
    database = await $FloorTChatDatabase.databaseBuilder('TChatApp.db').build();
    userDao = database!.userDao;
  }
}