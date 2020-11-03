import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class productdetails extends StatefulWidget {
  @override
  _productdetailsState createState() => _productdetailsState();
}
class _productdetailsState extends State<productdetails> {
  double _minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 150.0,
      child: Carousel(
        boxFit: BoxFit.fitHeight,
        images: [
          AssetImage("images/diapers.jpg"),
          AssetImage("images/diapers.jpg"),
          AssetImage("images/diapers.jpg"),
          AssetImage("images/diapers.jpg"),
        ],
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
            padding: EdgeInsets.only(right: _minimumPadding, left: _minimumPadding),
            child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10.0,),
                  Container(
                    child: image_carousel,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Pampers Diapers - 76 Pieces",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.star,color: Colors.yellow[800],),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: 5.0),
                            child: Text("4.2",style: TextStyle(color: Colors.yellow[800]),),
                          ),
                          Text("125 reviews",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10),
                            child: Text("Rs.10.00",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:10.0,right: 10.0),
                            child: Text("20.00",style: TextStyle(color: Colors.grey),),
                          ),
                          Text("50% OFF",style: TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0),
                            child: Text("Select size",style: TextStyle(color: Colors.grey),),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("XS"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("S"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("M"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("L"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("XL"),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:10.0),
                            child: Text("Select Quantity",style: TextStyle(color: Colors.grey),),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("10P"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("20P"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("30P"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("40P"),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 60,
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
                              child: Text("50P"),
                            ),
                          )
                        ],
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
                          Container(
                            height: 30,
                            width: 90,
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
                              child: Text("Change"),
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
                          Text("All Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding:  EdgeInsets.only(left:10.0),
                        child: Text('Lorem ipsum, or lipsum as it is sometimes known, is dummytext'
                            ' used in laying out print, graphic or web designs.'
                            ' Thepassage is attributed to an unknown typesetter in the 15thcentury'
                            ' who is thought to have scrambled parts of Cicero'
                            '''
 De Finibus Bonorum et Malorum for use in a type specimen book''' '''
)'''),
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
                      SizedBox(height: 7.0,),
                      Container(
                        height: MediaQuery.of(context).size.height*.07,
                        width: MediaQuery.of(context).size.width*.95,
                        decoration: BoxDecoration(
                            color: Colors.yellow[800],
                            borderRadius: new BorderRadius.only(
                              topLeft:  Radius.circular(20.0),
                              topRight:  Radius.circular(20.0),
                              bottomLeft:   Radius.circular(20.0),
                              bottomRight:   Radius.circular(20.0),
                            )
                        ),
                        child: FlatButton(
                          child: Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize:18),),
                        ),
                      ),
                    ],
                  )
                ]
            )
        )
    );
  }
}