import 'package:auto_route/auto_route.dart';
import 'package:example/mobile/router/router.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(generateForDir: ['lib/mobile'])
class RootRouter extends $RootRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(
          path: 'books',
          page: MyBooksRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: 'profile',
          page: ProfileRoute.page,
        ),
        DetailRoute(
          path: 'settings',
          page: SettingsRoute.page,
        ),
      ],
    ),
  ];
}

class DetailRoute extends CustomRoute {
  DetailRoute({
    required super.page,
    required super.path,
    super.guards,
    super.children,
    super.initial,
  }) : super(
          customRouteBuilder: <T>(context, child, page) {
            return _customRouteBuilder<T>(
              context: context,
              child: child,
              page: page,
            );
          },
        );

  static Route<T> _customRouteBuilder<T>({
    required BuildContext context,
    required Widget child,
    required AutoRoutePage<T> page,
  }) {
    return DialogRoute(
      context: context,
      settings: page,
      useSafeArea: false,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => child,
    );
  }
}
