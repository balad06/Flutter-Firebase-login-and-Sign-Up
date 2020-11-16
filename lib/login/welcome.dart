import 'package:flutter/material.dart';
import './loginScreen.dart';

class WelcomePage extends StatelessWidget {
  static const String id = '/WelcomePage';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 200,
              left: -50,
              child: Opacity(
                opacity: .45,
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -40,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: 145.0,
                  height: 145.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Positioned(
              right: -50,
              bottom: -30,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
             Positioned(
              top: 200,right: -20,
              child: Opacity(
                opacity: .6,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration:
                      BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .25),
                    Padding(
                      child: Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 42.0,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0))),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, LoginPage.id,
                                  arguments: 'Sign In');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 22.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New Here?   ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.id,
                                arguments: 'Register');
                          },
                          child: Text(
                            'Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
