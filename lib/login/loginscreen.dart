import 'package:Login/homePage.dart';
import 'package:flutter/material.dart';
import './login widgets/beziercontainer.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
enum AuthMode { Signup, Login }

class LoginPage extends StatefulWidget {
  static const String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Widget _submitButton(String type) {
    return InkWell(
      onTap: () {
        setState(() {
          _isLoading = true;
        });
        _submit();
      },
      child: _isLoading
          ? CircularProgressIndicator()
          : Container(
              height: 50,
              width: MediaQuery.of(context).size.width * .45,
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.blueAccent,
              ),
              child: Text(
                _authMode == AuthMode.Login ? 'Login' : 'Register',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Widget _createAccountLabel(String type) {
    if (_authMode == AuthMode.Login) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New Here?',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _switchAuthMode();
              },
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else if (_authMode == AuthMode.Signup) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Have an Account?',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _switchAuthMode();
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  Future<void> _showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(ctx).pop();
              }),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        Provider.of<Auth>(context, listen: false)
            .singin(_authData['email'], _authData['password']);
      } else {
        Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
    } catch (error) {
      print(error);
      var errorMessage = 'Couldn\'t authenticate ';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'email is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'INVALID_EMAIL ';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'WEAK_PASSWORD';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'EMAIL_NOT_FOUND';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'INVALID_PASSWORD';
      }
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _formWidget(String type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                      print(_authData['email']);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                      print(_authData['password']);
                    },
                  ),
                  AnimatedContainer(
                    constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              } else {
                                return null;
                              }
                            }
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // if (_isLoading) CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget checkboxorforgot(String type) {
    String resetemail;
    if (_authMode == AuthMode.Login) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Provider.of<Auth>(context).resetPassword(resetemail);
          },
          child: Text(
            'Forgot Password ?',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context).settings.arguments;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            BezierContainer(),
            Positioned(
              left: -2,
              bottom: 200,
              child: Opacity(
                opacity: .4,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent, shape: BoxShape.circle),
                ),
              ),
            ),
            Positioned(
              right: -20,
              bottom: -20,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .125),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      alignment: Alignment.center,
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: height * .015),
                    _formWidget(type),
                    SizedBox(height: height * .0015),
                    checkboxorforgot(type),
                    SizedBox(height: height * .04),
                    _submitButton(type),
                    _createAccountLabel(type),
                    InkWell(
                      onTap: () {
                        Provider.of<Auth>(context,listen: false).signInWithGoogle().then((result) {
                          if (result != null) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomePage.id);
                          }
                        });
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Image.asset('assets/images/googlelogo.png'),
                          ),
                          Text(_authMode == AuthMode.Login
                              ? 'Google Signin'
                              : 'Google SignUp')
                        ],
                      ),
                    )
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
