import 'package:bazaronet_fresh/AddressPage/AddressPage.dart';
import 'package:bazaronet_fresh/CartPage/CartBloc.dart';
import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<Cart> {
  double _minimumPadding = 5.0;
  String userId;
  bool CheckValue;
  bool checkOutButtonState = false;
  SharedPreferences prefs;
  bool loading = true;
  CartRepository _cartRepository;
  double cost = 0;
  List<int> _quantityController = new List();
  Future<CartPageModel> cartModel;
  CartBloc _cartBloc;

  @override
  void initState() {
    getuserId();
    _cartRepository = CartRepository();
    _cartBloc = CartBloc();
  }

  addAmount(CartPageModel data, int index) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        cost= cost + data.data[index].product.actualPrice*data.data[index].quantity;
        print("Cost: "+cost.toString());
        checkOutButtonState = true;
      });
    });
  }


  getuserId() async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    // cartModel = _cartRepository.getCartById(userId);
    setLoading();
  }

  setLoading() {
    setState(() {
      loading = false;
      print("setLoading "+loading.toString());
    });
  }

  updateCart(String operation, int index) {
      if (operation == "minus") {
        setState(() {
          _quantityController[index]--;
        });
      }
      else if (operation == "plus") {
        setState(() {
          _quantityController[index]++;
        });
      }
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }

  returnFutureList() {
    return Expanded(
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
                print("Loaded");
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      // addAmount(snapshot.data.data[index].product.actualPrice.roundToDouble());
                      if(cost==0)
                      {
                          addAmount(snapshot.data,index);
                      }
                      _quantityController.add(snapshot.data.data[index].quantity);
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          height: 120.0,
                          margin: EdgeInsets.only(
                              bottom: _minimumPadding,
                              left: _minimumPadding,
                              right: _minimumPadding),
                          padding: EdgeInsets.only(
                          ),
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
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: _minimumPadding *
                                            2,
                                        bottom: _minimumPadding*2,
                                        left: _minimumPadding,
                                        right: _minimumPadding
                                    ),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data.data[index].product.name.length > 19 ?
                                                '${snapshot.data.data[index].product.name.substring(0,19)}...': snapshot.data.data[index].product.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0
                                                ),
                                              ),
                                              // Spacer(),
                                              // InkWell(
                                              //   onTap: () {
                                              //
                                              //   },
                                              //   child:
                                              //   Icon(
                                              //     Icons.delete,
                                              //     color: Colors.grey,
                                              //   ),
                                              // ),
                                            ],
                                          ),
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
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  if(snapshot.data.data[index].quantity == 1){
                                                    alert();
                                                  }
                                                  else{
                                                    Map body = new Map();
                                                    body['customer_id'] = userId;
                                                    body['product'] = snapshot.data.data[index].product.sId;
                                                    body['quantity'] = (snapshot.data.data[index].quantity -1).toString();
                                                    _cartBloc.updateCartById(body, snapshot.data.data[index].sId);
                                                    updateCart("minus", index);
                                                  }
                                                },
                                                child:
                                                Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                child: StreamBuilder<ApiResponse<UpdateCartModel>>(
                                                  stream: _cartBloc.cartPageStream,
                                                  builder:(context, snapshot2) {
                                                    if(snapshot2.hasData)
                                                    {
                                                      switch(snapshot2.data.status)
                                                      {
                                                        case Status.LOADING:
                                                          print("Case 1");
                                                          print(snapshot2);
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                              valueColor: new AlwaysStoppedAnimation<Color>(
                                                                Color.fromRGBO(255, 241, 232, 1),
                                                              ),
                                                            ),
                                                          );
                                                          break;
                                                        case Status.COMPLETED:
                                                          reload();
                                                          // return Text(
                                                          //   snapshot2.data.data.data.quantity.toString(),
                                                          //   style: TextStyle(
                                                          //       color: Colors.black
                                                          //   ),
                                                          // );
                                                          // cartModel = _cartRepository.getCartById(userId);
                                                          // setState(() {
                                                          //   cost =0;
                                                          // });
                                                          return Text(
                                                            _quantityController[index].toString(),
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          );
                                                          break;
                                                        case Status.ERROR:
                                                          print("Case 3");
                                                          print(snapshot2);
                                                          Fluttertoast.showToast(
                                                              msg: "Failed",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.CENTER,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                          return Text(
                                                            _quantityController[index].toString(),
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          );
                                                          break;
                                                      }
                                                    }

                                                    return Text(
                                                      snapshot.data.data[index].quantity.toString(),
                                                      style: TextStyle(
                                                          color: Colors.black
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Map body = new Map();
                                                  body['customer_id'] = userId;
                                                  body['product'] = snapshot.data.data[index].product.sId;
                                                  body['quantity'] = (snapshot.data.data[index].quantity +1).toString();
                                                  _cartBloc.updateCartById(body, snapshot.data.data[index].sId);
                                                  updateCart("plus", index);
                                                },
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
    );
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
                returnFutureList(),
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
                              "Rs."+cost.toString(),
                              style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
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
                          onPressed: checkOutButtonState ? navigateToAddressPage : null,
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

  reload() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => HomePage.second(selectedIndex: 2,)
          )
      );
    });
  }

  alert(){
    Fluttertoast.showToast(
        msg: "Can't have less than 1 item",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  navigateScreen() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => loginpage(data: null)));
    });
  }

  navigateToAddressPage() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddressPage()));
    });
  }
}
