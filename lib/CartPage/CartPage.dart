import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<Cart> {
  double _minimumPadding = 5.0;
  String userId;
  bool CheckValue;
  SharedPreferences prefs;
  bool loading = true;
  CartRepository _cartRepository;
  double cost = 0;

  @override
  void initState() {
    getuserId();
    _cartRepository = CartRepository();
  }

  addAmount(double amount) {
      setState(() {
        cost= cost + amount;
      });
  }

  getuserId() async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    setLoading();
  }

  setLoading() {
    setState(() {
      loading = false;
      print("setLoading "+loading.toString());
    });
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return CircularProgressIndicator(
        valueColor:
            new AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 255, 255, 1)),
      );
    }
    if (!CheckValue) {
      navigateScreen();
      return Container(
          decoration: new BoxDecoration(
              color: Color.fromRGBO(255, 241, 232, 1),
              //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0))),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Color.fromRGBO(255, 241, 232, 1),
          ));
    } else {
      return Container(
        decoration: new BoxDecoration(
            color: Color.fromRGBO(255, 241, 232, 1),
            //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0))),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Color.fromRGBO(255, 241, 232, 1),
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder<CartPageModel>(
                      future: _cartRepository.getCartById(userId),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          print("Loading");
                          return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(255, 241, 232, 1),
                                ),
                              )
                          );
                        }
                        else{
                          print("In Success "+snapshot.data.data.length.toString());
                          print("Loaded");
                          return ListView.builder(
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 100.0,
                                    margin: EdgeInsets.only(
                                        bottom: _minimumPadding,
                                        left: _minimumPadding,
                                        right: _minimumPadding),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        color: Colors.white),
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            15.0),
                                      ),
                                      elevation: 2.0,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(
                                                _minimumPadding),
                                            width:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(
                                                        15.0),
                                                    bottomLeft: Radius
                                                        .circular(
                                                        15.0)),
                                                image:
                                                DecorationImage(
                                                  image: NetworkImage(
                                                      'http://139.59.91.150:3333/uploads/'+
                                                          snapshot.data.data[index].product.image[0]),
                                                  fit: BoxFit.fill,

                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: _minimumPadding *
                                                    2,
                                                bottom: _minimumPadding*2,
                                                left: _minimumPadding),
                                            child: Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    snapshot.data.data[index].product.name.length > 19 ?
                                                    '${snapshot.data.data[index].product.name.substring(0,19)}...': snapshot.data.data[index].product.name,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0
                                                    ),),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Color.fromRGBO(239, 121, 57, 1),
                                                        size: 15.0,
                                                      ),
                                                      Text(
                                                        "  4.2",
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(239, 121, 57, 1),
                                                            fontSize: 12.0,
                                                            fontStyle: FontStyle.italic),
                                                      ),
                                                      Text(
                                                        " 125 Reviews",
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontStyle: FontStyle.italic
                                                        ),)
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Text("Rs."+snapshot.data.data[index].product.actualPrice.toString()+" ",
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(239, 121, 57, 1),
                                                            fontSize: 15.0,
                                                            fontWeight: FontWeight.bold),),
                                                      Text(" Rs."+snapshot.data.data[index].product.price.toString(), style: TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12.0
                                                      ),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Text("Delivery within 2 hours",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12.0
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                    alignment: Alignment.topRight,
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                    ),
                                                    onPressed: () {}),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                  )
                ),
                Divider(),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rs.10.00",
                              style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            Text(
                              "View Price Details",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * .50,
                        decoration: BoxDecoration(
                          color: Colors.yellow[800],
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                            bottomLeft: const Radius.circular(40.0),
                            bottomRight: const Radius.circular(40.0),
                          ),
                        ),
                        child: FlatButton(
                          child: Text(
                            "CheckOut",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  navigateScreen() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => loginpage(data: null)));
    });
  }
}
