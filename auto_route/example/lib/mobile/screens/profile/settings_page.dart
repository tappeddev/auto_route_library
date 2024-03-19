import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 300,
        width: 200,
        color: Colors.redAccent,
        child: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            AutoRouter.of(context).popForced();
          },
        ),
      ),
    );
  }
}
