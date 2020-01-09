import 'package:coffee_crew/screens/authenticate/authenticate.dart';
import 'package:coffee_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_crew/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return user!=null?Home():Authenticate();
  }
}