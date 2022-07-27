import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompetitionsOverview extends StatefulWidget {
  const CompetitionsOverview({ Key? key }) : super(key: key);

  @override
  State<CompetitionsOverview> createState() => _CompetitionsOverviewState();
}

class _CompetitionsOverviewState extends State<CompetitionsOverview> {
  @override
  Widget build(BuildContext context) {
    final dailies = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];
    final user = Provider.of<UserMod>(context);
    int page = 0; 

    return Scaffold(
      backgroundColor: backGroundColor,
      body: 
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                    itemCount: dailies.length,
                    itemBuilder: (BuildContext context, int index ){
                      return ListTile(
                        title: Text(dailies[index].permissions[0]),
                      );
                    }
                    ),
                
              ],
            ),
          ),
        
      
    );
  }
}