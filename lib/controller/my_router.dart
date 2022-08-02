import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/account/update_account_screen.dart';
import 'package:tchat/screens/chat/chat_screen1.dart';
import 'package:tchat/screens/main_screen.dart';
import 'package:tchat/screens/setting/setting_screen.dart';
import 'package:tchat/screens/splash_screen.dart';
import 'package:tchat/screens/user_friend/user_profile_screen.dart';


const String myRouterSplash = '/';
const String myRouterMain = '/MainScreen';
const String myRouterChat = '/chatScreen';
const String myRouterUserProfile = '/user_profile_screen';
const String myRouterSetting = '/setting_screen';
const String myRouterUpdateAccount = '/update_account_screen';

class MyRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    print('MyRouter ${settings.name}');
    switch (settings.name) {
      case myRouterSplash:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case myRouterMain:
        var synData = settings.arguments as bool;
        var user = settings.arguments as UserModel;
        return MaterialPageRoute(

            settings: settings, builder: (_) => MainScreen(synData:synData,profile: user,));

      case myRouterChat:
        var user = settings.arguments as UserModel;
        return MaterialPageRoute(
            //settings: settings, builder: (_) => ChatScreen(user));
            settings: settings, builder: (_) => const ChatScreen1());
      case myRouterUserProfile:
        Map args = settings.arguments as Map;
        var myProfile = args['myProfile'] as UserModel;
        var userProfile = args['userProfile'] as UserModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UserProfileScreen(myProfile: myProfile, user: userProfile));
      case myRouterSetting:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());

      case myRouterUpdateAccount:
        var user = settings.arguments as UserModel;
        return MaterialPageRoute(
            settings: settings, builder: (_) => UpdateAccountScreen(account:user));
    }
    return null;

  }
}
