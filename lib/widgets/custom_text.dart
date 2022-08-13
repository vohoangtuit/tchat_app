import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tchat/utils/colors.dart';

import '../utils/widget_size.dart';



// todo custom text app default
//double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
Text textTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      color: AppColor.textColor,
      fontSize: TextSize.textTitle,
        fontWeight: FontWeight.bold
    ),
  );
}

// TODO text app default
TextStyle styleDefault(){
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      color: AppColor.textColor,
      fontSize: TextSize.text,
      height: 1.25
  );
}
Text text(String text) {
  return Text(text,
    style: styleDefault(),
  );
}

Text textItalic(String text,Color color) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      fontStyle: FontStyle.italic,
      color: color,
      fontSize: TextSize.text,
    ),
  );
}
Text textCenter(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.text,
      fontWeight: FontWeight.normal,
        height: 1.25
    ),
    textAlign: TextAlign.center,
  );
}
Text textCenterLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textLarge,
      fontWeight: FontWeight.normal,
        height: 1.6
    ),
    textAlign: TextAlign.center,
  );
}
Text textAlignRight(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        color: AppColor.textColor,
        fontSize: TextSize.text,
        fontWeight: FontWeight.normal,
        height: 1.25
    ),
    textAlign: TextAlign.right,
  );
}
Text textBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.text,
      fontWeight: FontWeight.bold,
    ),
  );
}
Text textBoldItalic(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.text,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
  );
}
Text textLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textLarge,
      fontWeight: FontWeight.normal,
        height: 1.25
    ),
  );
}
Text textLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textLarge,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  );
}
Text textXLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textXLarge,
      fontStyle: FontStyle.normal,
    ),
  );
}
Text textXLargeUnderline(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textXLarge,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal,
    ),
  );
}
Text textXLargeBolt(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textXLarge,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text textLargeBoltCenter(String text,bool isBold) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textLarge,
      fontStyle: FontStyle.normal,
      fontWeight: isBold?FontWeight.bold:FontWeight.normal,
    ),
    textAlign: TextAlign.center,
  );
}
Text textSmall(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textSmall,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textSmallBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textSmall,
      fontWeight:FontWeight.bold,
    ),
  );
}

Text textBoltWithSize(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: size,
      fontWeight:FontWeight.bold,
    ),
  );
}

//// todo  text light app default
Text textLight(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
        height: 1.25
    ),
  );
}

Text textLightCenter(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
        height: 1.25
    ),
    textAlign: TextAlign.center,
  );
}

Text textLightBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.text,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textLightLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}

Text textLightLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}

Text textLightXtLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.textXLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}

Text textLightBoldXtLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.textXLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textLightSmall(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColorLight,
      fontSize: TextSize.textSmall,
      fontWeight:FontWeight.normal,
    ),
  );
}
//
// TODO text Purple
Text textPurpleLight(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textPurpleLightItalic(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.text,
      fontStyle: FontStyle.italic,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textPurpleLightSmall(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.textSmall,
      fontWeight:FontWeight.normal,
    ),
  );
}

Text textPurpleLightBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.text,
      fontWeight:FontWeight.bold,
    ),
  );
}

Text textPurpleLightLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textPurpleLightLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textPurpleXLightLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.purpleLight,
      fontSize: TextSize.textXLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textGray(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.gray,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
    ),
  );
}

// TODO text White
Text textWhite(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.white,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
    ),
  );
}

Text textWhiteLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.white,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textWhiteLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.white,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textWhiteBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.white,
      fontSize: TextSize.text,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textWhiteSmall(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.white,
      fontSize: TextSize.textSmall,
      fontWeight:FontWeight.normal,
    ),
  );
}

// TODO text Black
Text textBlack(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textBlack,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textBlackBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textBlack,
      fontSize: TextSize.text,
      fontWeight:FontWeight.bold,
    ),
  );
}

