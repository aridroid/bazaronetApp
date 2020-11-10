import 'dart:ffi';

import 'package:bazaronet_fresh/CartPage/CartPage.dart';
import 'package:bazaronet_fresh/HomePage/home.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
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
  bool CheckValue;
  SharedPreferences prefs;

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
    print("In getuserId");
    print("userId "+userId);
  }

  ifHasUserId() async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
    print("In ifHasUserId");
    print("userId "+CheckValue.toString());
    // setWidget(CheckValue);
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove('userId');
  }

  void _onItemTapped(int index){
      setState(() {
        _selectedIndex = index;
      });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'Index 1: My Order',
    ),
    Cart(),
    Text(
        'Index 3: Profile'
    )
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        leading: Container(
          child: IconButton(
              icon: Image.asset('images/menu.png', height: 20.0,),
              onPressed: null),
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
      backgroundColor: Color.fromRGBO(239, 121, 57, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
          label: 'Home',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.card_travel),
          label: 'My Order',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          label: 'Cart',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_outlined),
          label: 'Profile',
          ),
        ],
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
    ),
    );
  }
}