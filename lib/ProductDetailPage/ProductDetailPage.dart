import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';


class productdetails extends StatefulWidget {
  Data data;
  productdetails({this.data});
  @override
  _productdetailsState createState() => _productdetailsState();
}
class _productdetailsState extends State<productdetails> {
  double _minimumPadding = 5.0;
  bool isOpen = true;
  String userId;
  bool CheckValue;
  SharedPreferences prefs;
  List<String> size=["XS","S","M","L","XL","XXL"];
  List<String> quantity=["10P","20P","30P","40P","50P","60P"];


  @override
  void initState() {
    getuserId();
    print("Hello 2");
    ifHasUserId();
  }

  getuserId() async {
    prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userId');
    userId = stringValue;
  }

  ifHasUserId() async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
  }

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      padding: EdgeInsets.only(top: _minimumPadding*2),
      height: 150.0,
      child: Carousel(
        boxFit: BoxFit.fitHeight,
        images: widget.data.image.map((image) {
          return Image.network('http://139.59.91.150:3333/uploads/'+image);
        }).toList(),
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),

    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(239, 121, 57, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(239, 121, 57, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart,color: Colors.white,),
            )
          ],
          elevation: 0.0,
        ),
        body: Container(
            decoration: new BoxDecoration(
                color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                children: [
                  Expanded(child:
                  Container(
                    padding: EdgeInsets.only(left: _minimumPadding, right: _minimumPadding),
                    child:
                      ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: image_carousel,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: _minimumPadding, left: _minimumPadding),
                                  child: Text(
                                    widget.data.name,style:
                                  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),
                                )
                            ),
                            IconButton(
                              alignment: Alignment.topRight,
                              icon: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: _minimumPadding),
                            child: Icon(Icons.star,color: Colors.yellow[800],),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                                right: _minimumPadding
                            ),
                            child: Text("4.2",style: TextStyle(color: Colors.yellow[800]),),
                          ),
                          Text("125 reviews",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10),
                            child: Text("Rs. "+widget.data.actualPrice.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:10.0,right: 10.0),
                            child: Text(widget.data.price.toString(),style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough
                            ),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: _minimumPadding*2, bottom: _minimumPadding*2),
                            child: Text("Select size",style: TextStyle(color: Colors.grey),),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 30,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: size.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return  Row(
                                children: [
                                  Container(
                                    margin:EdgeInsets.only(left:2.5,right: 2.5),
                                    height: MediaQuery.of(context).size.height*.1,
                                    width: MediaQuery.of(context).size.width*.2,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(40.0),
                                          topRight: const Radius.circular(40.0),
                                          bottomLeft:  const Radius.circular(40.0),
                                          bottomRight:  const Radius.circular(40.0),
                                        )
                                    ),
                                    child: FlatButton(
                                      color: Colors.white,
                                      child: Text("${size[index]}"),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: _minimumPadding*2, bottom: _minimumPadding*2),
                            child: Text("Select Quantity",style: TextStyle(color: Colors.grey),),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        height: 30,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: quantity.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return  Row(
                                children: [
                                  Container(
                                    margin:EdgeInsets.only(left:2.5,right: 2.5),
                                    height: MediaQuery.of(context).size.height*.1,
                                    width: MediaQuery.of(context).size.width*.2,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(40.0),
                                          topRight: const Radius.circular(40.0),
                                          bottomLeft:  const Radius.circular(40.0),
                                          bottomRight:  const Radius.circular(40.0),
                                        )
                                    ),
                                    child: FlatButton(
                                      color: Colors.white,
                                      child: Text("${quantity[index]}"),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0),
                            child: Text("Check Delivery Availability"),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_on,color: Colors.lightGreenAccent,),
                          ),
                          Text("Elgin Road,700063",style: TextStyle(color: Colors.black,fontSize: 15),),
                          Spacer(),
                          ButtonTheme(
                            height: 30.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text("Change",),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    builder: (builder) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        decoration: BoxDecoration(
                                              borderRadius: new BorderRadius.only(
                                                  topLeft: const Radius.circular(25.0),
                                                  topRight: const Radius.circular(25.0))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 30.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  child:
                                                    Text(
                                                      "Use Pincode To Check Delivery Info",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                              )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin:
                                                    EdgeInsets.only(left: 15),
                                                    height: 45,
                                                    width: 250,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                        hintText: 'Enter Pincode',
                                                        border:
                                                        new OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  height: 45,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow[700],
                                                      borderRadius:
                                                      new BorderRadius.only(
                                                        bottomRight:
                                                        Radius.circular(10),
                                                        bottomLeft:
                                                        Radius.circular(10),
                                                        topLeft:
                                                        Radius.circular(10),
                                                        topRight:
                                                        Radius.circular(10),
                                                      )),
                                                  child: FlatButton(
                                                    child: Text(
                                                      "Check",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                "or",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width*0.25,
                                                  bottom: _minimumPadding*2
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.gps_fixed,
                                                    color: Colors.blue,
                                                  ),
                                                  Text(
                                                    "Use my current location",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text("Delivery Available In Your Area",style: TextStyle(color: Colors.lightGreen),),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0,right: 10.0),
                            child: Icon(Icons.airport_shuttle,color: Colors.yellow[700],),
                          ),
                          Text("Eligible For Fast Delivery In 1 Day",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0),
                            child: Text("Product Details"),
                          ),
                          Spacer(),
                          RaisedButton(
                              onPressed: () {
                                setState(() {
                                  isOpen = !isOpen;
                                });
                              },
                            elevation: 0.0,
                            color: Colors.white,
                            child: Text(isOpen ? "Collapse" : "All Details",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isOpen,
                          child: Padding(
                            padding:  EdgeInsets.only(left:_minimumPadding*2, top: _minimumPadding*2),
                            child: Html(
                              data: widget.data.description,
                              padding: EdgeInsets.all(8.0),
                              customRender: (node, children) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "custom_tag": // using this, you can handle custom tags in your HTML
                                      return Column(children: children);
                                  }
                                }
                              },
                            ),
                          ),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0,right: 10.0),
                            child: Icon(Icons.star,color: Colors.yellow[700],),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:10.0),
                            child: Text("4.2",style: TextStyle(color: Colors.yellow[700]),),
                          ),
                          Text("80 Ratings And 125 Reviews",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                        ],
                      ),
                      Divider(color: Colors.grey,),
                    ],
                  ),
                  ),),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: _minimumPadding*2),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(239, 121, 57, 1),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        if(CheckValue){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePage.second(selectedIndex: 2,))
                          );
                        }
                        else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => loginpage(data: widget.data,))
                          );
                        }
                      },
                      child: Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize:18),),
                    ),
                  ),
                ]
            )
        )
    );
  }
}