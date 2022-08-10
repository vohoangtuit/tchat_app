import 'package:flutter/material.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/custom_text.dart';

class TabContactScreen extends StatefulWidget {
  const TabContactScreen({Key? key}) : super(key: key);

  @override
  State<TabContactScreen> createState() => _TabContactScreenState();
}

class _TabContactScreenState extends TChatBaseScreen<TabContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: text('ContactScreen'),
    );
  }

  @override
  void initAll() {

    super.initAll();
    log('TabContact initAll');
    if(account.id!=null){
      log('TabContact account.id ${account.id}');
    }
  }

}
