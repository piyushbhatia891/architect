import 'package:architect/models/user/userModel.dart';
import 'package:architect/shared/utils/color_utils.dart';
import 'package:architect/shared/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show jsonEncode;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert' show jsonEncode,jsonDecode;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './loginUtils.dart';
class GmailLogin extends StatefulWidget {
  _gmailLoginState createState() => _gmailLoginState();
}

class _gmailLoginState extends State<GmailLogin> {
  UserModel _userModel;
  SharedPreferences preferences;
  bool isLoggingIn=false;
  ProgressDialog progressDialog;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String providerId;
  bool isLoading=false;
  bool isLoggedIn=false;
  TabController controller;
  List<String> emails;
  dynamic _currentPosition;
  Map<String,dynamic> nearByFriends={};
  String userId;
  initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    isLoggingIn=false;
    this.initializePreferences();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=createProgressDialogObject(context);
    styleProgressDialog(progressDialog,'Loading Settings For You');
    return _gmailUI();
  }


  getAddress() async{
    await preferences.setString("user", jsonEncode(_userModel));
    Firestore.instance.collection('users').document(_userModel.userEmail)
        .setData(_userModel.toJson());
    hideProgressBar(progressDialog).then((val) async{
        Navigator.popAndPushNamed(context, Routes.HOME);
      });
  }
  Widget _gmailUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: HexColor("#D34B3E"),
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () async
            {
              setState(() {
                isLoggingIn = true;
              });
              FirebaseUser user = await signInWithGoogle();
              if (user == null) {
                await showDialogBoxIfUserDidNotLogin
                  (context)
                    .then((val) {
                  setState(() {
                    isLoggingIn = false;
                  });
                });
              }
              else {
                setState(() {
                  isLoggingIn = false;
                });
                await showProgressBar(progressDialog);
                user.providerData.where((val) {
                  providerId = val.providerId;
                  return val.providerId == 'google.com' ||
                      val.providerId == 'facebook.com';
                }).forEach((providerData) {
                  validateDetailsForUserFromDBAndLogin(providerData, user.uid)
                      .then((UserModel model) async {
                    _userModel = model;
                    if (model != null) {
                      await preferences.setString("loggedInMedium", providerId);
                      this.geoInfo();
                    }
                  });
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In With Google",
                  style: TextStyle(fontSize:18.0,color: Colors.white, fontWeight: FontWeight.bold),
                ),
                isLoggedIn ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.green),
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
