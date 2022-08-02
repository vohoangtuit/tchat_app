import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class TabLastMessageScreen extends StatefulWidget {
  const TabLastMessageScreen({Key? key}) : super(key: key);

  @override
  State<TabLastMessageScreen> createState() => _TabLastMessageScreenState();
}

class _TabLastMessageScreenState extends TChatBaseScreen<TabLastMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text('last message'),
    );
  }
}

