import 'package:flutter/material.dart';
import 'package:masterjee/constants.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double paddingHorizontal;
  final double paddingVertical;
  final double cornersRadius;

  const CommonButton({
    Key? key,
    required this.text,
    this.color = colorGreen,
    required this.onPressed,
    this.paddingHorizontal = 20.0,
    this.paddingVertical = 14.0,
    this.cornersRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(cornersRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}