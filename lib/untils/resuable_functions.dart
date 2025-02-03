import 'package:vibeshr/untils/export_file.dart';

class ReusableFunctions {
  static Widget centerText(data) {
    return Center(
      child: Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: kFourteenFont, fontWeight: kFW500, color: Kwhite),
      ),
    );
  }

  static Widget centerProgressBar() {
    return const Center(
        child: SpinKitFadingCircle(
      color: KOrange,
      size: 15,
    ));
  }
}
