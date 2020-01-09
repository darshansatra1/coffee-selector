import 'package:coffee_crew/models/user.dart';
import 'package:coffee_crew/services/database.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_crew/shared/constants.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength; 
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData=snapshot.data;
          return Form(
          key:_formkey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your settings.',
                style: TextStyle(fontSize:16),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration.copyWith(hintText: 'Name'),
                validator: (val)=>val.isEmpty?'Please enter a name':null,
                onChanged: (val)=>setState(()=>_currentName=val),
              ),
              SizedBox(height: 20,),
              //dropdown
              DropdownButtonFormField(
                decoration:textInputDecoration.copyWith(hintText: ''),
                value: _currentSugars??userData.sugars,
                items: sugars.map((sugar){
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(),
                onChanged: (val)=>setState(()=>_currentSugars=val),
              ),
              //slider
              Slider(
                value: (_currentStrength??userData.strength).toDouble(),
                min: 100,
                max: 900,
                divisions: 8,
                activeColor: Colors.brown[_currentStrength??100],
                inactiveColor: Colors.white,
                onChanged: (val)=>setState(()=>_currentStrength=val.round()),
              ),
              RaisedButton(
                color: Colors.brown,
                child: Text('Update',
                style: TextStyle(fontSize: 15,color: Colors.white),),
                onPressed: ()async{
                  if(_formkey.currentState.validate())
                  {
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars??userData.sugars,
                      _currentStrength??userData.strength,
                      _currentName??userData.name
                    );
                    Navigator.pop(context);
                  }
                },
              )
              
            ],
          ),
        );
        }else{
          return Loading();
        }
        
      }
    );
  }
}