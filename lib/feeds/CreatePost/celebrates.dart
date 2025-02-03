// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class Celebrates_view extends StatefulWidget {
  const Celebrates_view({super.key});

  @override
  State<Celebrates_view> createState() => _Celebrates_viewState();
}

class _Celebrates_viewState extends State<Celebrates_view> {
  Map celebratedata = {};
  ServiceController serviceController = Get.put(ServiceController());

  bool isLoading = false;
  Future celebrateListHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.celebratelist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      celebratedata = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    celebrateListHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        title: "Celebrates",
        bColor: Kbackground,
      ),
      body: isLoading == false
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: celebratedata["rows"].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    serviceController
                        .postCelebrateData(celebratedata["rows"][index]);
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Kwhite),
                    child: ListTile(
                        title: Text(
                          celebratedata["rows"][index]["title"],
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW800,
                              color: KdarkText),
                        ),
                        subtitle: Text(
                          celebratedata["rows"][index]["description"],
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.normal,
                              color: Klightblack.withOpacity(0.5)),
                        ),
                        trailing: SvgPicture.asset("assets/images/arrow.svg",
                            color: KOrange,
                            fit: BoxFit.fill,
                            semanticsLabel: 'Acme Logo')),
                  ),
                );
              })
          : const Center(
              child: SpinKitFadingCircle(
              color: KOrange,
              size: 15,
            )),
    );
  }
}
