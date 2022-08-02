import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class ChatScreen1 extends StatefulWidget {
  const ChatScreen1({Key? key}) : super(key: key);

  @override
  State<ChatScreen1> createState() => _ChatScreen1State();
}

class _ChatScreen1State extends TChatBaseScreen<ChatScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: text('chat'),
    );
  }
}
