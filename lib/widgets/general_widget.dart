import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tchat/widgets/custom_text.dart';
BoxDecoration bgBorder(Color color, Color border, double radius) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      border: Border.all(color: border));
}
Widget buttonSubmitWithColorIcon(
    String title, String icon, Color color, VoidCallback onSubmit) {
  return InkWell(
    onTap: onSubmit,
    child: Container(
      decoration: bgBorder(color, color, 8),
      padding: EdgeInsets.only(top: Device.get().isPhone?8:10, bottom: Device.get().isPhone?8:10),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/$icon.svg',
                width: 24,
              ),
              spaceWidth(10),
              textWhiteLarge(title),
            ],
          )),
    ),
  );
}

Widget loading(){
  return const Center(child: CircularProgressIndicator());
}
SizedBox spaceHeight(double space) {
  return SizedBox(
    height: space,
  );
}

SizedBox spaceWidth(double space) {
  return SizedBox(
    width: space,
  );
}