import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

import '../../widgets/custom_text.dart';

class TabTimeLineScreen extends StatefulWidget {
  const TabTimeLineScreen({Key? key}) : super(key: key);

  @override
  State<TabTimeLineScreen> createState() => _TabTimeLineScreenState();
}

class _TabTimeLineScreenState extends TChatBaseScreen<TabTimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text('TimeLineScreen'),
    );
  }
}
