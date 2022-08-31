import 'package:tchat/database/personDao.dart';
import 'package:tchat/database/user_dao.dart';
import 'package:tchat/network/network_config.dart';
import 'package:tchat/providers/app_provider.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

import '../database/floor_init.dart';
import '../firebase/database/firestore_database.dart';
import '../shared_preferences/shared_preference.dart';

class BaseBloc extends NetworkConfig {
  final AppProvider appProvider;
  final TChatBaseScreen screen;
  BaseBloc( {required this.appProvider,required this.screen}) : super.internal();
  void dispose() {}
  FirebaseService get firebase =>appProvider.firebaseService;
  FloorDatabase get floorDB =>appProvider.floorDatabase;
  UserDao get userDao =>appProvider.floorDatabase.userDao!;
  PersonDao get personDao =>appProvider.floorDatabase.personDao!;
  SharedPre get sharedPre =>appProvider.sharedPre;
}