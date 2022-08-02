import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class UserProfileScreen extends StatefulWidget {
 final UserModel myProfile;
 final UserModel user;

  const UserProfileScreen({Key? key, required this.myProfile, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends TChatBaseScreen<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: text('User profile'),

    );
  }
}
