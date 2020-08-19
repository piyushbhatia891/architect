import 'package:architect/models/project/ProjectModel.dart';
import 'package:architect/services/project/ProjectViewApi.dart';
import 'package:architect/shared/utils/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectViewModel extends ChangeNotifier{
  ProjectViewApi _api=locator<ProjectViewApi>();
  List<ProjectModel> projects;
  Future addNewPet(ProjectModel projectModel){
    return _api.addNewProject(projectModel);
  }

  Stream<QuerySnapshot> getPets(){
    return _api.getProjeccts();
  }

  Future<DocumentSnapshot> getProjectById(String id){
    return _api.getProjectById(id);
  }
}