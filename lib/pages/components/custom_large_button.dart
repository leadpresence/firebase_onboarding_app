import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/color.dart';

screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

class CustomButton extends StatelessWidget {
  final onPressed, hasIcon, buttonText, hasBorder, height, isLoading;
  final double fontSize, borderRadius;
  final Color buttonColor, buttonTextColor, borderColor;
  final Color? shadowColor, onPrimary;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.hasIcon = false,
    this.buttonText = "Button Text",
    this.fontSize = 14,
    this.borderRadius = 12,
    this.hasBorder = false,
    this.buttonColor = primary,
    this.buttonTextColor = const Color(0xffffffff),
    this.height,
    this.isLoading = false,
    this.borderColor = primary,
    this.shadowColor,
    this.onPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.white,
          highlightColor: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shadowColor: shadowColor ?? Colors.white,
            onPrimary: onPrimary ?? Colors.white,
            onSurface: Colors.white,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              side: hasBorder
                  ? BorderSide(color: borderColor, width: 1)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasIcon
                  ? Icon(
                      Icons.star,
                      size: 25,
                    )
                  : const SizedBox(),
              hasIcon
                  ? const SizedBox(
                      width: 12,
                    )
                  : const SizedBox(),
              isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: white,
                        strokeWidth: 5,
                      ),
                    )
                  : Text(
                      buttonText,
                      style: GoogleFonts.mulish(
                        color: buttonTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
