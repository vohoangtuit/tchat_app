import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends TChatScreen<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
