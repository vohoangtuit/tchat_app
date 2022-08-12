import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tchat/widgets/custom_text.dart';

import '../utilities/const.dart';
AppBar appBarWithTitle(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: textWhiteTitle()),
    centerTitle: true,
  );
}
SafeArea deviceScreen({required Widget child}) {
  return SafeArea(
    top: false,
    bottom: Device.get().isIphoneX?true:false,
    child: child,
  );
}
Widget widgetLogo() {
  return Image.asset(
    'asset/images/logo.png',
    width: 120,
    height: 120,
  );
}
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
Widget loadingCenter() {
  return Container(
    color: Colors.white.withOpacity(0.5),
    child: const Center(
      child: CircularProgressIndicator(
          strokeWidth: 2
        // valueColor: AlwaysStoppedAnimation<Color>(AppColor.red),
      ),
    ),
  );
}
CachedNetworkImage cachedImage (String url,double width, double height){
  return CachedNetworkImage(
    placeholder: (context, url) =>
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor:
            AlwaysStoppedAnimation<Color>(
                themeColor),
          ),
        ),
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
  );
}
InputDecoration inputDecoratio(String hintText){
  return InputDecoration.collapsed(
    hintText: hintText,
    border: InputBorder.none,
  );
}
Container iconEditInfo(){
  return Container(
      alignment: Alignment.centerRight,
      child: Image.asset('assets/icons/ic_pen_gray.png',width: 15,height: 15,)
  );
}

Image avatarNotAvailable(double size){
  return Image.asset(
    pathAvatarNotAvailable,
    width: size,height: size,
  );
}

Material loadFileMaterial(File file, double width, double height){
  return Material(
    borderRadius:
    const BorderRadius.all(Radius.circular(45.0)),
    clipBehavior: Clip.hardEdge,
    child: Image.file(
      file,
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),
  );
}