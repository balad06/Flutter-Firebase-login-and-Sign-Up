import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Login/login/auth.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool showmore = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          DrawerHeader(
            child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                )),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Account',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Text(
                  'v1.0.1',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
