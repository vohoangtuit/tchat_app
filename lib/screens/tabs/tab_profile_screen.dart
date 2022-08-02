import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

import '../../widgets/custom_text.dart';

class TabProfileScreen extends StatefulWidget {
  const TabProfileScreen({Key? key}) : super(key: key);

  @override
  State<TabProfileScreen> createState() => _TabProfileScreenState();
}

class _TabProfileScreenState extends TChatBaseScreen<TabProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text('TabProfileScreen'),
    );
  }
}
