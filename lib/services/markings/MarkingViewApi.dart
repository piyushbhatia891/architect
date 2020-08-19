import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:architect/models/markings/MarkingModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkingViewApi{
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  final String markingCollectionName;
  CollectionReference _markingCollectionRef;
  MarkingViewApi(this.markingCollectionName){
    this._markingCollectionRef=_firebaseFirestore.collection(markingCollectionName);
  }

  Future addNewMarking(MarkingModel markingModel,String projectId)async{
    return this._markingCollectionRef
        .doc(projectId)
        .collection("drawings")
        .doc(markingModel.drawingId)
        .collection("markings")
        .add(markingModel.toJson());
  }

  Stream<QuerySnapshot> getMarkingsByProjectIdAndDrawingId(String drawingId,String projectId) {
    return this._markingCollectionRef
        .doc(projectId)
        .collection("drawings")
        .doc(drawingId)
        .collection("markings")
        .snapshots();
  }
}