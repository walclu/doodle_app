import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/models/permission.dart';
import 'package:doodle_app/models/project.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  final CollectionReference uidCollection =
      FirebaseFirestore.instance.collection('uids');

  Future updateUserData(String name, String email) async {
    return await userDataCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future updateUids(String email, String uid) async {
    return await uidCollection.doc(email).set({
      'uid': uid,
    });
  }

  Future updateProjects(String name, bool done, List<int> data,
      List<String> userPermissions) async {
    return await userDataCollection.doc(uid).collection('notes').doc(name).set({
      'name': name,
      'done': done,
      'data': data,
      'permissions': userPermissions,
    });
  }

  Future addUserToProject(String newUserUid, String projectName) async {
    userDataCollection
        .doc(newUserUid)
        .collection('permissions')
        .doc(projectName)
        .set({
      'invUid': uid,
      'invProject': projectName,
    });
  }

  Stream<List<Project>?> get projectListStream {
    return userDataCollection
        .doc(uid)
        .collection('notes')
        .snapshots()
        .map(_projectListFromSnapshot);
  }


  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
           print("++++++++++++++++++++++++++++++++++++++++++++++++++++"); 
      print(doc); 
      return Project(
        name: doc['name'] ?? '',
        done: doc['done'] ?? false,
        data: doc['data'].cast<int>(),
        userPermissions: doc['permissions'].cast<String>(),
      );
    }).toList();
  }

  Stream<List<Permission>?> get inv_projectListStream {
    return userDataCollection
        .doc(uid)
        .collection('permissons')
        .snapshots()
        .map(_inv_projectListFromSnapshot);
  }

  List<Permission> _inv_projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Permission(uid: doc["invUid"], name: doc["invProject"]);
    }).toList();
  }
  //get user doc stream
/*

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
