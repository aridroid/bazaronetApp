import 'package:bazaronet_fresh/SignupPage/SignupPage.dart';
import 'package:flutter/material.dart';
class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  double _minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(239, 121, 57, 1),
          elevation: 0.0,
        ),
        body: Container(
            decoration: new BoxDecoration(
                color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  ListView(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: _minimumPadding*8, bottom: _minimumPadding*8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:  BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0),
                            bottomLeft:  const Radius.circular(30.0),
                            bottomRight:  const Radius.circular(30.0),
                          )
                      ),
                      child:
                      Text("Login",
                        style: TextStyle(
                            color: Color.fromRGBO(239, 121, 57, 1),
                            fontSize: 35,fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor:Color.fromRGBO(239, 121, 57, 1),
                      primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                    ),
                    child: Container(
                        margin: EdgeInsets.only(
                            left: _minimumPadding*3,
                            right: _minimumPadding*3
                        ),
                        height:45,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            border: new OutlineInputBorder(
                              borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
                            ),
                          ),
                        )),
                  ),
                  // Theme(
                  //   data: new ThemeData(
                  //     primaryColor:Color.fromRGBO(239, 121, 57, 1),
                  //     primaryColorDark: Color.fromRGBO(239, 121, 57, 1),),
                  //   child: Container(
                  //       margin: EdgeInsets.only(left: _minimumPadding*3, right: _minimumPadding*3, top: _minimumPadding*4),
                  //       height:45,
                  //       child: TextField(
                  //         decoration: InputDecoration(
                  //           hintText: 'Enter Mobile No.',
                  //           border: new OutlineInputBorder(
                  //             borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
                  //           ),
                  //         ),
                  //       )),
                  // ),
                  Theme(
                    data: new ThemeData(
                      primaryColor:Color.fromRGBO(239, 121, 57, 1),
                      primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                    ),
                    child: Container(
                        margin: EdgeInsets.only(left: _minimumPadding*3,
                            right: _minimumPadding*3,
                            top: _minimumPadding*4),
                        height:45,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: new OutlineInputBorder(
                              borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
                            ),
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: _minimumPadding*6,
                    ),
                    // alignment: Alignment.center,
                      child: ButtonTheme(
                        height: 50.0,
                        minWidth: 150.0,
                        child: RaisedButton(
                          color: Color.fromRGBO(239, 121, 57, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          onPressed: () {

                          },
                          child: Text("Login", style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(
                      top: _minimumPadding*4,
                    ),
                    // alignment: Alignment.center,
                    child: ButtonTheme(
                      height: 50.0,
                      minWidth: 150.0,
                      child: RaisedButton(
                        color: Color.fromRGBO(239, 121, 57, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => SignupPage()));
                        },
                        child: Text("Don't have an account", style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}