Text textBlackLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textBlack,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textBlackLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textBlack,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
// TODO text red
Text textStatusBooking(String text) {
  return Text(
    text.toUpperCase(),
    style: GoogleFonts.roboto(
      color: AppColor.lightOrange,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
      fontStyle: FontStyle.italic
    ),
  );
}
// TODO text red
Text textRed(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.red,
      fontSize: TextSize.text,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textRedBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.red,
      fontSize: TextSize.text,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textRedLarge(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.red,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.normal,
    ),
  );
}
Text textRedLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.red,
      fontSize: TextSize.textLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}
Text textRedXLargeBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.red,
      fontSize: TextSize.textXLarge,
      fontWeight:FontWeight.bold,
    ),
  );
}


// TODO text custom style
TextStyle textStyle(double size, bool isBold, Color color) {
  return GoogleFonts.roboto(
    color: color,
    fontSize: size,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}
Text textUnderLineDefault(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        color: AppColor.textColor,
        fontSize: 13,
        fontWeight:FontWeight.normal,
        decoration: TextDecoration.underline
    ),
  );
}
Text textUnderLineBold(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        color: AppColor.textColor,
        fontSize: 13,
        fontWeight:FontWeight.bold,
        decoration: TextDecoration.underline
    ),
  );
}
Text textUnderLineCustom(String text, double size, Color colors, bool bold) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: colors,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: TextDecoration.underline
    ),
  );
}

Text textUnderLineBlue(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        color: AppColor.blue,
        fontSize: TextSize.text,
        fontWeight:  FontWeight.normal,
        decoration: TextDecoration.underline
    ),
  );
}
Text textLimitLineAlightRight(String text, double size, bool bold, Color colors,
    int line) {
  return Text(
    text,
    maxLines: line,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
        color: colors,
        fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
    textAlign: TextAlign.right,
  );
}
//
// todo text tabbar tour detail
Text textTabBarTourDetail(String text, bool active) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: active ? AppColor.textColor : AppColor.textColorLight,
      fontSize: TextSize.text,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}
Text textTabBarHotelDetail(String text) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.text,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}

Text textTabBarPromotion(String text, bool active) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      color: active ? AppColor.purpleLight : AppColor.white,
      fontSize: TextSize.text,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}
//
Text textServiceTourDetail(String text) {
  return Text(
    text,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textServiceTourDetail,
      fontWeight: FontWeight.normal,
    ),
  );
}
// TODO text limit line
Text textLimitLine(String text, double size, bool bold, Color colors,
    int line) {
  return Text(
    text,
    maxLines: line,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      color: colors,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
Text textNameTourList(String text,int line) {
  return Text(
    text,
    maxLines: line,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      color: AppColor.textColor,
      fontSize: TextSize.textLarge,
      fontWeight: FontWeight.bold,
    ),
  );
}


TextStyle textWhiteTitle() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}
TextStyle textHeaderBar() {
  return const TextStyle(color: Colors.white, fontSize: 14,decoration: TextDecoration.none);
}

TextStyle textBlueSmall(){
  return const TextStyle(color: Colors.blue, fontSize: 12);
}
TextStyle textBlueDefault(){
  return const TextStyle(color: Colors.blue, fontSize: 14);
}
TextStyle textBlueMedium(){
  return const TextStyle(color: Colors.blue, fontSize: 16);
}
TextStyle textBlueMediumBold(){
  return const TextStyle(color: Colors.blue, fontSize: 16,fontWeight: FontWeight.bold);
}
TextStyle textBlueLarge(){
  return const TextStyle(color: Colors.blue, fontSize: 18);
}
TextStyle textBlackMedium() {
  return const TextStyle(color: Colors.black, fontSize: 16);
}
TextStyle textBlackNormal() {
  return const TextStyle(color: Colors.black, fontSize: 14);
}
TextStyle textGraysSmall() {
  return const TextStyle(color: Colors.grey, fontSize: 12);
}
TextStyle textGraySmaller() {
  return const TextStyle(color: Colors.grey, fontSize: 11);
}
TextStyle textWhiteMedium() {
  return const TextStyle(color: Colors.white, fontSize: 16);
}