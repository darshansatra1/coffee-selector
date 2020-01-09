import 'package:coffee_crew/screens/authenticate/register.dart';
import 'package:coffee_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIN=true;

  void toggleView(){
    setState(() {
      showSignIN=!showSignIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIN){
      return SignIn(toggleView:toggleView);
    }
    else
    {
      return Register(toggleView:toggleView);
    }
  }
}