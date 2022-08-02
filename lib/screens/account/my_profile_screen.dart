import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends TChatBaseScreen<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: text('hihi'),);
  }
}
