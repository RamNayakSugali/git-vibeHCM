// ignore_for_file: unnecessary_const, must_be_immutable

import '../untils/export_file.dart';

class CustomDropDown extends StatelessWidget {
  String label;
  bool isMandatory;
  List<String> options;
  dynamic onChanged;
  dynamic hintText;
  dynamic validator;
  CustomDropDown(
      {Key? key,
      this.validator,
      required this.label,
      this.hintText,
      required this.isMandatory,
      required this.onChanged,
      required this.options})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: label,
              style: GoogleFonts.openSans(
                  fontSize: kFourteenFont,
                  color: Ktextcolor,
                  fontWeight: FontWeight.w500),
              children: isMandatory
                  ? [
                      TextSpan(
                        text: '*',
                        style: GoogleFonts.openSans(
                          fontSize: kFourteenFont,
                          color: KRed,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]
                  : []),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 6),
                color: Ktextcolor.withOpacity(0.2),
              )
            ],
            // boxShadow: [
            //   BoxShadow(
            //     color: Ktextcolor.withOpacity(0.09),
            //     offset: const Offset(
            //       1,
            //       1,
            //     ),
            //     blurRadius: 20.0,
            //     spreadRadius: 0.5,
            //   )
            // ]
          ),
          child: TextDropdownFormField(
            onChanged: onChanged,
            options: options,
            decoration: InputDecoration(
              hintText: hintText,

              hintStyle: TextStyle(
                color: kblack.withOpacity(0.8),
                fontSize: kTenFont,
                fontWeight: FontWeight.w700,
              ),
              // hintStyle: TextStyle(fontWeight: KF),
              fillColor: Kwhite,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Kwhite), //<-- SEE HERE
                borderRadius: BorderRadius.circular(13.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Kwhite), //<-- SEE HERE
                borderRadius: BorderRadius.circular(13.r),
              ),
              contentPadding: EdgeInsets.only(left: 10.w),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Kwhite), //<-- SEE HERE
                borderRadius: BorderRadius.circular(13.r),
              ),
              suffixIcon: const Icon(
                Icons.expand_more_outlined,
                color: Ktextcolor,
              ),
            ),
            validator: validator,
            dropdownHeight: 100.h,
          ),
        ),
      ],
    );
  }
}
