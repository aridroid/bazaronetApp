import 'dart:convert';
import 'dart:developer';

import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/ProductDetailPage/Model/AddToCartModel.dart';
import 'package:bazaronet_fresh/ProductDetailPage/Model/SendToCartModel.dart'
    as sendProduct;
import 'package:bazaronet_fresh/ProductDetailPage/ProductDetailBloc.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart'
    as productData;
import 'package:bazaronet_fresh/VerificationPage/VerificationPage.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:bazaronet_fresh/new_login_page/new_login_page.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class productdetails extends StatefulWidget {
  productData.Data data;
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
  ProductDetailBloc _productDetailBloc;
  int discount = 0;
  int selectedVariant = 0;
  List<productData.Variant> variantList;
  Map product = new Map();
  @override
  void initState() {
    calculateDiscount();
    ifHasUserId();
    _productDetailBloc = ProductDetailBloc();
    variantList = widget.data.variant.map((variant) {
      return variant;
    }).toList();
  }

  callBloc() {
    _productDetailBloc.addToCart(product);
  }

  sendToCartProduct() {
    // createProperties();
    product["customer_id"] = userId;
    product['quantity'] = 1.toString();
    product["product"] = new sendProduct.Product(
        tax: widget.data.tax,
        image: widget.data.image,
        shipping: widget.data.shipping,
        minAmountForFreeShipping: widget.data.minAmountForFreeShipping,
        status: widget.data.status,
        delivery: widget.data.delivery,
        sId: widget.data.sId,
        name: widget.data.name,
        model: widget.data.model,
        category: new sendProduct.Category(
            sId: widget.data.category.sId,
            image: widget.data.category.image,
            dateAdded: widget.data.category.dateAdded,
            dateModified: widget.data.category.dateModified,
            description: widget.data.category.description,
            iV: widget.data.category.iV,
            name: widget.data.category.name,
            sortOrder: widget.data.category.sortOrder,
            status: widget.data.category.status),
        subcategory: widget.data.subcategory,
        manufacturer: widget.data.manufacturer,
        unit: 1,
        quantity: widget.data.quantity,
        quantityClass: "",
        description: widget.data.description,
        variant: new sendProduct.Variant(
            sId: widget.data.variant[selectedVariant].sId,
            actualPrice: widget.data.variant[selectedVariant].actualPrice,
            price: widget.data.variant[selectedVariant].price,
            stock: widget.data.variant[selectedVariant].stock,
            variantProperties:
                widget.data.variant[selectedVariant].variantProperties),
        dateAdded: widget.data.dateAdded,
        dateModified: widget.data.dateModified,
        iV: widget.data.iV,
        selectedVariant: new sendProduct.Variant(
            sId: widget.data.variant[selectedVariant].sId,
            actualPrice: widget.data.variant[selectedVariant].actualPrice,
            price: widget.data.variant[selectedVariant].price,
            stock: widget.data.variant[selectedVariant].stock,
            variantProperties:
                widget.data.variant[selectedVariant].variantProperties));

    // product["product"] = {
    //   "tax": widget.data.tax,
    //   "image": widget.data.image,
    //   "shipping": widget.data.shipping,
    //   "minAmountForFreeShipping": widget.data.minAmountForFreeShipping,
    //   "status": widget.data.status,
    //   "delivery": widget.data.delivery,
    //   "sId": widget.data.sId,
    //   "name": widget.data.name,
    //   "model": widget.data.model,
    //   "category": {
    //     "sId": widget.data.category.sId,
    //     "image": widget.data.category.image,
    //     "dateAdded": widget.data.category.dateAdded,
    //     "dateModified": widget.data.category.dateModified,
    //     "description": widget.data.category.description,
    //     "iV": widget.data.category.iV,
    //     "name": widget.data.category.name,
    //     "sortOrder": widget.data.category.sortOrder,
    //     "status": widget.data.category.status
    //   },
    //   "subcategory": widget.data.subcategory,
    //   "manufacturer": widget.data.manufacturer,
    //   "unit": 1,
    //   "quantity": widget.data.quantity,
    //   "quantityClass": "",
    //   "description": widget.data.description,
    //   "variant": {
    //     "sId": widget.data.variant[selectedVariant].sId,
    //     "actualPrice": widget.data.variant[selectedVariant].actualPrice,
    //     "price": widget.data.variant[selectedVariant].price,
    //     "stock": widget.data.variant[selectedVariant].stock,
    //     "variantProperties":
    //         widget.data.variant[selectedVariant].variantProperties
    //   },
    //   "dateAdded": widget.data.dateAdded,
    //   "dateModified": widget.data.dateModified,
    //   "iV": widget.data.iV,
    //   "selectedVariant": {
    //     "sId": widget.data.variant[selectedVariant].sId,
    //     "actualPrice": widget.data.variant[selectedVariant].actualPrice,
    //     "price": widget.data.variant[selectedVariant].price,
    //     "stock": widget.data.variant[selectedVariant].stock,
    //     "variantProperties":
    //         widget.data.variant[selectedVariant].variantProperties
    //   }
    // };

    log("Product2:"+jsonEncode(product));
  }

  calculateDiscount() {
    double discount2 = (1 -
            widget.data.variant[selectedVariant].price /
                widget.data.variant[selectedVariant].actualPrice) *
        100;
    discount = discount2.toInt();
  }

  getuserId() async {
    prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    sendToCartProduct();
  }

  ifHasUserId() async {
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
    getuserId();
  }

  getVariants() {
    int property = widget.data.variant[0].variantProperties.length;
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: property,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _minimumPadding * 2,
                    bottom: _minimumPadding,
                    top: _minimumPadding),
                child: Text(
                  "Select " +
                      widget
                          .data.variant[0].variantProperties[index].variantType,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 30,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.data.variant.length,
                    itemBuilder: (BuildContext ctxt, int index2) {
                      return Container(
                        // padding:EdgeInsets.only(left:5,right: 5),
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                              bottomLeft: const Radius.circular(40.0),
                              bottomRight: const Radius.circular(40.0),
                            )),
                        child: FlatButton(
                          color: Colors.white,
                          child: Text(widget.data.variant[index2]
                              .variantProperties[index].variantValue),
                        ),
                      );
                    }),
              ),
            ],
          );
        });
  }

  getDropDown() {
    return Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), border: Border.all()),
        child: DropdownButtonHideUnderline(
          child: new DropdownButton(
            // icon: Icon(Icons.arrow_drop_down),
            value: selectedVariant.toString(),
            items: variantList.map((variant) {
              int property = variant.variantProperties.length;
              String value = '';
              for (int i = 0; i < property; i++) {
                if (i == property - 1) {
                  value = value + variant.variantProperties[i].variantValue;
                } else {
                  value =
                      value + variant.variantProperties[i].variantValue + ',';
                }
              }
              return new DropdownMenuItem<String>(
                value: variantList.indexOf(variant).toString(),
                child: Center(child: new Text(value)),
              );
            }).toList(),
            onChanged: (String value) {
              selectedVariant = int.parse(value);
              sendToCartProduct();
              calculateDiscount();
              setState(() {});
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      padding: EdgeInsets.only(top: _minimumPadding * 2),
      height: 150.0,
      child: Carousel(
        boxFit: BoxFit.fitHeight,
        images: widget.data.image.map((image) {
          return Image.network('http://139.59.91.150:3333/uploads/' + image);
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
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
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
            child: Column(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: _minimumPadding, right: _minimumPadding),
                  child: ListView(
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
                            padding: EdgeInsets.only(
                                top: _minimumPadding,
                                left: _minimumPadding * 2),
                            child: Text(
                              widget.data.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          )),
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
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: _minimumPadding),
                            child: Text(
                              "4.2",
                              style: TextStyle(color: Colors.yellow[800]),
                            ),
                          ),
                          Text(
                            "125 reviews",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Rs." +
                                  widget.data.variant[selectedVariant].price
                                      .toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Rs." +
                                  widget
                                      .data.variant[selectedVariant].actualPrice
                                      .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                discount.toString() + "%OFF",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 165, 0, 1),
                                    fontSize: 20.0),
                              )),
                        ],
                      ),
                      // getVariants(),
                      Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
                        child: Text(
                          "Select Variant",
                          style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                      getDropDown(),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Check Delivery Availability"),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.lightGreenAccent,
                            ),
                          ),
                          Text(
                            "Elgin Road,700063",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Spacer(),
                          ButtonTheme(
                            height: 30.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "Change",
                              ),
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
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(25.0),
                                                topRight: const Radius.circular(
                                                    25.0))),
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
                                                  child: Text(
                                                    "Use Pincode To Check Delivery Info",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    height: 45,
                                                    width: 250,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Enter Pincode',
                                                        border:
                                                            new OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
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
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  bottom: _minimumPadding * 2),
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
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Delivery Available In Your Area",
                          style: TextStyle(color: Colors.lightGreen),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(
                              Icons.airport_shuttle,
                              color: Colors.yellow[700],
                            ),
                          ),
                          Text(
                            "Eligible For Fast Delivery In 1 Day",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
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
                            child: !isOpen
                                ? Text(
                                    "All Details",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    size: 30.0,
                                  ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isOpen,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: _minimumPadding * 2,
                              top: _minimumPadding * 2),
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
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "4.2",
                              style: TextStyle(color: Colors.yellow[700]),
                            ),
                          ),
                          Text(
                            "80 Ratings And 125 Reviews",
                            style: TextStyle(color: Colors.black),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              ButtonTheme(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Color.fromRGBO(239, 121, 57, 1),
                  onPressed: () {
                    if (CheckValue) {
                      Map body = new Map();
                      body['customer_id'] = userId;
                      // body['product'] = widget.data.sId;
                      body['quantity'] = "1";
                      body['product'] = jsonEncode(product['product']);

                      _productDetailBloc.addToCart(product);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewLoginPage(
                                    data: widget.data,
                                  )));
                    }
                  },
                  child: StreamBuilder<ApiResponse<AddToCartModel>>(
                    stream: _productDetailBloc.productDetailPageStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            print("Case 1");
                            print(snapshot);
                            return CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(255, 241, 232, 1),
                              ),
                            );
                            break;
                          case Status.COMPLETED:
                            navigateScreen(context);
                            break;
                          case Status.ERROR:
                            print("Case 3");
                            print(snapshot);
                            Fluttertoast.showToast(
                                msg: "Failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return Text("Add To Cart",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white));
                            break;
                        }
                      }

                      return Text("Add To Cart",
                          style: TextStyle(color: Colors.white, fontSize: 18));
                    },
                  ),
                ),
              ),
              // FlatButton(onPressed: _launchURL, child: Text("Click"))
            ])));
  }

  navigateScreen(context) async {
    Future.delayed(Duration.zero, () async {
      Fluttertoast.showToast(
          msg: "Successfully added to Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage.second(selectedIndex: 2)));
    });
  }

  _launchURL() async {
    var url = 'mailto:arindam@inceptorytech.com?subject=hello&body=' +
        jsonEncode(product);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
