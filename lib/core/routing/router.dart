import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/ui/views/user_details_view.dart';
import 'package:mvvm_demo/ui/views/login_view.dart';
import 'package:mvvm_demo/ui/views/registration_view.dart';
import 'package:mvvm_demo/ui/views/welcome_view.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.detailsRoute:
        return pageRoute(
          const DetailView(),
          settings,
        );
      case Routes.welcomeRoute:
        return pageRoute(
          const WelcomeView(),
          settings,
        );
      case Routes.loginRoute:
        return pageRoute(const LoginView(), settings);
      case Routes.registerRoute:
        return pageRoute(const ResgistrationView(), settings);

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Text('This Page does not Exist'),
                ));
    }
  }

  static pageRoute(Widget child, RouteSettings settings) {
    return FadeRoute(
      child: child,
      routeName: settings.name,
      arguments: settings.arguments,
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;
  final Object? arguments;

  FadeRoute({
    this.child,
    this.routeName,
    this.arguments,
  }) : super(
          settings: RouteSettings(name: routeName, arguments: arguments),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
