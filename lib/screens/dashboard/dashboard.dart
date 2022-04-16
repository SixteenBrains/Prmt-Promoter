import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashBoard({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const DashBoard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('DashBoard'),
      ),
    );
  }
}
