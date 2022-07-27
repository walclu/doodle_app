import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodle_app/models/daily_task.dart';
import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';

class DataBaseService {
  final String uid;

  DataBaseService({required this.uid});

  // UID
  final CollectionReference uidCollection =
      FirebaseFirestore.instance.collection('uids');

  //PROJEKTE AUF DIE ICH ZUGRIFF HABE
  final CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('projects');

  late final Query unapproved =
      projectCollection.where("permissions", arrayContains: uid);

  //DAILYS AUF DIE ICH ZUGRIFF HABE
  final CollectionReference dailyTaskCollection =
  FirebaseFirestore.instance.collection('dailyTasks');

  late final Query unapprovedDaily =
  dailyTaskCollection.where("permissions", arrayContains: uid);



  Future updateUids(String email, String uid) async {
    return await uidCollection.doc(email).set({
      'uid': uid,
    });
  }

  //USERDATA
  Future updateUserData(String name, String email) async {
    return await projectCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }


  //PROJEKT
  Future updateProject(String name, bool done, List<Todo> todos,
      List<String> userPermissions, int color) async {
    return await projectCollection.doc(name).set({
      'name': name,
      'done': done,
      'color': color,
      'todos': todos.map((todo) {
        return {
          'name': todo.name,
          'state': todo.state,
          'whenToStart' : todo.whenToStart,
          'whenToBeDone': todo.whenToBeDone,
          'members': todo.members.cast<String>()
        };
      }).toList(),
      'permissions': userPermissions,
    });
  }

  Future createProject(String name, bool done, List<Todo> todos,
      List<String> userPermissions, int color) async {
    String safeProjectName = name + "_" + uid;
    return await projectCollection.doc(safeProjectName).set({
      'name': safeProjectName,
      'done': done,
      'color': color,
      'todos': [],
      'permissions': userPermissions,
    });
  }

  Future addUserToProject(String newUserUid, Project project) async {
    project.userPermissions.add(newUserUid);
    projectCollection.doc(project.name).set({
      'name': project.name,
      'done': project.done,
      'color': project.color,
      'todos': project.todos.map((todo) {
        return {
          'name': todo.name,
          'state': todo.state,
          'whenToStart' : todo.whenToStart,
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
        color: doc['color'] ?? 0xff443a49,
        userPermissions: doc['permissions'].cast<String>(),
        todos: doc["todos"].map<Todo>((todo) {
          return Todo(
              name: todo["name"],
              state: todo["state"],
              whenToStart: todo["whenToStart"],
              whenToBeDone: todo["whenToBeDone"],
              members: todo["members"].cast<String>());
        }).toList(),
      );
    }).toList();
  }

  //DAILY-TASKS
  Future updateDailyTask(DailyTaskFirestore dailyTaskFirestore) async {
    return await dailyTaskCollection.doc(uid).set({
      'dailies': dailyTaskFirestore.dailies.map((dailyTask) {
        return {
          'name': dailyTask.name,
          'done': dailyTask.done,
          'category': dailyTask.category,
        };
      }).toList(),
      'permissions': dailyTaskFirestore.permissions
    });
  }

  Stream<List<DailyTaskFirestore>?> get dailyTaskListStream{
    return unapprovedDaily.snapshots().map(_dailyTaskListFromSnapshot);
  }

  List<DailyTaskFirestore> _dailyTaskListFromSnapshot(QuerySnapshot snapshot) {
    dynamic unsorted = snapshot.docs.map((doc) {
      return DailyTaskFirestore(
        permissions: doc['permissions'].cast<String>(),
        dailies: doc["dailies"].map<DailyTask>((daily) {
          return DailyTask(
              name: daily["name"],
              done: daily["done"],
              category: daily["category"],
          );
        }).toList(),
      );
    }).toList();

    for( DailyTaskFirestore firebaseDoc in unsorted){
      if (firebaseDoc.permissions[0] == uid)
      {
        unsorted.remove(firebaseDoc);
        unsorted.insert(0, firebaseDoc);
      }
    }
    for (DailyTaskFirestore firebaseDoc in unsorted){
      print(firebaseDoc.permissions);
    }

    return unsorted;
  }

  }


