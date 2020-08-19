import 'package:flutter/material.dart';

class DrawingsPage extends StatefulWidget {
  String project_id;
  DrawingsPage({this.project_id});
  _DrawingsPageState createState() => _DrawingsPageState();
}

class _DrawingsPageState extends State<DrawingsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drawings"),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(5, (index) {
              return Container(
                child: Column(
                  children: [Text("Drawing Name"), Text("Uploaded By")],
                ),
              );
            })
        )
    );
  }
}
