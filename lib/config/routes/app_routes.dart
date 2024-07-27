import 'package:auto_route/auto_route.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(page: OtpRoute.page),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: RoleRoute.page,
        ),
        AutoRoute(
          page: MyFlowRoute.page,
        ),
        AutoRoute(page: OnboardingRoute.page, initial: true),
        AutoRoute(
          page: EmployerStepperRoute.page,
        )
      ];
}
