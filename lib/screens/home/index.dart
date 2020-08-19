import 'package:architect/models/project/ProjectModel.dart';
import 'package:architect/services/project/ProjectViewModel.dart';
import 'package:architect/shared/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProjectViewModel _projectViewModel;
  Widget build(BuildContext context) {
    _projectViewModel=Provider.of<ProjectViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Constants.APP_NAME),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Text("Hi"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey.shade400, size: 12.0),
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.blue),
              title: Text("Projects"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey.shade400, size: 12.0),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey.shade400, size: 12.0),
            ),
            ListTile(
              leading: Icon(Icons.cloud_off, color: Colors.blue),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey.shade400, size: 12.0),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton.icon(onPressed: (){

            },
                icon: Icon(Icons.add),
                label: Text("Create New Project")
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _projectViewModel.getPets(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                List<ProjectModel> projects=snapshot
                    .data
                    .docs.map((e) => ProjectModel
                    .fromMap(e.data(), e.id)).toList();
                return GridView.builder(
                    itemCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: (){
                          //TODO
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.0,
                                  spreadRadius: 5.0,
                                  color: Colors.grey.shade400)
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                projects[index].projectName,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),

                            ],
                          ),
                        ),
                      );
                    });
              }
            )
          ],
        ),
      ),
    );
  }
}
