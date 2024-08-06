import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/screens/app/cubit/app_cubit.dart';
import 'package:mobile_app/screens/home/employee/view/employee_home.dart';
import 'package:mobile_app/screens/home/employer/view/employer_home_screen.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/screens/setting/view/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SiraAppScreen extends StatefulWidget {
  const SiraAppScreen({super.key});

  @override
  State<SiraAppScreen> createState() => _SiraAppScreenState();
}

class _SiraAppScreenState extends State<SiraAppScreen> {
  late List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    initWidgets();
  }

  Future<void> initWidgets() async {
    final preference = await SharedPreferences.getInstance();
    final role = preference.getString('role');
    setState(() {
      _widgets = role == UserRole.employee.name
          ? [const EmployeeHomeScreen(), const SettingScreen()]
          : [const EmployerHomeScreen(), const SettingScreen()];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(0),
      child: Scaffold(
        body: _widgets.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : BlocBuilder<AppCubit, int>(
                builder: (context, state) {
                  return _widgets[state];
                },
              ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 0,
              selectedItemColor: AppColors.primaryColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          child: BlocBuilder<AppCubit, int>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state,
                onTap: (value) {
                  context.read<AppCubit>().changeView(value);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Setting"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
