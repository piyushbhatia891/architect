import 'dart:ui';
import 'package:architect/models/drawing/DrawingModel.dart';
import 'package:architect/models/markings/MarkingModel.dart';
import 'package:architect/screens/drawing_detail/drawing_points_list.dart';
import 'package:architect/services/drawing/DrawingViewModel.dart';
import 'package:architect/services/markings/MarkingViewModel.dart';
import 'package:architect/shared/utils/locator.dart';
import 'package:architect/shared/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
class DrawingArea {
  Offset point;
  DrawingArea({this.point});
}

class DrawingDetail extends StatefulWidget {
  final DrawingModel drawingModel;
  DrawingDetail({this.drawingModel});
  @override
  _DrawingDetailState createState() => _DrawingDetailState();
}

class _DrawingDetailState extends State<DrawingDetail> {

  DrawingPointsList _pointsList=locator<DrawingPointsList>();
  DrawingViewModel _drawingViewModel;
  MarkingViewModel _markingViewModel;
  ProgressDialog _progressDialog;

  MarkingModel _markingModel=MarkingModel();
  @override
  void initState() {
    super.initState();
    _progressDialog=createProgressDialogObject(context);
    styleProgressDialog(_progressDialog, "Saving the markings");
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    _drawingViewModel=Provider.of<DrawingViewModel>(context);
    _markingViewModel=Provider.of<MarkingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: ()async{
              try {
                await showProgressBar(_progressDialog);
                _markingModel.drawingId = widget.drawingModel.id;
                _markingModel.pointsMarked = _pointsList
                    .points
                    .map((e) => _markingModel.pointsMarked.add(e.point))
                    .toList();
                _markingModel.markedByUser = "to be updated";
                _markingModel.markedOn = DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString();
                await _markingViewModel.addNewDrawing(
                    _markingModel, widget.drawingModel.projectId);
                Future.delayed(Duration(seconds: 2), () {
                  _pointsList.points.clear();
                  hideProgressBar(_progressDialog).then((value) {
                    return showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: AlertDialog(
                          actions: [
                            RaisedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.arrow_forward_ios),
                                label: Text("Ok"))
                          ],
                          title: Text("Thanks"),
                          content: Text("You have added a new Marking"),
                        )
                    );
                  });
                });
              } on Exception catch(exception){
                return showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: AlertDialog(
                      actions: [
                        RaisedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_forward_ios),
                            label: Text("Ok"))
                      ],
                      title: Text("Error"),
                      content: Text(exception.toString()),
                    )
                );
              }
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _markingViewModel.getMarkingsByProjectIdAndDrawingId(widget.drawingModel.id,
            widget.drawingModel.projectId),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: Text("Loading"));
            case ConnectionState.active:
            case ConnectionState.done:
            default:
              List<dynamic> markings=snapshot.data.docs.map((e) => MarkingModel
                  .fromMap(e.data(), e.id)).map((e) => e.markedOn).toList();
              _pointsList.points.addAll(markings);
              return Stack(
                children: <Widget>[
                  _buildBackGroundContainer(),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 0.80,
                            height: height * 0.80,
                            decoration: BoxDecoration(
                              //color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        widget.drawingModel.drawingImageUrl)
                                )
                            ),
                            child: GestureDetector(
                              onPanDown: (details) {
                                this.setState(() {
                                  _pointsList.points.add(DrawingArea(
                                      point: details.localPosition,
                                      ));
                                });
                              },
                              onPanUpdate: (details) {
                                this.setState(() {
                                  _pointsList.points.add(DrawingArea(
                                      point: details.localPosition,
                                      ));
                                });
                              },
                              onPanEnd: (details) {
                                print(details.toString());
                                this.setState(() {
                                  _pointsList.points.add(null);
                                });
                              },
                              child: SizedBox.expand(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: CustomPaint(
                                    painter: MyCustomPainter(
                                        points: _pointsList.points),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              );
          }
        })
    );
  }
}

class _buildBackGroundContainer extends StatelessWidget {
  const _buildBackGroundContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(138, 35, 135, 1.0),
                Color.fromRGBO(233, 64, 87, 1.0),
                Color.fromRGBO(242, 113, 33, 1.0),
              ])),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  List<DrawingArea> points;
  MyCustomPainter({@required this.points});
  Paint areaPaint=Paint()
  ..strokeCap = StrokeCap.round
  ..isAntiAlias = true
  ..color = Colors.black
  ..strokeWidth = 2.0;
  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()
      ..color = Colors.black54.withOpacity(0);
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for (int x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        canvas.drawLine(points[x].point, points[x + 1].point, areaPaint);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[x].point], areaPaint);
      }
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
