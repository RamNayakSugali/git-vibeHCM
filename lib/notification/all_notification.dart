// ignore_for_file: camel_case_types

import '../untils/export_file.dart';

class All_notify extends StatefulWidget {
  const All_notify({super.key});

  @override
  State<All_notify> createState() => _All_notifyState();
}

class _All_notifyState extends State<All_notify> {
  @override
  Widget build(BuildContext context) {
    final itemsList = List<String>.generate(10, (n) => "List item ${n}");
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(itemsList[index]),
          child: InkWell(
              onTap: () {
                print("${itemsList[index]} clicked");
              },
              child: Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.only(top: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.r),
                  color: Kwhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(KProfile);
                          },
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r),
                                color: Kwhite,
                              ),
                              child: Image.asset("assets/images/man.png")),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Arvind ",
                              style: TextStyle(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW800,
                                  color: KdarkText),
                            ),
                            SizedBox(
                              height: 7.w,
                            ),
                            Text(
                              "Flutter Developer",
                              style: TextStyle(
                                  fontSize: kTwelveFont,
                                  fontWeight: FontWeight.normal,
                                  color: Klightblack.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Kgreen,
                      radius: 5,
                    )
                  ],
                ),
              )),
        );
        //ListTile(title: Text('${itemsList[index]}'));
      },
    );
  }
}
