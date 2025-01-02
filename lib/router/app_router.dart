import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/errorpage.dart';
import 'package:taskmanagement_firebase/Views/Task/homepage.dart';
import 'package:taskmanagement_firebase/Views/Auth/login_page.dart';
import 'package:taskmanagement_firebase/Views/Auth/signup_page.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) {
          return SignupPage();
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(),
    redirect: (context, state) {
      final authProvider = Provider.of<AuthService>(context, listen: false);
      // final isAuthenticated = authProvider.isAuthenticated;
      // if (isAuthenticated) {
      //   if (state.fullPath == AppRoutes.login ||
      //       state.fullPath == AppRoutes.signup) {
      //     return AppRoutes.home;
      //   }
      // } else {
      //   if (state.fullPath != AppRoutes.login &&
      //       state.fullPath != AppRoutes.signup) {
      //     return AppRoutes.login;
      //   }
      // }
      // return null;
      // if (isAuthenticated == false) return AppRoutes.login;
      // return null;
    },
  );
}
