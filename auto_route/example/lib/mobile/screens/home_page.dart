import 'package:auto_route/auto_route.dart';
import 'package:example/mobile/router/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage<String>()
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(context) {
    return AutoTabsRouter(
      routes: [
        MyBooksRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.topRoute.title(context)),
            actions: [
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(SettingsRoute());
                },
                icon: Icon(Icons.settings),
              )
            ],
            leading: AutoLeadingButton(ignorePagelessRoutes: true),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onTap: context.tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.source),
                label: 'Books',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
