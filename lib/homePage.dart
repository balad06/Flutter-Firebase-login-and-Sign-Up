import 'package:Login/widgets/appbar.dart';
import 'package:Login/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const id = '/homePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Topbar('Home', []),
        drawer: MainDrawer(),
        body: Container(
          child: Text('Logged In...'),
        ));
  }
}
