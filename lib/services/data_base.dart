import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';

class DataBaseService {
  final String uid;

  DataBaseService({required this.uid});

  final CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('projects');

  late final Query unapproved =
      projectCollection.where("permissions", arrayContains: uid);

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

  Future createTodo(String projectId, Todo todo) async {
    return await projectCollection.doc(projectId).collection('todos').doc(todo.name).set({
          'name': todo.name,
          'state': todo.state,
          'whenToBeDone': todo.whenToBeDone,
          'members': todo.members.cast<String>()
      });
  }

  Future updateProject(String name, bool done, List<Todo> todos,
      List<String> userPermissions) async {
    return await projectCollection.doc(name).set({
      'name': name,
      'done': done,
      'todos': todos.map((todo) {
        return {
          'name': todo.name,
          'state': todo.state,
          'whenToBeDone': todo.whenToBeDone,
          'members': todo.members.cast<String>()
        };
      }).toList(),
      'permissions': userPermissions,
    });
  }

  Future createProject(String name, bool done, List<Todo> todos,
      List<String> userPermissions) async {
    String safeProjectName = name + "_" + uid;
    return await projectCollection.doc(safeProjectName).set({
      'name': safeProjectName,
      'done': done,
      'todos': [],
      'permissions': userPermissions,
    });
  }

  Future addUserToProject(String newUserUid, Project project) async {
    project.userPermissions.add(newUserUid);
    projectCollection.doc(project.name).set({
      'name': project.name,
      'done': project.done,
      'todos': project.todos.map((todo) {
        return {
          'name': todo.name,
          'state': todo.state,
          'whenToBeDone': todo.whenToBeDone,
          'members': todo.members.cast<String>()
        };
      }).toList(),
      'permissions': project.userPermissions,
    });
  }

  Stream<List<Project>?> get projectListStream {
    return unapproved.snapshots().map(_projectListFromSnapshot);
  }

  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Project(
        name: doc['name'] ?? '',
        done: doc['done'] ?? false,
        userPermissions: doc['permissions'].cast<String>(),
        todos: doc["todos"].map<Todo>((todo) {
          return Todo(
              name: todo["name"],
              state: todo["state"],
              whenToBeDone: todo["whenToBeDone"],
              members: todo["members"].cast<String>());
        }).toList(),
      );
    }).toList();
  }

  }


