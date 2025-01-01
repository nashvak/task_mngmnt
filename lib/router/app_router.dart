import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/errorpage.dart';
import 'package:taskmanagement_firebase/Views/Auth/homepage.dart';
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
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoggingIn = state.location == AppRoutes.signup;
      if (!isAuthenticated && !isLoggingIn) return AppRoutes.signup;
      if (isAuthenticated && isLoggingIn) return AppRoutes.home;
      return null; // No redirection
    },
  );
}
