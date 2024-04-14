import 'package:auto_route/auto_route.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        // Startup routes
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: MainScaffoldRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: OnboardingInfoRoute.page),

        // Auth routes
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: EnterMoneyRoute.page),
      ];
}
