import 'package:bazaronet_fresh/OrderPage/Model/OrderPageModel.dart';
import 'package:bazaronet_fresh/OrderPage/OrderHistoryPage.dart';
import 'package:bazaronet_fresh/OrderPage/Repository/OrderPageRepository.dart';
import 'package:bazaronet_fresh/new_login_page/new_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  SharedPreferences prefs;
  String token="";
  String userId="";
  String userName;
  bool checkValue = false;
  bool loading = true;
  String email;
  String phone;
  OrderPageRepository _orderPageRepository = OrderPageRepository();
  double screenHeight;
  double screenWidth;
  var statusCol;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);

  getuserId() async {
    print("In Async");
    prefs = await SharedPreferences.getInstance();
    checkValue = prefs.containsKey('userId');
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    token = prefs.getString('token');
    userName = prefs.getString('userName');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    // print("Token:"+token);
    // cartModel = _cartRepository.getCartById(userId);
    setLoading();
  }

  setLoading() {
    setState(() {
      loading = false;
      print("setLoading "+loading.toString());
    });
  }

  navigateScreen() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewLoginPage(data: null,)));
    });
  }

  @override
  void initState() {
    super.initState();
    getuserId();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight= MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (loading == true) {
      print("Loading"+loading.toString());
      return Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0))),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
              clipBehavior: Clip.hardEdge,
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(orangeTheme),
                ),
              )
          )
      );
    }
    if (!checkValue) {
      print("Hello"+checkValue.toString());
      navigateScreen();
      return Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0)
              )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
              ),
              clipBehavior: Clip.hardEdge,
              color: Colors.white70,
              margin: EdgeInsets.zero,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(orangeTheme),
                ),
              )
          )
      );
    }
    else {
      return Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0)
              )
          ),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.hardEdge,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
              ),
              child:
              FutureBuilder<OrderPageModel>(
                  future: _orderPageRepository.getOrders(userId, token),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print("No Data");
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(239, 121, 57, 1)),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      print("Yes Data");
                      return ListView(
                        physics: ScrollPhysics(),
                        children: [
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index){
                                statusCol=Colors.red;
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => OrderHistoryPage(
                                          orderedData: snapshot.data.data[index]
                                        ))
                                    );
                                  },
                                  child: Container(
                                    height: screenHeight*0.17,
                                    width: screenWidth,
                                    margin: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                color: Colors.white,
                                                child:Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black),
                                                      // color: lightThemeBlue,
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(10)),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "images/placeholder.png"),
                                                          fit: BoxFit.fill)),
                                                )
                                            )
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 8,
                                                    child: Container(
                                                        padding: EdgeInsets.fromLTRB(0.0,5.0,5.0,5.0),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("ORDER ID :"+snapshot.data.data[index].sId,
                                                                style: TextStyle(
                                                                  // color: lightThemeBlue,
                                                                    fontSize: 12.0,
                                                                    fontWeight: FontWeight.w600
                                                                ),
                                                              ),
                                                              Text("Order Values :"+snapshot.data.data[index].payment,
                                                                style: TextStyle(
                                                                  // color: lightThemeBlue,
                                                                    fontSize: 12.0,
                                                                    fontWeight: FontWeight.w600
                                                                ),
                                                              ),
                                                              Text("Order Date : "+DateFormat("dd-MM-yyyy").format(DateTime.parse(snapshot.data.data[index].dateAdded)),
                                                                style: TextStyle(
                                                                  //   color: lightThemeBlue,
                                                                    fontSize: 12.0,
                                                                    fontWeight: FontWeight.w600
                                                                ),),
                                                              Row(
                                                                children: [
                                                                  Text("Status : ",
                                                                    style: TextStyle(
                                                                      // color: lightThemeBlue,
                                                                        fontSize: 12.0,
                                                                        fontWeight: FontWeight.w600
                                                                    ),),
                                                                  Text(snapshot.data.data[index].status,
                                                                    style: TextStyle(
                                                                        color: statusCol,
                                                                        fontSize: 12.0,
                                                                        fontWeight: FontWeight.w600
                                                                    ),),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },

                            )
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })
          )
      );
    }
  }
}