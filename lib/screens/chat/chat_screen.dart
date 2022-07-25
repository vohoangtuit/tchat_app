import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel meAccount;
  final UserModel toUser;
  const ChatScreen({Key? key, required this.meAccount, required this.toUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
