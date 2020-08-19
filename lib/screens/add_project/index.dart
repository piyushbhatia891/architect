import 'dart:html';

import 'package:architect/models/project/ProjectModel.dart';
import 'package:architect/services/project/ProjectViewModel.dart';
import 'package:architect/shared/router/routes.dart';
import 'package:architect/shared/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddProjectPage extends StatefulWidget{
  _AddProjectPageState createState()=>_AddProjectPageState();
}
class _AddProjectPageState extends State<AddProjectPage>{
  TextEditingController _projectNameController=TextEditingController();
  TextEditingController _projectDescriptionController=TextEditingController();
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  GlobalKey<FormState> _scaffoldKey=GlobalKey<FormState>();
  ProjectModel _projectModel=ProjectModel();
  ProjectViewModel _projectViewModel;
  ProgressDialog _progressDialog;
  void initState(){
    super.initState();
    _progressDialog=createProgressDialogObject(context);
    styleProgressDialog(_progressDialog, "Creating The Project");
  }
  void dispose(){
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
  }

  Widget build(BuildContext context){
    _projectViewModel=Provider.of<ProjectViewModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async{
          if(_formKey.currentState.validate()){
            _formKey.currentState.save();
            await _progressDialog.show();
            _projectViewModel.addNewPet(_projectModel);
            Future.delayed(Duration(seconds: 2),(){
              Navigator.popAndPushNamed(context, Routes.HOME);
            });
          }
        },
        label: Text("Create A Project"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Add New Project"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 100,
              controller: _projectNameController,
              validator: (val){
                if(val.trim().isEmpty)
                  return "Please enter project name";
                return null;
              },
              onSaved: (val){
                _projectModel.projectName=val;
              },
            ),
            TextFormField(
              maxLines: 5,
              maxLength: 400,
              controller: _projectDescriptionController,
              validator: (val){
                if(val.trim().isEmpty)
                  return "Please enter project description";
                return null;
              },
              onSaved: (val){
                _projectModel.projectDescription=val;
              },
            ),
          ],
        ),
      ),
    );
  }
}