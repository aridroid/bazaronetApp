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
                      Text("Getting Started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07,bottom: MediaQuery.of(context).size.height*.05),
                      child: Text("Create account to continue",style: TextStyle(color: Colors.grey),),
                    ),
                    Theme(
                      data: new ThemeData(
                        primaryColor:Color.fromRGBO(239, 121, 57, 1),
                        primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: _minimumPadding*5,
                              right: _minimumPadding*5
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
                              prefixIcon: Icon(Icons.person_outline,color: Colors.grey,),
                              hintText: 'Full Name',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
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
                              left: _minimumPadding*5,
                              right: _minimumPadding*5,
                              top: _minimumPadding*4
                          ),
                          child: TextFormField(
                            controller: emailController,
                            validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email,color: Colors.grey,),
                              hintText: 'Email',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
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
                          margin: EdgeInsets.only(left: _minimumPadding*5, right: _minimumPadding*5, top: _minimumPadding*4),
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
                              prefixIcon: Icon(Icons.call_rounded,color: Colors.grey,),
                              hintText: 'Mobile Number',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
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
                          margin: EdgeInsets.only(left: _minimumPadding*5,
                              right: _minimumPadding*5,
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
                              prefixIcon: Icon(Icons.lock_outline,color: Colors.grey,),
                              hintText: 'Password',
                              border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:  BorderSide(color:  Color.fromRGBO(239, 121, 57, 1),),
                              ),
                            ),
                          )),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: _minimumPadding*10,
                        ),
                        // alignment: Alignment.center,
                        child:  ButtonTheme(
                          height: 50.0,
                          minWidth: MediaQuery.of(context).size.width*.87,
                          child:
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
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
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => loginpage(data: widget.data)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: _minimumPadding*4,
                          bottom: _minimumPadding*4
                        ),
                        // alignment: Alignment.center,
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",style: TextStyle(color: Colors.black,fontSize: 16),),
                                Text("Login",style: TextStyle(color: Color.fromRGBO(239, 121, 57, 1),fontSize: 16),),
                              ],
                            )),
                      ),
                    ),
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