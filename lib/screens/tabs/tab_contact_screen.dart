import 'package:flutter/material.dart';
import 'package:tchat/widgets/custom_text.dart';

class TabContactScreen extends StatefulWidget {
  const TabContactScreen({Key? key}) : super(key: key);

  @override
  State<TabContactScreen> createState() => _TabContactScreenState();
}

class _TabContactScreenState extends State<TabContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text('ContactScreen'),
    );
  }
}
