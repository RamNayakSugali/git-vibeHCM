// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import '../untils/export_file.dart';

class CustomButton extends StatelessWidget {
  String label;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  final Color;
  final textColor;
  var Padding;
  var margin;
  BorderRadiusGeometry? borderRadius;

  bool isLoading;
  dynamic onTap;

  CustomButton(
      {Key? key,
      this.height,
      this.width,
      this.Padding,
      this.Color,
      this.textColor,
      this.margin,
      this.fontSize,
      this.fontWeight,
      this.borderRadius,
      required this.label,
      required this.isLoading,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: Padding,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Color, borderRadius: borderRadius),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize, color: textColor, fontWeight: fontWeight),
          ),
        ));
  }
}

class Custom_OutlineButton extends StatelessWidget {
  String label;
  double? height;
  double? width;
  double? fontSize;
  FontWeight? fontWeight;
  final Color;
  final textColor;
  var Padding;
  var margin;
  BorderRadiusGeometry? borderRadius;

  bool isLoading;
  dynamic onTap;

  Custom_OutlineButton({
    Key? key,
    this.height,
    this.width,
    this.Padding,
    this.Color,
    this.textColor,
    this.margin,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    required this.label,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: Padding,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: KRed, width: 1)),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: KOrange,
                  ),
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight),
                ),
        ));
  }
}

class Custom_textButton extends StatelessWidget {
  String images;
  String label;
  dynamic onTap;

  Custom_textButton(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(images, width: 15.w),
          Text(label,
              style: TextStyle(
                  fontSize: kTwelveFont, fontWeight: kFW600, color: KOrange))
        ],
      ),
    );
  }
}

class Custom_text extends StatelessWidget {
  String titlelabel;

  String sublabel;
  final TitleColor;
  final SubColor;
  final Titlefontsize;
  final Subfontsize;

  dynamic onTap;

  Custom_text({
    Key? key,
    required this.titlelabel,
    required this.sublabel,
    this.TitleColor,
    this.SubColor,
    this.Titlefontsize,
    this.Subfontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titlelabel,
            style: TextStyle(
                fontSize: Titlefontsize,
                fontWeight: kFW600,
                color: TitleColor)),
        SizedBox(
          height: 5.h,
        ),
        Text(sublabel,
            style: TextStyle(
                fontSize: Subfontsize, fontWeight: kFW900, color: SubColor))
      ],
    );
  }
}
