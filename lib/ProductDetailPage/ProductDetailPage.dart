import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class productdetails extends StatefulWidget {
  Data data;
  productdetails({this.data});
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
            padding: EdgeInsets.only(right: _minimumPadding, left: _minimumPadding),
            child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    child: image_carousel,
                  ),
                  Column(
                    children: [
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
                              onPressed: () {

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
                          Text("All Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding:  EdgeInsets.only(left:10.0),
                        child: Text(widget.data.description),
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