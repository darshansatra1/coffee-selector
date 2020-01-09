import 'package:flutter/material.dart';
import 'package:coffee_crew/models/crew.dart';
class CrewTile extends StatelessWidget {
  final Crew crew;
  CrewTile({this.crew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[crew.strength],
          ),
          title: Text(crew.name),
          subtitle: Text('Takes ${crew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}