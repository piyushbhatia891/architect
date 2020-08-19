import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
ProgressDialog createProgressDialogObject(BuildContext context){
  return new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
}
void styleProgressDialog(ProgressDialog progressDialog,String message){
  progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Padding(padding: const EdgeInsets.all(10.0),child:CircularProgressIndicator()),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
  );
}

Future<bool> showProgressBar(ProgressDialog progressDialog)async{
  bool dialogBoxShown= await progressDialog.show();
  if(dialogBoxShown)
    return Future.value(true);
}

updateProgressBarContent(ProgressDialog progressDialog,String message){
  progressDialog.update(message: message);
}

Future<bool> hideProgressBar(ProgressDialog progressDialog)async{
  bool dialogBoxHidden= await progressDialog.hide();
  if(dialogBoxHidden)
    return Future.value(true);
}