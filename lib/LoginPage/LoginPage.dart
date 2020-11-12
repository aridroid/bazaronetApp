import 'package:bazaronet_fresh/HomePage/HomePage.dart';
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

  @override
  void initState() {
    _loginBloc = LoginBloc();
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
                              right: _minimumPadding*3,
                              top: _minimumPadding*4
                          ),
                          child: TextFormField(
                            controller: emailController,
                            validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                              border: new OutlineInputBorder(
                                borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
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
                          margin: EdgeInsets.only(left: _minimumPadding*3,
                              right: _minimumPadding*3,
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
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => SignupPage(data: widget.data)));
                          },
                          child: Text("Don't have an account", style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white
                          ),),
                        ),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                (context) => HomePage()));
          }
          else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder:
                (context) => productdetails(data: widget.data)));
          }
    });
  }

  saveUserData(LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', data.sId);
    prefs.setString('userName', data.name);
    prefs.setString('email', data.email);
  }
}