import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/SignupPage/SignUpBloc.dart';
import 'package:bazaronet_fresh/SignupPage/SignupModel/SignupModel.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';

class SignupPage extends StatefulWidget {
  Data data;
  SignupPage({this.data});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupBloc _signupBloc;
  double _minimumPadding = 5.0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                      Text("Sign Up",
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
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name field must contain a value';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
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
                        primaryColorDark: Color.fromRGBO(239, 121, 57, 1),),
                      child: Container(
                          margin: EdgeInsets.only(left: _minimumPadding*3, right: _minimumPadding*3, top: _minimumPadding*4),
                          child: TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Mobile number field can't be NULL";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Mobile No.',
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
                              obscureText: true,
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
                      child:  ButtonTheme(
                        height: 50.0,
                        minWidth: 150.0,
                        child:
                        RaisedButton(
                          color: Color.fromRGBO(239, 121, 57, 1),
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              Map body = new Map();
                              body['email']=emailController.text;
                              body['phone']=mobileController.text;
                              body['name']=nameController.text;
                              body['password']=passwordController.text;
                              body['role']="USER";
                              _formKey.currentState.reset();
                              _signupBloc.signUp(body);
                            }
                          },
                          child: StreamBuilder<ApiResponse<SignUpModel>>(
                            stream: _signupBloc.signUpStream,
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
                                    print("Case 2:"+snapshot.data.data.sId);
                                    navigateScreen(context);
                                    break;
                                  case Status.ERROR:
                                    print("Case 3");
                                    Fluttertoast.showToast(
                                        msg: "Email address and phone number must be unique",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    return Text("Sign Up", style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white
                                    ));
                                    break;
                                }
                              }

                                return Text("Sign Up", style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white
                                ));

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
                                builder: (context) => loginpage(data: widget.data)));
                          },
                          child: Text("Already have an account", style: TextStyle(
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

  navigateScreen(context) async{
    Future.delayed(Duration.zero, () async {
      Fluttertoast.showToast(
          msg: "Sign up Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:
      (context) => loginpage(data: widget.data,)));
    });
  }

  @override
  void initState() {
    _signupBloc=SignupBloc();
  }
}