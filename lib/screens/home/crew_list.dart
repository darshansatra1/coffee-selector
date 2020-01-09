import 'package:coffee_crew/models/crew.dart';
import 'package:coffee_crew/screens/home/crew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CrewList extends StatefulWidget {
  @override
  _CrewListState createState() => _CrewListState();
}

class _CrewListState extends State<CrewList> {
  @override
  Widget build(BuildContext context) {
    final crews=Provider.of<List<Crew>>(context)??[];
    return ListView.builder(
      itemCount: crews.length,
      itemBuilder: (context,index){
        return CrewTile(crew:crews[index]);
      },
    );
  }
}