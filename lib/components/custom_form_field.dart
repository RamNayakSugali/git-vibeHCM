import 'package:flutter/material.dart';

import '../untils/export_file.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  String labelText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  dynamic onTap;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  CustomFormField(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.maxLines,
      this.suffix,
      this.value,
      this.onChanged,
      this.onTap,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      required this.labelText,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: onTap,
        maxLines: maxLines,
        focusNode: focusNode,
        keyboardType: keyboardType,
        style: TextStyle(
            fontSize: 13.sp,
            fontWeight: kFW700,
            color: selectedTheme == "Lighttheme" ? kblack : Kwhite),
        decoration: InputDecoration(
          focusColor: Colors.white,

          contentPadding: contentPadding,
          // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          fillColor: Colors.grey,
          suffixIcon: suffix,
          prefixIcon: prefix,
          hintText: hintText,
          alignLabelWithHint: true,
          //make hint text
          hintStyle: TextStyle(
            color: selectedTheme == "Lighttheme"
                ? Klightgray.withOpacity(0.5)
                : Kwhite,
            fontSize: kTenFont,
            fontWeight: FontWeight.w600,
          ),

          //create lable
          labelText: labelText,
          //lable style
          labelStyle: TextStyle(
            color: selectedTheme == "Lighttheme" ? kblack : Kwhite,
            fontSize: kTenFont,
            fontWeight: FontWeight.w800,
          ),
        ),
        validator: validator,
        onChanged: onChanged);
  }
}

class CustomclaimFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  String labelText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  dynamic onTap;
  bool cursor;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  CustomclaimFormField(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.maxLines,
      this.suffix,
      required this.cursor,
      this.value,
      this.onChanged,
      this.onTap,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      required this.labelText,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        showCursor: cursor,
        onTap: onTap,
        maxLines: maxLines,
        focusNode: focusNode,
        keyboardType: keyboardType,
        style: TextStyle(
            fontSize: 13.sp,
            fontWeight: kFW700,
            color: selectedTheme == "Lighttheme" ? kblack : Kwhite),
        decoration: InputDecoration(
          focusColor: Colors.white,

          contentPadding: contentPadding,
          // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: KdarkText, width: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          fillColor: Colors.grey,
          suffixIcon: suffix,
          prefixIcon: prefix,
          hintText: hintText,
          alignLabelWithHint: true,
          //make hint text
          hintStyle: TextStyle(
            color: selectedTheme == "Lighttheme"
                ? Klightgray.withOpacity(0.5)
                : Kwhite,
            fontSize: kTenFont,
            fontWeight: FontWeight.w600,
          ),

          //create lable
          labelText: labelText,
          //lable style
          labelStyle: TextStyle(
            color: selectedTheme == "Lighttheme" ? kblack : Kwhite,
            fontSize: kTenFont,
            fontWeight: FontWeight.w800,
          ),
        ),
        validator: validator,
        onChanged: onChanged);
  }
}
