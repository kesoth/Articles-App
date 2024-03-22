import 'package:articles_app/cubit/articles/cubit.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/utils/route_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(
    Builder(builder: (context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          BlocProvider<ArticleCubit>(
            create: (context) => ArticleCubit(),
          ),
        ],
        child: EasyLocalization(
          supportedLocales: const [
            Locale('fr', 'FR'),
            Locale('de', 'DE'),
          ],
          saveLocale: true,
          path: 'assets/translations',
          fallbackLocale: const Locale('fr', 'FR'),
          child: const MyApp(),
        ),
      );
    }),
  );
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
