import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/screens/setting/bloc/setting_bloc.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/dialogue/language_selection_dialogue.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showOption = false;
  String language = "English";
  late Future<String?> _roleFuture;

  @override
  void initState() {
    super.initState();
    _roleFuture = _getRole();
  }

  Future<String?> _getRole() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString('role');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<String?>(
                future: _roleFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final role = snapshot.data;
                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return SettingsList(
                        lightTheme: const SettingsThemeData(
                            settingsListBackground: AppColors.whiteColor),
                        sections: [
                          SettingsSection(
                            title: Center(
                              child: Text(
                                'setting'.tr(),
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            tiles: [
                              SettingsTile(
                                onPressed: (context) async {
                                  String? selectedLanguage =
                                      await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const LanguageSelectionDialog();
                                    },
                                  );

                                  if (selectedLanguage != null) {
                                    // print('Selected Language: $selectedLanguage');
                                    setState(() {
                                      language = selectedLanguage;
                                    });
                                    if (language.toLowerCase() == "amharic") {
                                      context
                                          .setLocale(const Locale('am', 'ET'));
                                    } else {
                                      context
                                          .setLocale(const Locale('en', 'US'));
                                    }
                                  }
                                },
                                leading: const Icon(Icons.language),
                                title: Text("language".tr()),
                                description: Text(language),
                              ),
                              if (role == 'employer')
                                SettingsTile(
                                    onPressed: (context) {
                                      context
                                          .read<HomeBloc>()
                                          .add(GetEmployeeRequest());
                                      context.router
                                          .push(const EmployerRequestRoute());
                                    },
                                    leading: const Icon(Icons.people),
                                    title: Text(
                                      "my_request_title".tr(),
                                    )),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            BlocConsumer<SettingBloc, SettingState>(
              listener: (context, state) {
                if (state is Logout) {
                  context.router.push(const LoginRoute());
                }
                if (state is LogoutError) {
                  print(state.message);
                  AppConfig.getMassenger(context, "Error while loggin out");
                  //todo -> show message if login failed
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(50.h),
                  child: CustomButton(
                    onTap: state is LogoutLoading
                        ? null
                        : () async {
                            final instance =
                                await SharedPreferences.getInstance();
                            instance.remove('role');
                            if (context.mounted) {
                              context.read<SettingBloc>().add(LogoutEvent());
                            }
                          },
                    lable: "logout".tr(),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
