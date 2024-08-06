// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:mobile_app/data/models/employee.dart' as _i18;
import 'package:mobile_app/data/models/Employer.dart' as _i20;
import 'package:mobile_app/flow_builder_screen.dart' as _i9;
import 'package:mobile_app/screens/app/view/sira_app.dart' as _i15;
import 'package:mobile_app/screens/auth/login/view/login_screen.dart' as _i8;
import 'package:mobile_app/screens/auth/otp/view/otp_screen.dart' as _i11;
import 'package:mobile_app/screens/auth/register/view/register_screen.dart'
    as _i13;
import 'package:mobile_app/screens/employee/view/employee_registration_screen.dart'
    as _i4;
import 'package:mobile_app/screens/employer_regisration/view/employer_stepper_screen.dart'
    as _i7;
import 'package:mobile_app/screens/home/employee/view/employee_feedback_screen.dart'
    as _i2;
import 'package:mobile_app/screens/home/employer/view/employer_home_screen.dart'
    as _i5;
import 'package:mobile_app/screens/home/employer/view/employer_requests_screen.dart'
    as _i6;
import 'package:mobile_app/screens/home/employer/widgets/empoyee_detail_screen.dart'
    as _i1;
import 'package:mobile_app/screens/onboarding/view/onboarding_screen.dart'
    as _i10;
import 'package:mobile_app/screens/profile/view/employee_profile_screen.dart'
    as _i3;
import 'package:mobile_app/screens/profile/view/employer_profile_screen.dart'
    as _i12;
import 'package:mobile_app/screens/role/enums/selected_role.dart' as _i19;
import 'package:mobile_app/screens/role/view/role_screen.dart' as _i14;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    EmployeeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeDetailRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EmployeeDetailScreen(
          key: args.key,
          employee: args.employee,
        ),
      );
    },
    EmployeeFeedbackRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.EmployeeFeedbackScreen(),
      );
    },
    EmployeeProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeProfileRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.EmployeeProfileScreen(
          key: args.key,
          employee: args.employee,
        ),
      );
    },
    EmployeeStepperRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmployeeStepperScreen(),
      );
    },
    EmployerHomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmployerHomeScreen(),
      );
    },
    EmployerRequestRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EmployerRequestScreen(),
      );
    },
    EmployerStepperRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EmployerStepperScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginScreen(),
      );
    },
    MyFlowRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MyFlowScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.OnboardingScreen(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.OtpScreen(
          key: args.key,
          verificationId: args.verificationId,
          route: args.route,
          userRole: args.userRole,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ProfileScreen(
          key: args.key,
          employer: args.employer,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterScreen(),
      );
    },
    RoleRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RoleScreen(),
      );
    },
    SiraAppRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SiraAppScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.EmployeeDetailScreen]
class EmployeeDetailRoute extends _i16.PageRouteInfo<EmployeeDetailRouteArgs> {
  EmployeeDetailRoute({
    _i17.Key? key,
    required _i18.Employee employee,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          EmployeeDetailRoute.name,
          args: EmployeeDetailRouteArgs(
            key: key,
            employee: employee,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployeeDetailRoute';

  static const _i16.PageInfo<EmployeeDetailRouteArgs> page =
      _i16.PageInfo<EmployeeDetailRouteArgs>(name);
}

class EmployeeDetailRouteArgs {
  const EmployeeDetailRouteArgs({
    this.key,
    required this.employee,
  });

  final _i17.Key? key;

  final _i18.Employee employee;

  @override
  String toString() {
    return 'EmployeeDetailRouteArgs{key: $key, employee: $employee}';
  }
}

/// generated route for
/// [_i2.EmployeeFeedbackScreen]
class EmployeeFeedbackRoute extends _i16.PageRouteInfo<void> {
  const EmployeeFeedbackRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmployeeFeedbackRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeFeedbackRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EmployeeProfileScreen]
class EmployeeProfileRoute
    extends _i16.PageRouteInfo<EmployeeProfileRouteArgs> {
  EmployeeProfileRoute({
    _i17.Key? key,
    required _i18.Employee employee,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          EmployeeProfileRoute.name,
          args: EmployeeProfileRouteArgs(
            key: key,
            employee: employee,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployeeProfileRoute';

  static const _i16.PageInfo<EmployeeProfileRouteArgs> page =
      _i16.PageInfo<EmployeeProfileRouteArgs>(name);
}

class EmployeeProfileRouteArgs {
  const EmployeeProfileRouteArgs({
    this.key,
    required this.employee,
  });

  final _i17.Key? key;

  final _i18.Employee employee;

  @override
  String toString() {
    return 'EmployeeProfileRouteArgs{key: $key, employee: $employee}';
  }
}

/// generated route for
/// [_i4.EmployeeStepperScreen]
class EmployeeStepperRoute extends _i16.PageRouteInfo<void> {
  const EmployeeStepperRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmployeeStepperRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeStepperRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EmployerHomeScreen]
class EmployerHomeRoute extends _i16.PageRouteInfo<void> {
  const EmployerHomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmployerHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerHomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EmployerRequestScreen]
class EmployerRequestRoute extends _i16.PageRouteInfo<void> {
  const EmployerRequestRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmployerRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerRequestRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EmployerStepperScreen]
class EmployerStepperRoute extends _i16.PageRouteInfo<void> {
  const EmployerStepperRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmployerStepperRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployerStepperRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MyFlowScreen]
class MyFlowRoute extends _i16.PageRouteInfo<void> {
  const MyFlowRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MyFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyFlowRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OnboardingScreen]
class OnboardingRoute extends _i16.PageRouteInfo<void> {
  const OnboardingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.OtpScreen]
class OtpRoute extends _i16.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i17.Key? key,
    required String verificationId,
    required String route,
    _i19.UserRole? userRole,
    String phoneNumber = '',
    List<_i16.PageRouteInfo>? children,
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

  static const _i16.PageInfo<OtpRouteArgs> page =
      _i16.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.verificationId,
    required this.route,
    this.userRole,
    this.phoneNumber = '',
  });

  final _i17.Key? key;

  final String verificationId;

  final String route;

  final _i19.UserRole? userRole;

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, verificationId: $verificationId, route: $route, userRole: $userRole, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileRoute extends _i16.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i17.Key? key,
    required _i20.Employer employer,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            employer: employer,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i16.PageInfo<ProfileRouteArgs> page =
      _i16.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.employer,
  });

  final _i17.Key? key;

  final _i20.Employer employer;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, employer: $employer}';
  }
}

/// generated route for
/// [_i13.RegisterScreen]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.RoleScreen]
class RoleRoute extends _i16.PageRouteInfo<void> {
  const RoleRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoleRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SiraAppScreen]
class SiraAppRoute extends _i16.PageRouteInfo<void> {
  const SiraAppRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SiraAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'SiraAppRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
