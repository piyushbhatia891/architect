import 'package:architect/models/project/ProjectModel.dart';
import 'package:architect/services/project/ProjectViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatefulWidget {
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectViewModel _projectViewModel;
  Widget build(BuildContext context) {
    _projectViewModel = Provider.of<ProjectViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _projectViewModel.getPets(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text("Loading"));
              case ConnectionState.active:
              case ConnectionState.done:
              default:
                if (snapshot.data.docs.length > 0) {
                  List<ProjectModel> projects = snapshot.data.docs
                      .map((e) => ProjectModel.fromMap(e.data(), e.id))
                      .toList();
                  return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: 5,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          leading: Icon(Icons.work),
                          title: Text(projects[index].projectName),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 12.0,
                            color: Colors.grey.shade400,
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text("No projects Found"),
                  );
                }
            }
          }),
    );
  }
}
