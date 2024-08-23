import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: EmployerHomeRoute.page,
        ),
        AutoRoute(
          page: SiraAppRoute.page,
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(page: EmployeeProfileRoute.page),
        AutoRoute(page: EmployerProfileRoute.page),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: OtpRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(page: RoleRoute.page),
        AutoRoute(
          page: MyFlowRoute.page,
        ),
        AutoRoute(page: OnboardingRoute.page, keepHistory: false),
        AutoRoute(page: EmployerStepperRoute.page, keepHistory: false),
        AutoRoute(page: EmployeeStepperRoute.page, keepHistory: false),
        AutoRoute(page: EmployeeDetailRoute.page),
        AutoRoute(page: EmployerRequestRoute.page),
        AutoRoute(page: EmployeeFeedbackRoute.page)
      ];
}

class AuthGuard extends AutoRouteGuard {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final isAuthenticated = getit<AuthService>().isAuthenticated;
    final bool hasSeenOnboarding =
        preferences.getBool('hasSeenOnboarding') ?? false;

    if (!hasSeenOnboarding) {
      router.push(const OnboardingRoute());
    }
    if (isAuthenticated) {
      resolver.next();
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}
