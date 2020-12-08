import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/SignupPage/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';

class NewLoginPage extends StatefulWidget {
  Data data;
  NewLoginPage({this.data}){
    print("New Login Page:"+data.toString());
  }
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  navigateLogin() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => loginpage(data: widget.data)));
    });
  }

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
        body: Stack(
          children:[ Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/bg.png")
              )
            ),
          ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*.05,top: MediaQuery.of(context).size.height*.73),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              height: MediaQuery.of(context).size.height*.08,
              width: MediaQuery.of(context).size.width*.9,
              child: FlatButton(
                onPressed: () {
                  navigateLogin();
                },
                child: Text(
                  "Login",style: TextStyle(
                    color: Color.fromRGBO(239, 121, 57, 1),
                    fontWeight: FontWeight.bold,fontSize: 16
                ),),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.74),
                child: InkWell(
                  onTap: () {
                    navigateSignUp();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New User?",style: TextStyle(color: Colors.white70),),
                      Text("SignUp",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            )
       ]
        ),

      ),
    );
  }
}
