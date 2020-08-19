import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:architect/models/project/ProjectModel.dart';
import 'package:architect/services/drawing/DrawingViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetailPage extends StatefulWidget {
  final ProjectModel projectModel;
  ProjectDetailPage({this.projectModel});
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  DrawingViewModel _drawingViewModel;

  Widget build(BuildContext context) {
    _drawingViewModel = Provider.of<DrawingViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectModel.projectName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              //height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1.0,
                    spreadRadius: 2.0),
              ], color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Project Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                      Text(widget.projectModel.projectName,
                          style: TextStyle(color: Colors.black, fontSize: 14.0))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Work type",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                      Text(widget.projectModel.workTypes.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 14.0))
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: _drawingViewModel
                    .getDrawingsByProjectId(widget.projectModel.id),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: Text("Loading"));
                    case ConnectionState.active:
                    case ConnectionState.done:
                    default:
                      if (snapshot.data.docs.length == 0) {
                        return Center(child: Text("No Drawings Found"));
                      } else {
                        List<DrawingModel> drawings = snapshot.data.docs
                            .map((e) => DrawingModel.fromMap(e.data(), e.id))
                            .toList();
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.0),
                            itemBuilder: (context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 1.0,
                                        spreadRadius: 5.0)
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                        drawings[index].drawingImageUrl),
                                    Text(drawings[index].drawingDescription)
                                  ],
                                ),
                              );
                            });
                      }
                  }
                })
          ],
        ),
      ),
    );
  }
}
