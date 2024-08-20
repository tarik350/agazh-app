import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: EmployerHomeRoute.page,
        ),
        AutoRoute(
            page: SiraAppRoute.page, initial: true, guards: [AuthGuard()]),

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
        AutoRoute(
          page: RoleRoute.page,
        ),
        AutoRoute(
          page: MyFlowRoute.page,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
        ),
        // AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: EmployerStepperRoute.page),
        AutoRoute(page: EmployeeStepperRoute.page),
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
    final bool hasSeenOnboarding =
        preferences.getBool('hasSeenOnboarding') ?? false;
    final User? user = _auth.currentUser;

    if (!hasSeenOnboarding) {
      router.push(const OnboardingRoute());
    } else if (user == null) {
      router.replace(const LoginRoute());
    } else {
      resolver.next();
    }
  }
}
