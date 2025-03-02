
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/text.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? obscureText;
  final dynamic validate;
  final dynamic onSave;
  final dynamic onTap;
  final dynamic onChanged;
  final String? labelText;
  final Widget? suffixIcon;
  final bool isReadonly;
  final bool isRequired;
  final TextStyle? titleStyle;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final double? height;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    this.isReadonly = false,
    this.isRequired = false,
    this.labelText,
    this.titleStyle,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.height,
    this.maxLines,
    this.validate,
    this.border,
    this.onSave,
    this.onTap,
    this.onChanged,
    this.boxShadow,
    this.inputFormatters,
    this.contentPadding,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                child: Row(
                  children: [
                    CommonText.semiBold(
                      title!,
                      size: 14.sp,
                      color: colorBlack,
                    ),
                    isRequired
                        ? CommonText.semiBold(
                            " *",
                            size: 14.sp,
                            color: Colors.red,
                          )
                        : const CommonText.medium(""),
                  ],
                ),
              )
            : SizedBox(
                height: 0.sp,
              ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isReadonly ? colorWhite : Colors.white,
              borderRadius: BorderRadius.circular(50.r),
              border: border,
              boxShadow: boxShadow),
          child: TextFormField(
            style: TextStyle(fontSize: 12.sp),
            readOnly: isReadonly,
            onTap: onTap,
            textAlign: TextAlign.start,
            onChanged: onChanged,
            textDirection: TextDirection.ltr,
            obscureText: obscureText ?? false,
            controller: controller,
            textInputAction: textInputAction ?? TextInputAction.done,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              filled: true,
              prefixIcon: prefixIcon,
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              hintText: hintText,
              fillColor: colorWhite,
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            ),
            validator: validate,
          ),
        ),
      ],
    );
  }
}

/*class CustomPhoneTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isRequired;
  final TextInputType? keyboardType;
  final PhoneController? controller;
  final bool? obscureText;
  final dynamic validate;
  final dynamic onSave;
  final Function(PhoneNumber? p)? onChanged;
  final String? labelText;
  final Widget? suffixIcon;
  final bool isReadonly;
  final TextStyle? titleStyle;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final double? height;
  final double? textSize;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const CustomPhoneTextField({
    Key? key,
    this.isReadonly = false,
    this.isRequired = false,
    this.labelText,
    this.titleStyle,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.height,
    this.maxLines,
    this.validate,
    this.border,
    this.onSave,
    this.onChanged,
    this.textSize = 12,
    this.boxShadow,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                child: Row(
                  children: [
                    CommonText.semiBold(
                      title!,
                      size: 14.sp,
                      color: kTextColor,
                    ),
                    isRequired
                        ? CommonText.semiBold(
                            " *",
                            size: 14.sp,
                            color: Colors.red,
                          )
                        : const CommonText.medium(""),
                  ],
                ),
              )
            : SizedBox(
                height: 0.sp,
              ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isReadonly ? kReadOnlyColor : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: border,
              boxShadow: boxShadow),
          child: PhoneFormField(
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.start,
            showFlagInInput: false,
            isCountrySelectionEnabled: false,
            countryCodeStyle: TextStyle(fontSize: textSize, color: Colors.black),
            obscureText: obscureText ?? false,
            controller: controller,
            onChanged: onChanged ?? (PhoneNumber? p) {},
            textInputAction: textInputAction ?? TextInputAction.done,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              filled: true,
              prefixIcon: prefixIcon,
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              hintText: hintText,
              fillColor: kBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            ),
            validator: _getValidator(),
          ),
        ),
      ],
    );
  }
}

PhoneNumberInputValidator? _getValidator() {
  List<PhoneNumberInputValidator> validators = [];
  validators.add(PhoneValidator.validMobile(allowEmpty: true));
  return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
}*/
