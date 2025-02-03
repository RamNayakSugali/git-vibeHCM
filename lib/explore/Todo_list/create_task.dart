// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class task extends StatefulWidget {
  const task({super.key});

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  // define a list of options for the dropdown
  final List<String> _task = ["In Progress", "Delayed", "Done", "Pedding"];

  // the selected value
  String? _selectedStatus;

  TextEditingController Createcontroller = TextEditingController();
  TextEditingController Statedatecontroller = TextEditingController();
  TextEditingController Enddatecontroller = TextEditingController();
  TextEditingController Descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbackground,
        appBar: const VibhoAppBar(
          bColor: Kbackground,
          title: "Create Task",
          dontHaveBackAsLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(13.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomFormField(
                  maxLines: 1,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    readOnly: false,
                    labelText: "Project Name",
                    controller: Createcontroller,
                    hintText: "project name"),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      child: CustomFormField(
                        maxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                          readOnly: false,
                          labelText: "Start Date",
                          controller: Statedatecontroller,
                          hintText: "dd/mm/yyyy"),
                    ),
                    SizedBox(
                      width: 160.w,
                      child: CustomFormField(
                        maxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                          readOnly: false,
                          labelText: "End Date",
                          controller: Enddatecontroller,
                          hintText: "dd/mm/yyyy"),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomFormField(
                  maxLines: 3,
                    readOnly: false,
                    labelText: "Description",
                    controller: Descriptioncontroller,
                    // contentPadding: const EdgeInsets.symmetric(
                    //     vertical: 50.0, horizontal: 10.0),
                    hintText: "Description"),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30)),
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },

                    underline: Container(),

                    dropdownColor: Kwhite,
                    elevation: 0,

                    isExpanded: true,

                    // The list of options
                    items: _task
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  e,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      color: Ktextcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                        .toList(),

                    // Customize the selected item
                    selectedItemBuilder: (BuildContext context) => _task
                        .map((e) => Padding(
                              padding: EdgeInsets.only(
                                  left: 5.w, top: 5.h, bottom: 5.h),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/indata.png",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    e,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.lightBlue,
                                        fontWeight: kFW500),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Image.asset("assets/images/info.png",width: 20,),
                    Text(
                      "The task will assign to yourself only ",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Klightgray,
                          fontWeight: kFW500),
                    )
                  ],
                ),
                 SizedBox(height: 170.h,),
                 CustomButton(
                  Color: KOrange,
                  borderRadius: BorderRadius.circular(20.r),
                  height: 36.h,
                  textColor: Kwhite,
                  fontSize: 13.sp,
                  fontWeight: kFW800,
                  label: "Create Task", isLoading: false, onTap: (){

                 })
              ],
            ),
          ),
        ));
  }
}
