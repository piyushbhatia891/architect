class MarkingModel{
  String id,drawingId,markedByUser,markedOn;
  List<dynamic> pointsMarked;
  MarkingModel({this.id,this.drawingId,this.markedByUser,this.markedOn,this.pointsMarked});
  factory MarkingModel.fromMap(Map snapshot,String id){
    return new MarkingModel(
      id: id,
      drawingId: snapshot["drawingId"] ?? "",
      markedByUser: snapshot["markedByUser"] ?? "",
      markedOn: snapshot["markedOn"] ?? "",
      pointsMarked: snapshot["pointsMarked"] ?? {}
    );
  }
  toJson(){
    return {
      "id":id,
      "drawingId":drawingId,
      "markedByUser":markedByUser,
      "markedOn":markedOn,
      "pointsMarked":pointsMarked
    };
  }
}