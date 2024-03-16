import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: kAppName,
          initialRoute: kLoginRoute,
          getPages: RouteGenerator.getPages(),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(MediaQuery.of(context)
                        .textScaleFactor
                        .clamp(1.0, 1.0))),
                child: child!);
          },
        );
      },
    );
  }
}
