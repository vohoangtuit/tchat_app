import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:tchat/providers/app_provider.dart';
import 'package:tchat/providers/user_provider.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/screens/check_login_screen.dart';

import 'shared_preferences/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FloorDatabase floorDB = FloorDatabase();
//  await floorDB.init();
  await floorDB.getInstance();
  SharedPre sharedPre = await SharedPre.getInstance();
  await Firebase.initializeApp();
  FirebaseService firebaseService = FirebaseService.getInstance();

  runApp(MyApp(firebaseService: firebaseService,floorDB: floorDB,sharedPre: sharedPre,));
}

class MyApp extends StatefulWidget {
  final FirebaseService firebaseService;
  final FloorDatabase floorDB;
  final SharedPre sharedPre;
  const MyApp({Key? key, required this.firebaseService, required this.floorDB, required this.sharedPre}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Locale? myLocale;
    return MultiProvider(
      providers: [
        Provider<AppProvider>(
            create: (_) => AppProvider(firebaseService: widget.firebaseService,floorDatabase: widget.floorDB,sharedPre: widget.sharedPre)),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TChat',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // onGenerateRoute: MyRouter.generateRoute,
          home: const CheckLoginScreen(),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            myLocale =
                deviceLocale; // here you make your app language similar to device language , but you should check whether the localization is supported by your app
            // print(myLocale.countryCode);
            //  print(myLocale.languageCode);
            widget.sharedPre.saveString(SharedPre.sharedPreLanguageCode, myLocale!.languageCode);
             widget.sharedPre.saveString(SharedPre.sharedPreCountryCode, myLocale!.countryCode!);
          }),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
