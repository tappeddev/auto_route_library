import 'package:auto_route/auto_route.dart';
import 'package:example/mobile/router/router.gr.dart';

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
        AutoRoute(
          path: 'settings',
          page: SettingsRoute.page,
        ),
      ],
    ),
  ];
}
