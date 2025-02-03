// ignore_for_file: camel_case_types, unused_field

import 'package:intl/intl.dart';

import '../../../untils/export_file.dart';

class Apply_Regular extends StatefulWidget {
  const Apply_Regular({super.key});

  @override
  State<Apply_Regular> createState() => _Apply_RegularState();
}

class _Apply_RegularState extends State<Apply_Regular> {
  final DateTime _chosenDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/info.png",
              width: 25.w,
            ),
            Text(
              "You can regularize for a maximum of 3 days",
              style: TextStyle(
                fontSize: kTenFont,
                fontWeight: kFW600,
                color: Klightblack.withOpacity(0.5),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          color: Kwhite,
          child: TableCalendar(
            // onDaySelected: (date, events, e) {
            //     setState(() {
            //       _chosenDate = date; // Update the chosen date here
            //     });
            //   },
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2050, 10, 20),
            focusedDay: DateTime.now(),
            headerVisible: true,
            daysOfWeekVisible: true,
            sixWeekMonthsEnforced: true,
            shouldFillViewport: false,
            headerStyle: HeaderStyle(
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMM(locale).format(date),
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                    fontSize: kSixteenFont,
                    color: KdarkText,
                    fontWeight: kFW700)),
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(
                  fontSize: kFourteenFont, color: KOrange, fontWeight: kFW600),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomButton(
            height: 35.h,
            width: double.infinity,
            margin: EdgeInsets.all(15.r),
            textColor: KBrown,
            borderRadius: BorderRadius.circular(15.r),
            Color: KOrange.withOpacity(0.1),
            fontSize: 11.sp,
            fontWeight: kFW600,
            label: "! Tap on date to select",
            isLoading: false,
            onTap: () {})
      ],
    );
  }
}
