import 'package:flutter/material.dart';
import 'package:tchat/widgets/custom_text.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String title;

   BaseButton({required this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.lightBlueAccent,
      ),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 200,
          child: Center(
            child: textWhiteLarge(
              title,
            ),
          ),
        ),

      ),
    );
  }
}