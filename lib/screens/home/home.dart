import 'package:coffee_crew/models/crew.dart';
import 'package:coffee_crew/screens/home/crew_list.dart';
import 'package:coffee_crew/screens/home/settings_form.dart';
import 'package:coffee_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home extends StatelessWidget {
  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return Container(
          padding:EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
      );
      });
    }
    return StreamProvider<List<Crew>>.value(
      value: DatabaseService().crews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("COffee Crew"),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: ()async{
                  await _auth.signOut();
              },
              label: Text("Log out"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: ()=>_showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
             image:AssetImage('assets/coffee_bg.png'),
             fit: BoxFit.cover,
            ),
          ), 
          child: CrewList(),
        ),
      ),
    );
  }
}