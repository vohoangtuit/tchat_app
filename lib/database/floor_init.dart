import 'package:tchat/database/last_message_dao.dart';
import 'package:tchat/database/tchat_database.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tchat/models/user_model.dart';

class FloorDatabase {
   FloorDatabase? _instance;
   TChatDatabase? database;
  UserDao? userDao;
  LastMessageDao? messageDao;

  Future<FloorDatabase> getInstance() async {
    // print('FloorDatabase getInstance()');
    _instance ??= FloorDatabase();
    database ??=
        await $FloorTChatDatabase.databaseBuilder('TChatApp.db').build();
    userDao ??= database!.userDao;
    messageDao ??= database!.lastMessageDao;
    // print('FloorDatabase getInstance() 1');
    return _instance!;
  }

  init() async {
    //  print('FloorDatabase init()');
    database = await $FloorTChatDatabase.databaseBuilder('TChatApp.db').build();
    userDao = database!.userDao;
    messageDao = database!.lastMessageDao;
    // print('FloorDatabase init() 1');
  }
}
