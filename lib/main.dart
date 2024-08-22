import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/screens/auth/login/bloc/login_bloc.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/screens/profile/cubit/profile_cubit.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/screens/setting/bloc/setting_bloc.dart';
import 'config/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.primaryColor,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true));

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
        RepositoryProvider(create: (_) => EmployerRepository()),
        RepositoryProvider(create: (_) => UserAuthDetailRepository()),
        RepositoryProvider(create: (_) => EmployeeRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RoleCubit(),
          ),
          BlocProvider(create: (_) => SettingBloc()),
          BlocProvider(create: (_) => LoginBloc()),
          BlocProvider(
            create: (context) => HomeBloc(
                employeeRepository: context.read<EmployeeRepository>(),
                employerRepository: context.read<EmployerRepository>()),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
                employeeRepository: context.read<EmployeeRepository>(),
                employerRepository: context.read<EmployerRepository>()),
          ),
        ],
        child: MaterialApp(
          key: UniqueKey(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: const [Locale('en', 'US'), Locale('am', 'ET')],
          locale: context.locale,
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
      ),
    );
  }
}
