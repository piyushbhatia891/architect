import 'package:architect/models/project/ProjectModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectViewApi{
  final Firestore _db=Firestore();
  CollectionReference _projectReference;
  final String project;
  ProjectViewApi(this.project){
    _projectReference=_db.collection(project);
  }

  Future addNewProject(ProjectModel projectModel)async{
    return this._projectReference.add(projectModel.toJson());
  }

  Stream<QuerySnapshot> getProjeccts(){
    return this._projectReference.snapshots();
  }

  Future<DocumentSnapshot> getProjectById(String id) {
    return this._projectReference.document(id).get();
  }

}