import 'dart:async';

import 'package:floor/floor.dart';
import 'package:tchat/database/last_message_dao.dart';
import 'package:tchat/database/person_dao.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/person_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'tchat_database.g.dart';
@Database(version: 1, entities: [UserModel,LastMessageModel,PersonModel])
abstract class TChatDatabase extends FloorDatabase {
  UserDao get userDao;
  LastMessageDao get lastMessageDao;
  PersonDao get personDao;
}