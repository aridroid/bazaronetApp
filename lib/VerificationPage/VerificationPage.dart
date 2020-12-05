import 'dart:convert';

import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:pinput/pin_put/pin_put.dart';
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

class VerificationPage extends StatefulWidget {
  Map data;
  VerificationPage({this.data});
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // double _minimumPadding = 5.0;
  // LoginBloc _loginBloc;
  // final _formKey = GlobalKey<FormState>();
  // final otpController = TextEditingController();
  // final FocusNode _pinPutFocusNode = FocusNode();
  //
  // BoxDecoration get _pinPutDecoration {
  //   return BoxDecoration(
  //     border: Border.all(color: Color.fromRGBO(239, 121, 57, 1)),
  //     borderRadius: BorderRadius.circular(15.0),
  //   );
  // }
  //
  // @override
  // void initState() {
  //   _loginBloc = LoginBloc();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Color.fromRGBO(239, 121, 57, 1),
  //       appBar: AppBar(
  //         backgroundColor: Color.fromRGBO(239, 121, 57, 1),
  //         elevation: 0.0,
  //       ),
  //       body: Container(
  //           decoration: new BoxDecoration(
  //               color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
  //               borderRadius: new BorderRadius.only(
  //                   topLeft: const Radius.circular(15.0),
  //                   topRight: const Radius.circular(15.0))
  //           ),
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //           child:  Form(
  //             key: _formKey,
  //             child: ListView(
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.only(
  //                         left: MediaQuery.of(context).size.width*.07,
  //                         right: MediaQuery.of(context).size.width*.07,
  //                     ),
  //                     width: MediaQuery.of(context).size.width,
  //                     padding: EdgeInsets.only(top: 80),
  //                     alignment: Alignment.topLeft,
  //                     child:
  //                     Text("Verification Code",
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 25,
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07,bottom: MediaQuery.of(context).size.height*.05),
  //                     child: Text("Please enter verification code sent to your mobile",style: TextStyle(color: Colors.grey),),
  //                   ),
  //
  //                   Container(
  //                     margin: EdgeInsets.only(
  //                       left: MediaQuery.of(context).size.width*.07,
  //                       right: MediaQuery.of(context).size.width*.07,
  //                     ),
  //                     child: PinPut(
  //                       fieldsCount: 6,
  //                       focusNode: _pinPutFocusNode,
  //                       controller: otpController,
  //                       submittedFieldDecoration: _pinPutDecoration.copyWith(
  //                         borderRadius: BorderRadius.circular(20.0),
  //                       ),
  //                       onChanged: (_) {
  //                         print("OTP:"+otpController.text);
  //                       },
  //                       selectedFieldDecoration: _pinPutDecoration,
  //                       followingFieldDecoration: _pinPutDecoration.copyWith(
  //                         borderRadius: BorderRadius.circular(5.0),
  //                         border: Border.all(
  //                           color: Color.fromRGBO(239, 121, 57, 1)
  //                         ),
  //                       ),
  //                       validator: (value) {
  //                         if(value.length < 6){
  //                           return 'Invalid Otp';
  //                         }
  //                         return null;
  //                       },
  //                     ),
  //                   ),
  //
  //                   Container(
  //                     margin: EdgeInsets.only(top: 120),
  //                     // alignment: Alignment.center,
  //                     child: Center(
  //                       child: ButtonTheme(
  //                         height: 50.0,
  //                         minWidth: MediaQuery.of(context).size.width*.87,
  //                         child: RaisedButton(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(18.0),
  //                           ),
  //                           color: Color.fromRGBO(239, 121, 57, 1),
  //                           onPressed: () {
  //                             if(_formKey.currentState.validate()){
  //                               Map body = new Map();
  //                               body['code']=otpController.text;
  //                               _formKey.currentState.reset();
  //                               _loginBloc.login(body);
  //                             }
  //                           },
  //                           child: StreamBuilder<ApiResponse<LoginModel>>(
  //                             stream: _loginBloc.loginStream,
  //                             builder:(context, snapshot) {
  //                               if(snapshot.hasData)
  //                               {
  //                                 switch(snapshot.data.status)
  //                                 {
  //                                   case Status.LOADING:
  //                                     print("Case 1");
  //                                     print(snapshot);
  //                                     return CircularProgressIndicator(
  //                                       valueColor: new AlwaysStoppedAnimation<Color>(
  //                                         Color.fromRGBO(255, 241, 232, 1),
  //                                       ),
  //                                     );
  //                                     break;
  //                                   case Status.COMPLETED:
  //                                     print("Case 2");
  //                                     saveUserData(snapshot.data.data);
  //                                     navigateScreen(context, snapshot.data.data.name);
  //                                     break;
  //                                   case Status.ERROR:
  //                                     print("Case 3");
  //                                     Fluttertoast.showToast(
  //                                         msg: "Login Failed",
  //                                         toastLength: Toast.LENGTH_SHORT,
  //                                         gravity: ToastGravity.CENTER,
  //                                         timeInSecForIosWeb: 1,
  //                                         backgroundColor: Colors.red,
  //                                         textColor: Colors.white,
  //                                         fontSize: 16.0
  //                                     );
  //                                     return Text("Verify", style: TextStyle(
  //                                         fontSize: 15.0,
  //                                         color: Colors.white
  //                                     ));
  //                                     break;
  //                                 }
  //                               }
  //
  //                               return Text("Verify", style: TextStyle(
  //                                   fontSize: 15.0,
  //                                   color: Colors.white
  //                               ),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //
  //                     },
  //                     child: Container(
  //                       margin: EdgeInsets.only(
  //                         top: 40,
  //                       ),
  //                       // alignment: Alignment.center,
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             "Didn't receive otp code?",
  //                             style: TextStyle(color: Colors.black,fontSize: 16),
  //                           ),
  //                           Text(
  //                             "Resend OTP",
  //                             style: TextStyle(color: Color.fromRGBO(239, 121, 57, 1) ,fontSize: 16),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Container(
  //                       height: MediaQuery.of(context).size.height*.1,
  //                       width: MediaQuery.of(context).size.width*.87,
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             decoration: BoxDecoration(
  //                                 image: DecorationImage(
  //                                   image: AssetImage("images/twitter.png"),
  //                                 )
  //                             ),
  //                           ),
  //                           Spacer(),
  //                           Container(
  //                             decoration: BoxDecoration(
  //                                 image: DecorationImage(
  //                                     image: AssetImage("images/google.png")
  //                                 )
  //                             ),
  //                           ),
  //                           Spacer(),
  //                           Container(
  //                             decoration: BoxDecoration(
  //                                 image: DecorationImage(
  //                                     image: AssetImage("images/facebook.png")
  //                                 )
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   )
  //                 ]
  //             ),
  //           )
  //       )
  //   );
  // }
  // navigateScreen(BuildContext context, String name) async{
  //   Future.delayed(Duration.zero, () async {
  //     Fluttertoast.showToast(
  //         msg: "Welcome "+name,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         backgroundColor: Colors.greenAccent,
  //         textColor: Colors.white,
  //         timeInSecForIosWeb: 1);
  //     // if(widget.data == null) {
  //     //   Navigator.pushReplacement(context, MaterialPageRoute(builder:
  //     //       (context) => HomePage()));
  //     // }
  //     // else {
  //     //   Navigator.pushReplacement(context, MaterialPageRoute(builder:
  //     //       (context) => productdetails(data: widget.data)));
  //     // }
  //   });
  // }
  //
  // saveUserData(LoginModel data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('userId', data.sId);
  //   prefs.setString('userName', data.name);
  //   prefs.setString('email', data.email);
  //   prefs.setString('token', data.token);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: SelectableText(
                jsonEncode(widget.data)
            ),
          ),
        ],
      ),
    );
  }
}
