import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/constant.dart';
import 'package:todo/helper/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: RouterConfig.route,
      initialRoute: '/homeScreen',
      defaultTransition: Transition.fade,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: kTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
