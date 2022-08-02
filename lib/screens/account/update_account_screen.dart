import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class UpdateAccountScreen extends StatefulWidget {
  final UserModel account;
  const UpdateAccountScreen({Key? key, required this.account}) : super(key: key);

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends TChatBaseScreen<UpdateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: text('UpdateAccountScreen'),
    );
  }
}
