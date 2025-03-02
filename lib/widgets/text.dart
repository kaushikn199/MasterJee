import 'package:flutter/cupertino.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool isItalic;
  final double? height;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final VoidCallback? onTap;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const CommonText(this.text,
      {this.size,
      this.color,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.isItalic = false,
      this.height,
      this.letterSpacing,
      this.fontWeight = FontWeight.normal,
      this.onTap,
      this.decoration = TextDecoration.none,
      Key? key,
      this.decorationColor})
      : super(key: key);

  const CommonText.extraBold(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w900,
        super(key: key);

  const CommonText.bold(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w700,
        super(key: key);

  const CommonText.semiBold(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w600,
        super(key: key);

  const CommonText.medium(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w500,
        super(key: key);

  const CommonText.regular(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w400,
        super(key: key);

  const CommonText.light(
    this.text, {
    this.size,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.onTap,
    this.decoration = TextDecoration.none,
    Key? key,
    this.decorationColor,
  })  : fontWeight = FontWeight.w300,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: size ?? 12,
          fontStyle: isItalic ? FontStyle.italic : null,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          decoration: decoration,
          decorationColor: decorationColor),
    );

    return onTap != null ? GestureDetector(onTap: onTap, child: child) : child;
  }
}
