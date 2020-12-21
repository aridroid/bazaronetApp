import 'package:bazaronet_fresh/SignupPage/SignupPage.dart';
import 'package:bazaronet_fresh/VerificationPage/VerificationPage.dart';
import 'package:flutter/material.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';

class MobileVerificationPage extends StatefulWidget {
  Data data;
  MobileVerificationPage({this.data}){
    print("Mobile Verification Page:"+data.toString());
  }
  @override
  _MobileVerificationPageState createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  final mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  navigateSignUp() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => SignupPage(data: widget.data)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
                children:[
                  Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/bg.png")
                      )
                  ),
                ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.05,top: MediaQuery.of(context).size.height*.73),
                      width: MediaQuery.of(context).size.width*.9,
                      child: Theme(
                        data: new ThemeData(
                          primaryColor:Color.fromRGBO(239, 121, 57, 1),
                          primaryColorDark: Color.fromRGBO(239, 121, 57, 1),
                        ),
                        child: TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Mobile number field can't be NULL";
                            }
                            else if(value.length != 10) {
                              return "Mobile number field must have 10 digits";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.call_rounded,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if(_formKey.currentState.validate()){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => VerificationPage(mobileNumber: mobileController.text, data: widget.data)));
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              ),
                            ),
                            errorStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white
                            ),

                            hintText: 'Mobile Number',
                            filled: true,
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:  BorderSide(
                                color:  Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ],
        ),

      ),
    );
  }
}
