import 'package:flutter/material.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';

class CustomRowSetting extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String icon;

  const CustomRowSetting({Key? key, required this.onPressed, required this.title, required this.icon,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 0),
              child: Image.asset(icon, width: 16, height: 16,),
            ),
            spaceWidth(10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          title,
                          style: textBlackNormal(),
                        )),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.navigate_next,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0.5,),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
