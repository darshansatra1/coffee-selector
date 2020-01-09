import 'package:coffee_crew/screens/authenticate/sign_in.dart';
import 'package:coffee_crew/screens/home/home.dart';
import 'package:coffee_crew/services/auth.dart';
import 'package:coffee_crew/shared/constants.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  String error='';
  String email='';
  String password='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.brown[500],
        actions: <Widget>[
          RaisedButton.icon(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.white)
            ),
            elevation: 0.0,
            onPressed: (){
              widget.toggleView();
            },
            label: Text("Sign In",
              style: TextStyle(fontSize: 18),
            ),
            icon: Icon(Icons.person,size: 23,),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=>val.isEmpty?'Enter an email':null,
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=>val.length<6?'Enter a password 6+ chars long':null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: ()async{
                  if(_formkey.currentState.validate())
                  {
                    setState(() {
                      loading=true;
                    });
                    dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null)
                    {
                      setState(() {
                        error='please supply a valid mail';
                        loading=false;
                      });
                    }
                    else
                    {
                      Home();
                    }
                  }
                },
                color: Colors.brown[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black),
                ),
                child: Text("Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize:14 ),
              )
            ],
          ),
        ),
      ),
    );
  }
}