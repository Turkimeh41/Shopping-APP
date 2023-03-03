// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module8/model/http_exception.dart';
import 'package:module8/provider/user.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 94, 6, 89),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const _AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthCard extends StatefulWidget {
  const _AuthCard();

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<_AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void errorHandler(String error, BuildContext ctx) {
    if (error == 'EMAIL_EXISTS') {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            'INVALID, an Email is already associated with another user',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          )));
    } else if (error == 'TOO_MANY_ATTEMPTS_TRY_LATER') {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(duration: const Duration(seconds: 2), content: Text('Too many attempts, try again in later', style: TextStyle(color: Theme.of(context).colorScheme.error))));
    } else if (error == 'EMAIL_NOT_FOUND') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(duration: const Duration(seconds: 2), content: Text('INVALID, Email not Found', style: TextStyle(color: Theme.of(context).colorScheme.error))));
    } else if (error == 'INVALID_PASSWORD') {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(duration: const Duration(seconds: 2), content: Text('INVAlID, wrong Password.', style: TextStyle(color: Theme.of(context).colorScheme.error))));
    } else if (error == 'USER_DISABLED') {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(duration: const Duration(seconds: 2), content: Text('INVALID, THE User has been banned', style: TextStyle(color: Theme.of(context).colorScheme.error))));
    } else {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(duration: const Duration(seconds: 2), content: Text('INVALID, Undefined Error', style: TextStyle(color: Theme.of(context).colorScheme.error))));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if /* Log user in*/ (_authMode == AuthMode.Login) {
        await Provider.of<User>(context, listen: false).userLOGIN(_authData['email']!, _authData['password']!);
      } else /* Sign user up*/ {
        await Provider.of<User>(context, listen: false).userSIGNUP(_authData['email']!, _authData['password']!);
      }
    } on HTTPException catch (error) {
      errorHandler(error.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints: BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                        : null,
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                      onPressed: _submit,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      ),
                      child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP')),
                TextButton(
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground)),
                  child: Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
