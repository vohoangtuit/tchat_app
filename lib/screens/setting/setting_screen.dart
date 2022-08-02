import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends TChatBaseScreen<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: text('Setting Screen') ,
    );
  }
}
