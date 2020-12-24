import 'dart:ffi';

import 'package:bazaronet_fresh/CartPage/CartPage.dart';
import 'package:bazaronet_fresh/HomePage/home.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/OrderPage/OrderPage.dart';
import 'package:bazaronet_fresh/ProfilePage/ProfilePage.dart';
import 'package:bazaronet_fresh/new_login_page/new_login_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  int selectedIndex;
  HomePage(){
    selectedIndex = 0;
  }
  HomePage.second({this.selectedIndex});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _minimumPadding = 5.0;
  int _selectedIndex;
  String userId;
  String userName;
  bool checkValue;
  SharedPreferences prefs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    // removeValue();
    getuserId();
    ifHasUserId();
    print("In Init");
  }

  getuserId() async {
    prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    userName = prefs.getString("userName");
    print("In getuserId");
    setState(() {

    });
  }

  ifHasUserId() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      checkValue = prefs.containsKey('userId');
    });
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Future.delayed(Duration.zero, () async {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage.second(selectedIndex: _selectedIndex)), (Route<dynamic> route) => false);
    });
  }
  navigateScreen() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewLoginPage(data: null)));
    });
  }

  void _onItemTapped(int index){
      setState(() {
        _selectedIndex = index;
      });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    OrderDetailsPage(),
    Cart(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        leading: Container(
          child: IconButton(
              icon: Image.asset('images/menu.png', height: 20.0,),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),),
        ),
        title: Container(
          padding: EdgeInsets.only(left: _minimumPadding*2),
          child: Row(
            children: [
              Image.asset('images/logo.png', width: 150.0)
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.white,),
              onPressed: null)
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              color: orangeTheme,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/user.jpg'),
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text('Welcome', style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                        ),
                        Text(userName == null ? 'User' : userName, style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: orangeTheme,),
              title: Text('Home', style: TextStyle(
                fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.card_travel, color: orangeTheme,),
              title: Text('Order', style: TextStyle(
                  fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart, color: orangeTheme,),
              title: Text('Cart', style: TextStyle(
                  fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle_outlined, color: orangeTheme,),
              title: Text('Profile', style: TextStyle(
                  fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            checkValue == null ? Container() : checkValue == true ?
            ListTile(
              leading: Icon(Icons.logout, color: orangeTheme,),
              title: Text('Logout', style: TextStyle(
                  fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                removeValue();
                Navigator.pop(context);
              },
            ) :
            ListTile(
              leading: Icon(Icons.login, color: orangeTheme,),
              title: Text('Login or SignUp', style: TextStyle(
                  fontSize: 15
              ),),
              onTap: () {
                // ignore: unnecessary_statements
                navigateScreen();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(239, 121, 57, 1),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.card_travel, size: 30),
          Icon(Icons.add_shopping_cart, size: 30),
          Icon(Icons.supervised_user_circle_outlined, size: 30),
        ],
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        color: Color.fromRGBO(239, 121, 57, 1),
      ),
    );
  }
}