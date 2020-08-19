import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:architect/services/drawing/DrawingViewApi.dart';
import 'package:architect/shared/utils/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrawingViewModel extends ChangeNotifier{
  DrawingViewApi _api=locator<DrawingViewApi>();

  Future addNewDrawing(DrawingModel drawingModel)async{
    return this._api.addNewDrawing(drawingModel);
  }

  Future<DocumentSnapshot> getDrawingById(String drawingId,String projectId) {
    return this._api.getDrawingById(drawingId, projectId);
  }

  Stream<QuerySnapshot> getDrawingsByProjectId(String projectId) {
    return this._api.getDrawingsByProjectId(projectId);
  }

}