import 'package:bazaronet_fresh/HomePage/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _minimumPadding = 5.0;

  int _selectedIndex = 0;

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
    Text(
      'Index 2: Cart',
    ),
    Text(
      'Index 3: Profile'
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        title: Container(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.2,
                child: IconButton(
                    icon: Image.asset('images/menu.png', height: 20.0,),
                    onPressed: null),
              ),
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