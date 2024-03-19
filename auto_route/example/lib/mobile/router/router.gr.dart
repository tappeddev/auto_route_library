// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:example/mobile/screens/home_page.dart' as _i1;
import 'package:example/mobile/screens/profile/my_books_page.dart' as _i2;
import 'package:example/mobile/screens/profile/profile_page.dart' as _i3;
import 'package:example/mobile/screens/profile/settings_page.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $RootRouter extends _i5.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    MyBooksRoute.name: (routeData) {
      final args = routeData.argsAs<MyBooksRouteArgs>(
          orElse: () => const MyBooksRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.MyBooksPage(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ProfilePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MyBooksPage]
class MyBooksRoute extends _i5.PageRouteInfo<MyBooksRouteArgs> {
  MyBooksRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MyBooksRoute.name,
          args: MyBooksRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MyBooksRoute';

  static const _i5.PageInfo<MyBooksRouteArgs> page =
      _i5.PageInfo<MyBooksRouteArgs>(name);
}

class MyBooksRouteArgs {
  const MyBooksRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'MyBooksRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.ProfilePage]
class ProfileRoute extends _i5.PageRouteInfo<void> {
  const ProfileRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SettingsPage]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
