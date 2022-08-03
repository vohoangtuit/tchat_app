import 'package:flutter/material.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';

class ItemLastMessage extends StatefulWidget {
 final UserModel profile;
 final LastMessageModel message;
 final    String languageCode;
  const ItemLastMessage({Key? key, required this.profile, required this.message, required this.languageCode}) : super(key: key);

  @override
  State<ItemLastMessage> createState() => _ItemLastMessageState();
}

class _ItemLastMessageState extends State<ItemLastMessage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
