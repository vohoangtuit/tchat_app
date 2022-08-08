import 'package:flutter/material.dart';
import 'package:tchat/general/base_dialog.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';


class BaseNotification extends BaseDialog {
  final String title, description;
  BaseNotification({Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context =context;
    dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: initUI(),
    );
    return dialog!;
  }
 Widget initUI(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        spaceHeight(20),
        Text(title, style: textBlueMedium(),),
        spaceHeight(10),
        Text(description, style: textBlackMedium()),
        spaceHeight(10),
        Container(
          color: Colors.lightBlue,
          child: InkWell(
            child: Text('OK', style: textWhiteMedium()),
            onTap: () {
             dismiss();
            },

          ),
        ),
       spaceHeight(5),

      ],
    );
 }
}
