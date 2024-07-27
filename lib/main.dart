import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/firebase_options.dart';

import 'config/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initApp();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('am', 'ET')],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => EmployerRepositroy()),
        RepositoryProvider(create: (_) => UserAuthDetailRepository())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: const [Locale('en', 'US'), Locale('am', 'ET')],
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: "Mulish"),
        home: ScreenUtilInit(
            designSize: const Size(360, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: _appRouter.config(),
                debugShowCheckedModeBanner: false,
              );
            }),
      ),
    );
  }
}
