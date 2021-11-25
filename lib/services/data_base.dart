import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/models/permission.dart';
import 'package:doodle_app/models/project.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  final CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('projects');

  late final Query unapproved = projectCollection.where("permissions", arrayContains: uid); 
  
  final CollectionReference uidCollection =
      FirebaseFirestore.instance.collection('uids');

  Future updateUserData(String name, String email) async {
    return await projectCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future updateUids(String email, String uid) async {
    return await uidCollection.doc(email).set({
      'uid': uid,
    });
  }

  Future updateProject(String name, bool done, List<int> data,
      List<String> userPermissions) async {
    return await projectCollection.doc(name).set({
      'name': name,
      'done': done,
      'data': data,
      'permissions': userPermissions,
    });
  }

  Future createProject(String name, bool done, List<int> data,
      List<String> userPermissions) async {
    String safeProjectName = name + "_" + uid;
    return await projectCollection.doc(safeProjectName).set({
      'name': safeProjectName,
      'done': done,
      'data': data,
      'permissions': userPermissions,
    });
  }


  Future addUserToProject(String newUserUid, Project project) async {
    project.userPermissions.add(newUserUid); 
    projectCollection.doc(project.name).set({
      'name': project.name,
      'done': project.done,
      'data': project.data,
      'permissions': project.userPermissions,
    });
  }

  Stream<List<Project>?> get projectListStream {
    return unapproved
        .snapshots()
        .map(_projectListFromSnapshot);
  }

  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Project(
        name: doc['name'] ?? '',
        done: doc['done'] ?? false,
        data: doc['data'].cast<int>(),
        userPermissions: doc['permissions'].cast<String>(),
      );
    }).toList();
  }
}
