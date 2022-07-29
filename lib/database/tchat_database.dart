import 'dart:async';

import 'package:floor/floor.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:tchat/models/user_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'tchat_database.g.dart';
@Database(version: 1, entities: [UserModel])
abstract class TChatDatabase extends FloorDatabase {
  UserDao get userDao;

}