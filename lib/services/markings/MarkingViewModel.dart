import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:architect/models/markings/MarkingModel.dart';
import 'package:architect/services/drawing/DrawingViewApi.dart';
import 'package:architect/services/markings/MarkingViewApi.dart';
import 'package:architect/shared/utils/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarkingViewModel extends ChangeNotifier{
  MarkingViewApi _api=locator<MarkingViewApi>();

  Future addNewDrawing(MarkingModel markingModel,String projectId)async{
    return this._api.addNewMarking(markingModel, projectId);
  }

  Stream<QuerySnapshot> getMarkingsByProjectIdAndDrawingId(String drawingId,String projectId) {
    return this._api.getMarkingsByProjectIdAndDrawingId(drawingId, projectId);
  }

}