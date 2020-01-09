import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_crew/models/crew.dart';
import 'package:coffee_crew/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference myCollection=Firestore.instance.collection('Darshan');
  Future updateUserData(String sugars,int strength,String name)async{
    return await myCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }
  //crew list from a snapshot
  List<Crew> _crewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Crew(
        name:doc.data['name']??'',
        strength: doc.data['strength']??0,
        sugars: doc.data['sugars']??'0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  //get coffee stream
  Stream<List<Crew>> get crews{
    return myCollection.snapshots().map(_crewListFromSnapshot);
  }

  //user doc stream
  Stream<UserData> get userData{
    return myCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}