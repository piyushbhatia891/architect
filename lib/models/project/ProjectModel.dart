class ProjectModel{
  String id,projectName,projectDescription;
  List<dynamic> projectUsers,workTypes;
  ProjectModel({this.id,this.projectName,this.projectDescription,this.projectUsers,this.workTypes});
  factory ProjectModel.fromMap(Map snapshot,String id){
    return new ProjectModel(
      id: id,
      projectName: snapshot["projectName"] ?? "",
      projectDescription: snapshot["projectDescription"] ?? "",
      projectUsers: snapshot["projectUsers"]  ?? [],
      workTypes: snapshot["workTypes"] ?? []
    );
  }

  toJson(){
    return {
      "id":id,
      "projectName":projectName,
      "projectDescription":projectDescription,
      "projectUsers":projectUsers,
      "workTypes":workTypes
    };
  }
}