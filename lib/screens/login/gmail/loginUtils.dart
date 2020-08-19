import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monkoo_dog_main/shared/models.user/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
SharedPreferences preferences;
FirebaseUser user;
Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount!=null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult authResult = await _auth.signInWithCredential(credential);
    user=authResult.user;
  }
  return user;
}



void signOutGoogle() async{
  _auth.signOut();
  googleSignIn.signOut();
}


Future<UserModel> validateDetailsForUserFromDBAndLogin(UserInfo userInfo,String uId) async{
  preferences=await SharedPreferences.getInstance();
  UserModel model;
  if (userInfo != null) {
      // Update data to server if new user
      DocumentSnapshot doc=await Firestore.instance.collection('users').document(userInfo.email).get();
      if(doc.data==null) {
        model=new UserModel(userId: uId,
          userUniqueId: userInfo.email,
          userEmail: userInfo.email,
          userName: userInfo.displayName[0].toUpperCase()+userInfo.displayName.substring(1),
          userProfileImageUrl: userInfo.photoUrl
        );
      }
      else{
        doc.data['userProfileImageUrl']=userInfo.photoUrl;
        model = UserModel.fromMap(doc.data);
      }

  }
  return model;
}

Future showDialogBoxIfUserDidNotLogin(BuildContext context){
  return showDialog(context: context,barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("It Seems there was some issue While logging in"),
          content: Text('Try Logging in'),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Ok")
            )
          ],
        );
      });
}
