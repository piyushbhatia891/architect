class DrawingModel{
  String id,projectId,drawingImageUrl;
  String drawingDescription;
  DrawingModel({this.id,this.projectId,this.drawingDescription,this.drawingImageUrl});
  factory DrawingModel.fromMap(Map snapshot,String id){
    return new DrawingModel(
      id: id,
      projectId: snapshot["projectId"] ?? "",
      drawingDescription: snapshot["drawingDescription"] ?? "",
      drawingImageUrl: snapshot["drawingUrl"] ?? ""
    );
  }

  toJson(){
    return {
      "id":id,
      "projectId":projectId,
      "drawingDescription":drawingDescription,
      "drawingImageUrl":drawingImageUrl
    };
  }

}