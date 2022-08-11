import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:tchat/screens/check_login_screen.dart';

import 'shared_preferences/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key,}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    Locale? myLocale;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // onGenerateRoute: MyRouter.generateRoute,
      home: const CheckLoginScreen(),
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          myLocale = deviceLocale ; // here you make your app language similar to device language , but you should check whether the localization is supported by your app
          // print(myLocale.countryCode);
          //  print(myLocale.languageCode);
          SharedPre.saveString(SharedPre.sharedPreLanguageCode, myLocale!.languageCode);
          SharedPre.saveString(SharedPre.sharedPreCountryCode, myLocale!.countryCode!);
        }
    );
  }
@override
  void initState() {
    super.initState();

  }

}
