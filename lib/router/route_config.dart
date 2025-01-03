import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/onboarding_page.dart';
import 'package:flutter_base/ui/pages/app_start/splash/splash_page.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/main/main_page.dart';
import 'package:flutter_base/ui/pages/photo_view/photo_view_page.dart';
import 'package:flutter_base/ui/pages/profile/change_password/change_password_page.dart';
import 'package:flutter_base/ui/pages/profile/delete_account/delete_account_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_base/ui/pages/profile/term_policy/term_policy_page.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_page.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final homeNavigationKey = GlobalKey<NavigatorState>();
  static final notificationNavigationKey = GlobalKey<NavigatorState>();
  static final profileNavigationKey = GlobalKey<NavigatorState>();
  static Alice alice = Alice(
    configuration: AliceConfiguration(
      showNotification: false,
    ),
  );

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    initialLocation: splash,
    navigatorKey: alice.getNavigatorKey(),
  );

  ///main page
  static const String splash = '/';
  static const String onBoarding = 'on_boarding';
  static const String home = 'home';
  static const String signIn = 'sign_in';
  static const String signUp = 'sign_up';
  static const String notification = 'notification';

  static const String notificationList = 'notification_list';
  static const String notificationDetail = 'notification_detail';
  static const String photoView = 'photo_view';
  static const String profile = 'profile';
  static const String updateProfile = 'update_profile';
  static const String updateAvatar = 'update_avatar';
  static const String deleteAccount = 'delete_account';
  static const String changePassword = 'change_password';
  static const String termPolicy = 'term_policy';
  static const String player = 'player';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashPage(),
      routes: <RouteBase>[
        GoRoute(
          name: onBoarding,
          path: onBoarding,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          name: signIn,
          path: signIn,
          builder: (context, state) => SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                AppNavigator(context: context).pushReplacementNamed(
                  AppRouter.home,
                );
              }),
            ],
          ),
        ),
        GoRoute(
          name: signUp,
          path: signUp,
          builder: (context, state) => const SignUpPage(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainPage(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: homeNavigationKey,
              routes: [
                GoRoute(
                  name: home,
                  path: home,
                  builder: (context, state) => const HomePage(),
                  routes: [
                    GoRoute(
                      name: photoView,
                      path: photoView,
                      builder: (context, state) => PhotoViewPage(
                        arguments: PhotoViewArguments(
                          images: state.extra! as List<String>,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: notificationNavigationKey,
              routes: [
                GoRoute(
                  name: notification,
                  path: notification,
                  builder: (context, state) => const Placeholder(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: profileNavigationKey,
              routes: [
                GoRoute(
                  name: profile,
                  path: profile,
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                      name: updateProfile,
                      path: updateProfile,
                      builder: (context, state) => const UpdateProfilePage(),
                    ),
                    GoRoute(
                      name: updateAvatar,
                      path: updateAvatar,
                      builder: (context, state) => const UpdateAvatarPage(),
                    ),
                    GoRoute(
                      name: deleteAccount,
                      path: deleteAccount,
                      builder: (context, state) => const DeleteAccountPage(),
                    ),
                    GoRoute(
                      name: changePassword,
                      path: changePassword,
                      builder: (context, state) => const ChangePasswordPage(),
                    ),
                    GoRoute(
                      name: termPolicy,
                      path: termPolicy,
                      builder: (context, state) => const TermPolicyPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
