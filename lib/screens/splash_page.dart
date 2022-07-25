import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/allConstants/color_constants.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/providers/auth_provider.dart';
import 'package:tchat/screens/TChatScreen.dart';
import 'package:tchat/screens/account/login_screen.dart';
import 'package:tchat/screens/home/home_screen.dart';
import 'package:tchat/screens/home_page.dart';
import 'package:tchat/screens/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends TChatScreen<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    String? id =await getIdAccount();
    if (id==null||id.isEmpty) {
      addScreen( const LoginScreen());
      return;
    }
    replaceScreen( const HomeScreen());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome to TChat",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizes.dimen_18),
            ),
            Image.asset(
              'assets/images/splash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "TChat Application",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizes.dimen_18),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
