import 'package:base_flutter_app/ui/auth/auth_component.dart';
import 'package:base_flutter_app/ui/auth/auth_screen.dart';
import 'package:base_flutter_app/ui/details_screen.dart';
import 'package:base_flutter_app/ui/home/home_component.dart';
import 'package:base_flutter_app/ui/home/home_screen.dart';
import 'package:base_flutter_app/ui/splash/splash_component.dart';
import 'package:base_flutter_app/ui/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: _Routes.splash,
  restorationScopeId: "router",
  routes: <RouteBase>[
    _splashRoute,
    _authRoute,
    _homeRoute,
  ],
);

final _splashRoute = GoRoute(
  path: _Routes.splash,
  builder: (context, state) {
    return SplashComponent(
      child: SplashScreen(
        onOpenHome: () => context.go(_Routes.home),
        onOpenAuth: () => context.go(_Routes.auth),
      ),
    );
  },
);

final _authRoute = GoRoute(
  path: _Routes.auth,
  builder: (context, state) {
    return AuthComponent(
      child: AuthScreen(onOpenHome: () => context.go(_Routes.home)),
    );
  },
);

final _homeRoute = GoRoute(
  path: _Routes.home,
  builder: (context, state) => HomeComponent(
    child: HomeScreen(
      onItemClick: (item) => context.go(_Routes.homeDetails),
    ),
  ),
  routes: <RouteBase>[
    GoRoute(
      path: '/details',
      builder: (context, state) {
        return DetailsScreen(onBackClick: () => context.go(_Routes.home),);
      },
    ),
  ],
);

class _Routes {
  static const splash = "/";
  static const home = "/home";
  static const homeDetails = "/home/details";
  static const auth = "/auth";
}
