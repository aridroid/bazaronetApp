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
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height*.1,
                        width: MediaQuery.of(context).size.width*.87,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/twitter.png"),
                                  )
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/google.png")
                                  )
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/facebook.png")
                                  )
                              ),
                            ),
                          ],
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
    prefs.setString('token', data.token);
  }
}