import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {

  final String uid;

  final CollectionReference userDataCollection =
  FirebaseFirestore.instance.collection('userData');

  final CollectionReference projectsCollection =
  FirebaseFirestore.instance.collection('projects');

  DataBaseService({required this.uid});

  Future updateUserData(String name, String email) async {
    return await userDataCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future updateProjects(String name, bool done) async {
    return await projectsCollection.doc(name).set({
      'name': name,
      'done': done,
    });
  }
/*
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc['name'] ?? '',
        strength: doc['strength'] ?? 0,
        sugars: doc['sugars'] ?? '',
      );
    }).toList();
  }
  //get user doc stream


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
*/
}