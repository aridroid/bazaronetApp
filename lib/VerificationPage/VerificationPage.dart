import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bazaronet_fresh/LoginPage/LoginBloc.dart';
import 'package:bazaronet_fresh/LoginPage/LoginModel/LoginModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';

class VerificationPage extends StatefulWidget {
  Data data;
  String mobileNumber;
  VerificationPage({this.data,this.mobileNumber});
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  int recivedOtp;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color.fromRGBO(239, 121, 57, 1)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  // verifyPhoneNumber() async {
  //   print("Start");
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '+91'+widget.mobileNumber,
  //     timeout: Duration(seconds: 120),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // ANDROID ONLY!
  //       // Sign the user in (or link) with the auto-generated credential
  //       await auth.signInWithCredential(credential);
  //       if(auth.currentUser!=null){
  //         print("auto verify");
  //       }
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //
  //       // Handle other errors
  //     },
  //     codeSent: (String verificationId, int resendToken) async {
  //       print("code sent");
  //       // Update the UI - wait for the user to enter the SMS code
  //       String smsCode = 'xxx';
  //
  //       // Create a PhoneAuthCredential with the code
  //       PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //
  //       // Sign the user in (or link) with the credential
  //       await auth.signInWithCredential(phoneAuthCredential);
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // Auto-resolution timed out...
  //     },
  //   );
  //   print("End");
  // }

  @override
  void initState() {
    // verifyPhoneNumber();

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
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.07,
                          right: MediaQuery.of(context).size.width*.07,
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 80),
                      alignment: Alignment.topLeft,
                      child:
                      Text("Verification Code",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07,bottom: MediaQuery.of(context).size.height*.05),
                      child: Text("Please enter verification code sent to your mobile",style: TextStyle(color: Colors.grey),),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.07,
                        right: MediaQuery.of(context).size.width*.07,
                      ),
                      child: PinPut(
                        fieldsCount: 6,
                        focusNode: _pinPutFocusNode,
                        controller: otpController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onChanged: (_) {
                          print("OTP:"+otpController.text);
                        },
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Color.fromRGBO(239, 121, 57, 1)
                          ),
                        ),
                        validator: (value) {
                          if(value.length < 6){
                            return 'Invalid Otp';
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 120),
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
                                _formKey.currentState.reset();
                              }
                            },
                            child: Text("Verify", style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 40,
                        ),
                        // alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive otp code?",
                              style: TextStyle(color: Colors.black,fontSize: 16),
                            ),
                            Text(
                              "Resend OTP",
                              style: TextStyle(color: Color.fromRGBO(239, 121, 57, 1) ,fontSize: 16),
                            ),
                          ],
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
      // if(widget.data == null) {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder:
      //       (context) => HomePage()));
      // }
      // else {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder:
      //       (context) => productdetails(data: widget.data)));
      // }
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
