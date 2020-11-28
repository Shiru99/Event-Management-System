import 'package:EventManager/Authorisations/SignIn.dart';
import 'package:EventManager/Authorisations/SignUp.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

// ignore: camel_case_types
class _authenticateState extends State<authenticate> {
  bool _signedIn = true;

  void toggleSignInUp() {
    setState(() {
      _signedIn = !_signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_signedIn) {
      return SignIn(toggleSignInUp);
    } else {
      return SignUp(toggleSignInUp);
    }
  }
}
