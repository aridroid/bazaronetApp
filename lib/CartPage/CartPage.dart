import 'package:bazaronet_fresh/AddressPage/AddressPage.dart';
import 'package:bazaronet_fresh/AddressPage/SelectAddressPage.dart';
import 'file:///D:/Flutter/bazaronet_fresh/lib/CartPage/CartBloc/CartBloc.dart';
import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart' as cartData;
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'file:///D:/Flutter/bazaronet_fresh/lib/CartPage/CartBloc/DeleteProductBloc.dart';
import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:bazaronet_fresh/LoginPage/LoginPage.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:bazaronet_fresh/new_login_page/new_login_page.dart';
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
  String token;
  String userName;
  String email;
  bool CheckValue = false;
  bool checkOutButtonState = false;
  SharedPreferences prefs;
  bool loading = true;
  CartRepository _cartRepository;
  double cost = 0;
  int selectedItem;
  int deletedItem;
  List<int> _quantityController = new List();
  Future<cartData.CartPageModel> cartModel;
  CartBloc _cartBloc;
  DeleteProductBloc _deleteProductBloc;
  int discount;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  Map product = new Map();
  List<Products> orderedProducts = new List<Products>();
  List<cartData.Data> allProducts = new List<cartData.Data>();
  List<String> ids = new List<String>();

  @override
  void initState() {
    print("In Init");
    getuserId();
    _cartRepository = CartRepository();
    _cartBloc = CartBloc();
    _deleteProductBloc = DeleteProductBloc();
  }

  addAmount(cartData.CartPageModel data, int index) {
    Future.delayed(Duration.zero, () async {
      cost= cost + data.data[index].product.selectedVariant.price*data.data[index].quantity;
      print("Cost: "+cost.toString());
      checkOutButtonState = true;
      setState(() {

      });
    });
  }


  getuserId() async {
    print("In Async");
    prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('userId');
    CheckValue = checkValue;
    String stringValue = prefs.getString('userId');
    userId = stringValue;
    token = prefs.getString('token');
    userName = prefs.getString('userName');
    email = prefs.getString('email');
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

  updateCart(String operation, int index) {
      if (operation == "minus") {
          _quantityController[index]--;
      }
      else if (operation == "plus") {
          _quantityController[index]++;
      }
      setState(() {

      });
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }

  calculateDiscount(cartData.Data data) {
    double discount2 = (1 - data.product.selectedVariant.price/data.product.selectedVariant.actualPrice)*100;
    discount = discount2.toInt();
  }

  returnFutureList() {
    return Expanded(
        child: FutureBuilder<cartData.CartPageModel>(
            future: _cartRepository.getCartById(userId),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                print("Loading");
                return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(239, 121, 57, 1),
                      ),
                    )
                );
              }
              else{
                print("Loaded");
                allProducts = snapshot.data.data;
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      calculateDiscount(snapshot.data.data[index]);
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
                              top: _minimumPadding,
                              bottom: _minimumPadding,
                              left: _minimumPadding*2,
                              right: _minimumPadding*2),
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
                                      0.25,
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
                                        left: _minimumPadding),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data.data[index].product.name.length > 19 ?
                                                '${snapshot.data.data[index].product.name.substring(0,19)}...': snapshot.data.data[index].product.name,
                                                style: TextStyle(
                                                    fontSize: 15.0
                                                ),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  deletedItem = index;
                                                  _deleteProductBloc.deleteCartById(snapshot.data.data[index].sId);
                                                },
                                                child: StreamBuilder<ApiResponse>(
                                                  stream: _deleteProductBloc.deleteProductStream,
                                                  builder:(context, snapshot3) {
                                                    if(snapshot3.hasData)
                                                    {
                                                      switch(snapshot3.data.status)
                                                      {
                                                        case Status.LOADING:
                                                          print("Case 1:Index"+index.toString());
                                                          print(snapshot3);
                                                          if(index == deletedItem){
                                                            return Center(
                                                              child: CircularProgressIndicator(
                                                                valueColor: new AlwaysStoppedAnimation<Color>(
                                                                  Color.fromRGBO(255, 241, 232, 1),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          break;
                                                        case Status.COMPLETED:
                                                          if(index == deletedItem){
                                                            print("Case 2:Index"+index.toString());
                                                            reload(selectedItem);
                                                          }
                                                          return Padding(
                                                            padding: EdgeInsets.only(right: 5.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.grey,
                                                            ),
                                                          );
                                                          break;
                                                        case Status.ERROR:
                                                          print("Case 3");
                                                          print(snapshot3);
                                                          Fluttertoast.showToast(
                                                              msg: "Failed",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.CENTER,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                          return Padding(
                                                            padding: EdgeInsets.only(right: 5.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.grey,
                                                            ),
                                                          );
                                                          break;
                                                      }
                                                    }

                                                    return Padding(
                                                      padding: EdgeInsets.only(right: 5.0),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(255, 165, 0, 1),
                                                size: 15.0,
                                              ),
                                              Text(
                                                " 4.2",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(255, 165, 0, 1),
                                                    fontSize: 12.0),
                                              ),
                                              Text(
                                                " 125 Reviews",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey
                                                ),)
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text("Rs."+snapshot.data.data[index].product.selectedVariant.price.toString()+" ",
                                                style: TextStyle(
                                                  fontSize: 15.0,),),
                                              Text(" Rs."+snapshot.data.data[index].product.selectedVariant.actualPrice.toString(), style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                  fontSize: 15.0),),
                                              Text(" "+discount.toString()+"% OFF", style: TextStyle(
                                                  color: Color.fromRGBO(255, 165, 0, 1),
                                                  fontSize: 15.0),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.only(right: _minimumPadding*2),
                                                child: Icon(
                                                  Icons.airport_shuttle,
                                                  size: 20.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(" Delivery within 2 hours",
                                                style: TextStyle(
                                                    color: Colors.grey,
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
                                                    body['quantity'] = (snapshot.data.data[index].quantity -1).toString();
                                                    selectedItem = index;
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
                                                          if(index == selectedItem){
                                                            return Center(
                                                              child: CircularProgressIndicator(
                                                                valueColor: new AlwaysStoppedAnimation<Color>(
                                                                  Color.fromRGBO(255, 241, 232, 1),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          break;
                                                        case Status.COMPLETED:
                                                          if(index == selectedItem){
                                                            reload(selectedItem);
                                                          }
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
                                                  body['quantity'] = (snapshot.data.data[index].quantity +1).toString();
                                                  selectedItem = index;
                                                  _cartBloc.updateCartById(body, snapshot.data.data[index].sId);
                                                  updateCart("plus", index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(right: _minimumPadding),
                                                  child: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.grey,
                                                  ),
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
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(orangeTheme),
                ),
              )
          )
      );
    }
    if (!CheckValue) {
      navigateScreen();
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
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(orangeTheme),
              ),
            )
          )
      );
    } else {
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
          child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
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

  reload(int index) {
    Future.delayed(Duration.zero, () async {
      selectedItem = -1;
      print("Reload Index:"+index.toString());
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
          MaterialPageRoute(builder: (context) => NewLoginPage(data: null)));
    });
  }

  navigateToAddressPage() {
    product["customer_id"] = userId;
    product["customer"] = new Customer(
      loggedin: true,
      token: token,
      id: userId,
      name: userName,
      email: email,
      phone: "+917278682875"
    );
    generateProducts();
    product["products"] = orderedProducts;
    product["payment"] = "1234";
    product["total"] = "1234";
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddressListPage(
            product: product,
            ids: ids
          )));
    });
  }

  generateProducts() {
    for(int i = 0; i<= allProducts.length -1; i++){
      orderedProducts.add(
        new Products(
          quantity: allProducts[i].quantity,
          product: allProducts[i].product
        )
      );
      ids.add(allProducts[i].sId);
    }
  }
}

