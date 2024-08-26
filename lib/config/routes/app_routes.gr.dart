// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:mobile_app/data/models/employee.dart' as _i19;
import 'package:mobile_app/flow_builder_screen.dart' as _i11;
import 'package:mobile_app/screens/app/view/sira_app.dart' as _i16;
import 'package:mobile_app/screens/auth/login/view/change_password_screen.dart'
    as _i1;
import 'package:mobile_app/screens/auth/login/view/login_screen.dart' as _i10;
import 'package:mobile_app/screens/auth/otp/view/otp_screen.dart' as _i13;
import 'package:mobile_app/screens/auth/register/view/register_screen.dart'
    as _i14;
import 'package:mobile_app/screens/employee/view/employee_registration_screen.dart'
    as _i5;
import 'package:mobile_app/screens/employer_regisration/view/employer_stepper_screen.dart'
    as _i9;
import 'package:mobile_app/screens/home/employee/view/employee_feedback_screen.dart'
    as _i3;
import 'package:mobile_app/screens/home/employer/view/employer_home_screen.dart'
    as _i6;
import 'package:mobile_app/screens/home/employer/view/employer_requests_screen.dart'
    as _i8;
import 'package:mobile_app/screens/home/employer/widgets/empoyee_detail_screen.dart'
    as _i2;
import 'package:mobile_app/screens/onboarding/view/onboarding_screen.dart'
    as _i12;
import 'package:mobile_app/screens/profile/view/employee_profile_screen.dart'
    as _i4;
import 'package:mobile_app/screens/profile/view/employer_profile_screen.dart'
    as _i7;
import 'package:mobile_app/screens/role/enums/selected_role.dart' as _i20;
import 'package:mobile_app/screens/role/view/role_screen.dart' as _i15;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    ChangePasswordRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ChangePasswordScreen(),
      );
    },
    EmployeeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeDetailRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EmployeeDetailScreen(
          key: args.key,
          employee: args.employee,
        ),
      );
    },
    EmployeeFeedbackRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EmployeeFeedbackScreen(),
      );
    },
    EmployeeProfileRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmployeeProfileScreen(),
      );
    },
    EmployeeStepperRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmployeeStepperScreen(),
      );
    },
    EmployerHomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EmployerHomeScreen(),
      );
    },
    EmployerProfileRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EmployerProfileScreen(),
      );
    },
    EmployerRequestRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.EmployerRequestScreen(),
      );
    },
    EmployerStepperRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.EmployerStepperScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginScreen(),
      );
    },
    MyFlowRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MyFlowScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.OnboardingScreen(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.OtpScreen(
          key: args.key,
          verificationId: args.verificationId,
          route: args.route,
          userRole: args.userRole,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RegisterScreen(),
      );
    },
    RoleRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.RoleScreen(),
      );
    },
    SiraAppRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SiraAppScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChangePasswordScreen]
class ChangePasswordRoute extends _i17.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EmployeeDetailScreen]
class EmployeeDetailRoute extends _i17.PageRouteInfo<EmployeeDetailRouteArgs> {
  EmployeeDetailRoute({
    _i18.Key? key,
    required _i19.Employee employee,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          EmployeeDetailRoute.name,
          args: EmployeeDetailRouteArgs(
            key: key,
            employee: employee,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployeeDetailRoute';

  static const _i17.PageInfo<EmployeeDetailRouteArgs> page =
      _i17.PageInfo<EmployeeDetailRouteArgs>(name);
}

class EmployeeDetailRouteArgs {
  const EmployeeDetailRouteArgs({
    this.key,
    required this.employee,
  });

  final _i18.Key? key;

  final _i19.Employee employee;

  @override
  String toString() {
    return 'EmployeeDetailRouteArgs{key: $key, employee: $employee}';
  }
}

/// generated route for
/// [_i3.EmployeeFeedbackScreen]
class EmployeeFeedbackRoute extends _i17.PageRouteInfo<void> {
  const EmployeeFeedbackRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployeeFeedbackRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeFeedbackRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EmployeeProfileScreen]
class EmployeeProfileRoute extends _i17.PageRouteInfo<void> {
  const EmployeeProfileRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployeeProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeProfileRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EmployeeStepperScreen]
class EmployeeStepperRoute extends _i17.PageRouteInfo<void> {
  const EmployeeStepperRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployeeStepperRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeStepperRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EmployerHomeScreen]
class EmployerHomeRoute extends _i17.PageRouteInfo<void> {
  const EmployerHomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerHomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EmployerProfileScreen]
class EmployerProfileRoute extends _i17.PageRouteInfo<void> {
  const EmployerProfileRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployerProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerProfileRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.EmployerRequestScreen]
class EmployerRequestRoute extends _i17.PageRouteInfo<void> {
  const EmployerRequestRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployerRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerRequestRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.EmployerStepperScreen]
class EmployerStepperRoute extends _i17.PageRouteInfo<void> {
  const EmployerStepperRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmployerStepperRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerStepperRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MyFlowScreen]
class MyFlowRoute extends _i17.PageRouteInfo<void> {
  const MyFlowRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MyFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyFlowRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.OnboardingScreen]
class OnboardingRoute extends _i17.PageRouteInfo<void> {
  const OnboardingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.OtpScreen]
class OtpRoute extends _i17.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i18.Key? key,
    required String verificationId,
    required String route,
    _i20.UserRole? userRole,
    String phoneNumber = '',
    List<_i17.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(
            key: key,
            verificationId: verificationId,
            route: route,
            userRole: userRole,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static const _i17.PageInfo<OtpRouteArgs> page =
      _i17.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.verificationId,
    required this.route,
    this.userRole,
    this.phoneNumber = '',
  });

  final _i18.Key? key;

  final String verificationId;

  final String route;

  final _i20.UserRole? userRole;

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, verificationId: $verificationId, route: $route, userRole: $userRole, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i14.RegisterScreen]
class RegisterRoute extends _i17.PageRouteInfo<void> {
  const RegisterRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.RoleScreen]
class RoleRoute extends _i17.PageRouteInfo<void> {
  const RoleRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoleRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.SiraAppScreen]
class SiraAppRoute extends _i17.PageRouteInfo<void> {
  const SiraAppRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SiraAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'SiraAppRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
