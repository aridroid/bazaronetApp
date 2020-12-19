import 'dart:convert';

import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bazaronet_fresh/LoginPage/LoginBloc.dart';
import 'package:bazaronet_fresh/LoginPage/LoginModel/LoginModel.dart';
import 'package:bazaronet_fresh/ProductDetailPage/ProductDetailPage.dart';
import 'package:bazaronet_fresh/SignupPage/SignupPage.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class loginpage extends StatefulWidget {
  Data data;
  loginpage({this.data});
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  double _minimumPadding = 5.0;
  LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    _loginBloc = LoginBloc();
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
    );

    // final AuthResult authResult = await _auth.signInWithCredential(credential);
    final User user = (await _auth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print("User:"+user.toString());
    // signOutGoogle();
    Fluttertoast.showToast(
        msg: "Hello "+user.displayName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        timeInSecForIosWeb: 1
    );
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  Future<void> faceBookLogin() async{
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // _sendTokenToServer(result.accessToken.token);
        // _showLoggedInUI();
        print("Success:"+result.accessToken.toString());
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${result.accessToken.token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        Fluttertoast.showToast(
            msg: "Hello "+profile["name"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            timeInSecForIosWeb: 1
        );
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Canceled:"+result.accessToken.toString());
        // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        print("Error:"+result.errorMessage);
        // _showErrorOnUI(result.errorMessage);
        break;
    }
    logOutFaceBook(facebookLogin);
  }
  logOutFaceBook(FacebookLogin f){
    f.logOut();
    print("User Sign Out");
  }

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
            child:  Form(
              key: _formKey,
              child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: _minimumPadding*8, bottom: _minimumPadding*1),
                      alignment: Alignment.topLeft,
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
                      Text("Login to Bazaronet",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07,bottom: MediaQuery.of(context).size.height*.05),
                      child: Text("Good to see you back",style: TextStyle(color: Colors.grey),),
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor:Color.fromRGBO(239, 121, 57, 1),
                        primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: _minimumPadding*5,
                              right: _minimumPadding*5,
                              top: _minimumPadding*4
                          ),
                          child: TextFormField(
                            controller: emailController,
                            validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                            decoration: InputDecoration(
                              prefixIcon:Icon(Icons.person_outline,color: Colors.grey,
                              ),
                              hintText: 'Username',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:  BorderSide(
                                  color:  Color.fromRGBO(239, 121, 57, 1),),
                              ),
                            ),
                          )),
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor:Color.fromRGBO(239, 121, 57, 1),
                        primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(left: _minimumPadding*5,
                              right: _minimumPadding*5,
                              top: _minimumPadding*4),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password field must contain a value';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                              hintText: 'Password',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
                              ),
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: _minimumPadding*8,
                      ),
                      // alignment: Alignment.center,
                      child: Center(
                        child: ButtonTheme(
                          height: 50.0,
                          minWidth: MediaQuery.of(context).size.width*.87,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Color.fromRGBO(239, 121, 57, 1),
                            onPressed: () {
                              if(_formKey.currentState.validate()){
                                Map body = new Map();
                                body['email']=emailController.text;
                                body['password']=passwordController.text;
                                _formKey.currentState.reset();
                                _loginBloc.login(body);
                              }
                            },
                            child: StreamBuilder<ApiResponse<LoginModel>>(
                              stream: _loginBloc.loginStream,
                              builder:(context, snapshot) {
                                if(snapshot.hasData)
                                {
                                  switch(snapshot.data.status)
                                  {
                                    case Status.LOADING:
                                      print("Case 1");
                                      print(snapshot);
                                      return CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation<Color>(
                                          Color.fromRGBO(255, 241, 232, 1),
                                        ),
                                      );
                                      break;
                                    case Status.COMPLETED:
                                      print("Case 2");
                                      saveUserData(snapshot.data.data);
                                      navigateScreen(context, snapshot.data.data.name);
                                      break;
                                    case Status.ERROR:
                                      print("Case 3");
                                      Fluttertoast.showToast(
                                          msg: "Login Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      return Text("Login", style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white
                                      ));
                                      break;
                                  }
                                }

                                return Text("Login", style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white
                                ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => SignupPage(data: widget.data)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: _minimumPadding*4,
                        ),
                        // alignment: Alignment.center,
                        child: Center(child: Text("Don't have an account?",style: TextStyle(color: Colors.black,fontSize: 16),)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                faceBookLogin();
                              },
                            child: Padding(
                              padding: EdgeInsets.only(right:30),
                              child: Image.asset("images/facebook.png", height: 50, width: 50,),
                            )
                          ),
                          InkWell(
                            onTap: () {
                              signInWithGoogle().whenComplete(() {
                                signOutGoogle();
                                print("complete");
                              });
                            },
                            child: Image.asset("images/google.png", height: 50, width: 50,)
                          ),
                          Expanded(
                            child: Container(
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }
  navigateScreen(BuildContext context, String name) async{
    Future.delayed(Duration.zero, () async {
      Fluttertoast.showToast(
          msg: "Welcome "+name,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
      if(widget.data == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => HomePage()), (Route<dynamic> route) => false);
      }
      else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => productdetails(data: widget.data)), (Route<dynamic> route) => false);
      }
    });
  }

  saveUserData(LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', data.sId);
    prefs.setString('userName', data.name);
    prefs.setString('email', data.email);
    prefs.setString('token', data.token);
  }
}