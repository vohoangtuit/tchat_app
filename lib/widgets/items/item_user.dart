import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';

class ItemUser extends StatefulWidget {
  final UserModel user;
  final VoidCallback onSelected;
  const ItemUser({Key? key, required this.user, required this.onSelected}) : super(key: key);

  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
