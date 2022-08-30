import 'package:tchat/database/floor_init.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';

class AppProvider{
  final FirebaseService firebaseService;
  final FloorDatabase floorDatabase;
  final SharedPre sharedPre;

  AppProvider({required this.firebaseService,required this.floorDatabase,required this.sharedPre, });

}