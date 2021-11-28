import 'package:doodle_app/models/permissions.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_base.dart';

class PermissionHandle extends StatelessWidget {

  final int index;
  final Permission permission;

  PermissionHandle({required this.index, required this.permission});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    DataBaseService(uid: user!.uid).permission2Project(permission.invUid, permission.invProject).then((value) async  {
      await DataBaseService(uid: user.uid).updateProjects(
          value['name'],
          value['done'],
          value['data'].cast<int>(),
          value['permissions'].cast<String>());
    });


    return Container();
  }
}
