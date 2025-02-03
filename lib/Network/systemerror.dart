// ignore_for_file: camel_case_types
import '../untils/export_file.dart';

class System_Error extends StatefulWidget {
  const System_Error({super.key});

  @override
  State<System_Error> createState() => _System_ErrorState();
}

class _System_ErrorState extends State<System_Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset("assets/images/error.png"),
      ),
    );
  }
}
