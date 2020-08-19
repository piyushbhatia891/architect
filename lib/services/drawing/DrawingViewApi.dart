import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawingViewApi{
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  final String drawingCollectionName;
  CollectionReference _drawingCollectionRef;
  DrawingViewApi(this.drawingCollectionName){
    this._drawingCollectionRef=_firebaseFirestore.collection(drawingCollectionName);
  }

  Future addNewDrawing(DrawingModel drawingModel)async{
    return this._drawingCollectionRef
        .doc(drawingModel.projectId)
        .collection("drawings")
        .add(drawingModel.toJson());
  }

  Future<DocumentSnapshot> getDrawingById(String drawingId,String projectId) {
    return this._drawingCollectionRef
        .doc(projectId)
        .collection("drawings")
        .doc(drawingId)
        .get();
  }

  Stream<QuerySnapshot> getDrawingsByProjectId(String projectId) {
    return this._drawingCollectionRef
        .doc(projectId)
        .collection("drawings")
        .snapshots();
  }
}