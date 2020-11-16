import 'package:flutter/material.dart';

class Topbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> myActions;
  Topbar(this.title, this.myActions);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
        ),
        actions: myActions);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
