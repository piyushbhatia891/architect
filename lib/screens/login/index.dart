import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  _LoginPageState createState()=>_LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.30,
                  ),
                  Text(
                    Constants.APP_NAME,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold
                    ),
                  ),Text(
                    Constants.APP_SUB_TITLE,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.orange
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Colors.orange,
                            height: 36,
                          )),
                    ),
                    Text("Sign In",style: TextStyle(color: Colors.grey,fontSize: 16.0),),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.orange,
                            height: 36,
                          )),
                    ),
                  ]),
                  GmailLogin(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.40,
                  ),
                    RaisedButton(
                      onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      },
                      child:Center(
                        child:Text("test")
                      )
                    )

                ],

              ),


      ),
    );
  }
}