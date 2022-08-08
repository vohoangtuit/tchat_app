import 'package:flutter/material.dart';

class CustomButtonWithTitle extends StatelessWidget {
  final VoidCallback onPressed;

  final String title;
  final Color? colorButton;
  final Color? colorText;
  final double? sizeText;

  const CustomButtonWithTitle({Key? key,required this.onPressed,required this.title,required this.colorButton,required this.colorText,required this.sizeText}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
     // color: colorButton,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: colorButton,
         // border: Border.all(color: border)
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: Row(
            children: [
              Text(
                title, style: TextStyle(color: colorText,fontSize: sizeText ?? 16),),
            ],
          ),
        ),

      ),
    );
  }
}
class A extends StatelessWidget {
  const A({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