class Customer {
  bool loggedin;
  String id;
  String email;
  String name;
  String phone;
  String token;

  Customer(
      {this.loggedin, this.id, this.email, this.name, this.phone, this.token});

  Customer.fromJson(Map<String, dynamic> json) {
    loggedin = json['loggedin'];
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loggedin'] = this.loggedin;
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['token'] = this.token;
    return data;
  }
}


class Products {
  cartData.Product product;
  int quantity;

  Products({this.product, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new cartData.Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int tax;
  List<String> image;
  int shipping;
  int minAmountForFreeShipping;
  bool status;
  String delivery;
  String sId;
  String name;
  String model;
  Category category;
  String subcategory;
  String manufacturer;
  int unit;
  int quantity;
  String quantityClass;
  String description;
  Variant variant;
  String dateAdded;
  String dateModified;
  int v;
  Variant selectedVariant;

  Product(
      {this.tax,
        this.image,
        this.shipping,
        this.minAmountForFreeShipping,
        this.status,
        this.delivery,
        this.sId,
        this.name,
        this.model,
        this.category,
        this.subcategory,
        this.manufacturer,
        this.unit,
        this.quantity,
        this.quantityClass,
        this.description,
        this.variant,
        this.dateAdded,
        this.dateModified,
        this.v,
        this.selectedVariant});

  Product.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    image = json['image'].cast<String>();
    shipping = json['shipping'];
    minAmountForFreeShipping = json['min_amount_for_free_shipping'];
    status = json['status'];
    delivery = json['delivery'];
    sId = json['_id'];
    name = json['name'];
    model = json['model'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'];
    manufacturer = json['manufacturer'];
    unit = json['unit'];
    quantity = json['quantity'];
    quantityClass = json['quantity_class'];
    description = json['description'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    v = json['v'];
    selectedVariant = json['selectedVariant'] != null
        ? new Variant.fromJson(json['selectedVariant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    data['image'] = this.image;
    data['shipping'] = this.shipping;
    data['min_amount_for_free_shipping'] = this.minAmountForFreeShipping;
    data['status'] = this.status;
    data['delivery'] = this.delivery;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['subcategory'] = this.subcategory;
    data['manufacturer'] = this.manufacturer;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['quantity_class'] = this.quantityClass;
    data['description'] = this.description;
    if (this.variant != null) {
      data['variant'] = this.variant.toJson();
    }
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['v'] = this.v;
    if (this.selectedVariant != null) {
      data['selectedVariant'] = this.selectedVariant.toJson();
    }
    return data;
  }
}

class Category {
  bool status;
  String sId;
  String name;
  int sortOrder;
  String description;
  String image;
  String dateAdded;
  String dateModified;
  int v;

  Category(
      {this.status,
        this.sId,
        this.name,
        this.sortOrder,
        this.description,
        this.image,
        this.dateAdded,
        this.dateModified,
        this.v});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    sortOrder = json['sort_order'];
    description = json['description'];
    image = json['image'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['sort_order'] = this.sortOrder;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['v'] = this.v;
    return data;
  }
}

class Variant {
  List<VariantProperties> variantProperties;
  String sId;
  int price;
  int actualPrice;
  int stock;

  Variant(
      {this.variantProperties,
        this.sId,
        this.price,
        this.actualPrice,
        this.stock});

  Variant.fromJson(Map<String, dynamic> json) {
    if (json['variant_properties'] != null) {
      variantProperties = new List<VariantProperties>();
      json['variant_properties'].forEach((v) {
        variantProperties.add(new VariantProperties.fromJson(v));
      });
    }
    sId = json['_id'];
    price = json['price'];
    actualPrice = json['actual_price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variantProperties != null) {
      data['variant_properties'] =
          this.variantProperties.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['price'] = this.price;
    data['actual_price'] = this.actualPrice;
    data['stock'] = this.stock;
    return data;
  }
}

class VariantProperties {
  String sId;
  String variantType;
  String variantValue;
  String variantClass;

  VariantProperties(
      {this.sId, this.variantType, this.variantValue, this.variantClass});

  VariantProperties.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    variantType = json['variant_type'];
    variantValue = json['variant_value'];
    variantClass = json['variant_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['variant_type'] = this.variantType;
    data['variant_value'] = this.variantValue;
    data['variant_class'] = this.variantClass;
    return data;
  }
}

class DeletableIds {
  List<String> ids;

  DeletableIds({this.ids});

  DeletableIds.fromJson(Map<String, dynamic> json) {
    ids = json['ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ids'] = this.ids;
    return data;
  }
}
