import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/controller/my_router.dart';
import 'package:tchat/firebase/notification/notification_controller.dart';
import 'package:tchat/providers/auth_provider.dart';
import 'package:tchat/providers/chat_provider.dart';
import 'package:tchat/providers/home_provider.dart';
import 'package:tchat/providers/profile_provider.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/check_login_screen.dart';

import 'shared_preferences/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends TChatBaseScreen<MyApp> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      home: const CheckLoginScreen(),

    );
  }

  @override
  void initAll() {
    super.initAll();
    NotificationController.getInstance(baseScreen: this,context_: context);

  }
}
