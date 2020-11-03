import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<Cart> {
  double _minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Color.fromRGBO(255, 241, 232, 1), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0))
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Card(
          clipBehavior: Clip.hardEdge,
          color: Color.fromRGBO(255, 241, 232, 1),
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {

                            },
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
                                      margin: EdgeInsets.only(
                                          right:
                                          _minimumPadding),
                                      width:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.2,
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
                                            image: AssetImage(
                                                'images/diapers.jpg'),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: _minimumPadding *
                                              2),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                                "Pampers Diapers - S 76 Pieces"),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors
                                                      .amber,
                                                ),
                                                Text(
                                                  "  4.2",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .amber),
                                                ),
                                                Text(
                                                    " 125 Reviews")
                                              ],
                                            ),
                                            Text("₹  10.00"),
                                            Row(
                                              children: [
                                                Icon(Icons
                                                    .directions_car_sharp),
                                                Text(
                                                    "  Delivery within 2 hours")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .delete_outline,
                                                  ),
                                                  onPressed: () {}),
                                            ),
                                            Spacer(),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
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
                              style: TextStyle(color: Colors.blue, fontSize: 15),
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
