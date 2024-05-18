import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/authenticate/login.dart';
import 'package:flutter_project/screens/authenticate/register.dart';

class Handler extends StatefulWidget {
  const Handler({super.key});

  @override
  State<Handler> createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(
        toggleView: toggleView,
      ); //jika true maka ke laman login
    } else {
      return Register(
        toggleView: toggleView,
      ); //jika false maka ke laman register
    }
  }
}
