import 'package:bazaronet_fresh/OrderPage/Model/OrderPageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderHistoryPage extends StatefulWidget {
  Data orderedData;
  OrderHistoryPage({this.orderedData});
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  double screenHeight;
  double screenWidth;
  int discount = 0;

  calculateDiscount(Variant data) {
    double discount2 = (1 - data.price/data.actualPrice)*100;
    discount = discount2.round();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight= MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: orangeTheme,
          title: Text('Order History', style: TextStyle(
            color: Colors.white, fontSize: 20
          ),),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null)
          ],
          elevation: 0.0,
        ),
        backgroundColor: orangeTheme,
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)),
                color: Colors.white),
            child: Card(
                clipBehavior: Clip.hardEdge,
                color: Colors.white70,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                ),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 5.0,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('#'+widget.orderedData.sId, style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold, letterSpacing: 1.2
                                  ),),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.airport_shuttle,
                                  size: 20.0,
                                  color: Colors.green[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 10),
                                  child: Text('Track', style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.green[400],
                                  ),),
                                ),
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.orderedData.products.length,
                              itemBuilder: (context, index){
                                calculateDiscount(widget.orderedData.products[index].product.variant);
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      height: 120,
                                      width: screenWidth,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          'http://139.59.91.150:3333/uploads/'+
                                                          widget.orderedData.products[index].product.image[0]
                                                        ),
                                                        fit: BoxFit.fill
                                                    )
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 15, top: 5, bottom: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    widget.orderedData.products[index].product.name.length > 19 ?
                                                    '${widget.orderedData.products[index].product.name.substring(0,19)}...':
                                                    widget.orderedData.products[index].product.name,
                                                    style: TextStyle(
                                                        fontSize: 15.0
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Text("Rs."+widget.orderedData.products[index].product.variant.price.toString()+" ",
                                                        style: TextStyle(
                                                          fontSize: 15.0,),
                                                      ),
                                                      Text("Rs."+widget.orderedData.products[index].product.variant.actualPrice.toString(), style: TextStyle(
                                                          decoration: TextDecoration.lineThrough,
                                                          color: Colors.grey,
                                                          fontSize: 15.0),
                                                      ),
                                                      Text(" "+discount.toString()+"% OFF", style: TextStyle(
                                                          color: Color.fromRGBO(255, 165, 0, 1),
                                                          fontSize: 15.0),
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Text("Quantity "+widget.orderedData.products[index].quantity.toString(),
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text("Delivery expected by Sep 16th",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0
                                                    ),
                                                  ),
                                                  widget.orderedData.products[index].product.vendorId == null ?
                                                  Container() : Spacer(),
                                                  widget.orderedData.products[index].product.vendorId == null ?
                                                  Container() :
                                                  Row(
                                                    children: [
                                                      Text("Sold By ",
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.blue[800],
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text(widget.orderedData.products[index].product.vendorId.name.length > 19 ?
                                                      '${widget.orderedData.products[index].product.vendorId.name.substring(0,19)}...': widget.orderedData.products[index].product.vendorId.name,
                                                        style: TextStyle(
                                                            fontSize: 15.0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                    )
                                  ],
                                );
                              },

                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Text('Cancel Order', style: TextStyle(
                                  fontSize: 17,
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
