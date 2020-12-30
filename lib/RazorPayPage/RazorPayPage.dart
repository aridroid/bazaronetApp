import 'dart:convert';
import 'package:bazaronet_fresh/HomePage/HomePage.dart';
import 'package:bazaronet_fresh/RazorPayPage/Bloc/DeleteCartBloc.dart';
import 'package:bazaronet_fresh/RazorPayPage/Model/AddOrderProductModel.dart';
import 'package:bazaronet_fresh/RazorPayPage/Bloc/RazorPayBloc.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RazorPayScreen extends StatefulWidget {
  //final OrderPlaceResponseModel snapshotData;
  final String userToken;
  final String totalCartAmount;
  final Map product;
  final List<String> ids;


  const RazorPayScreen({Key key, this.userToken,this.totalCartAmount, this.product, this.ids}) : super(key: key);
  @override
  _RazorPayScreenState createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  static const platform = const MethodChannel("razorpay_flutter");
  String _baseUrl = "http://demo.ewinfotech.com/bookingapp/public/api/";

  Razorpay _razorpay;
  SharedPreferences prefs;
  String userPhone;
  String userEmail;
  RazorPayBloc _razorPayBloc = RazorPayBloc();
  Map<String, List<String>> ids = new Map<String, List<String>>();
  DeleteCartBloc _deleteCartBloc = DeleteCartBloc();


  ApiBaseHelper _apiBaseHelper=new ApiBaseHelper();
  Map _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          /* title: Center(child: CircleAvatar(
          backgroundImage: AssetImage("assets/logos/foreground.png"),
        )),*/
          title: Center(
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
                height: 35.0,
              )),
        ),
        body: ListView(
          children: [
            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          onPressed: openCheckout, child: Text('Pay Using RazorPay')
                      )
                    ]
                )
            ),
            StreamBuilder<ApiResponse<AddOrderProductModel>>(
              stream: _razorPayBloc.razorPayStream,
              builder:(context, snapshot) {
                if(snapshot.hasData)
                {
                  switch(snapshot.data.status)
                  {
                    case Status.LOADING:
                      print("Case 1");
                      print(snapshot);
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(255, 241, 232, 1),
                            ),
                          ),
                        );
                      break;
                    case Status.COMPLETED:
                      Future.delayed(Duration.zero, () async {
                        // _showResponse("Success");
                        print("Ids:"+widget.ids.toString());
                        ids['ids']= widget.ids;
                        print("Map Ids:"+ids.toString());
                        _deleteCartBloc.deleteCartIds(ids);
                      });
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
                          fontSize: 16.0
                      );
                      break;
                  }
                }

                return Container();
              },
            ),
            StreamBuilder<ApiResponse>(
              stream: _deleteCartBloc.razorPayStream,
              builder:(context, snapshot) {
                if(snapshot.hasData)
                {
                  switch(snapshot.data.status)
                  {
                    case Status.LOADING:
                      print("Case 1");
                      print(snapshot);
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(255, 241, 232, 1),
                          ),
                        ),
                      );
                      break;
                    case Status.COMPLETED:
                      Future.delayed(Duration.zero, () async {
                        _showResponse("Success");
                      });
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
                          fontSize: 16.0
                      );
                      break;
                  }
                }

                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userEmail=prefs.getString("email");
    userPhone="9007511742";
    /*setState(() {

    });*/

  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
  //  print(widget.snapshotData.data.transactionId.toString()+"here is the Transaction id");
   // double price=double.parse(widget.totalCartAmount);
    //print("$price+ amount in double ");
    // print(int.parse(widget.totalCartAmount));
   // price=price*100;
   // print("$price+ amount in double *100 ");
    //int price1=price.toInt();
  //  print("$price1+ amount in double price1 ");
    var options = {
       'key': 'rzp_test_BgJqsaZuDQ01OE',
     // 'key': 'rzp_test_PBQnbzep71IxJC',
      // 'key': widget.data.data.unique_transaction_id,
        'amount': 100,
      'name': 'BazarONet',
      'description': 'DOT Order Payment',
     // 'order_id': "1234",
      'prefill': {'contact': '$userPhone', 'email': '$userEmail'},
      'external': {
        'wallets': ['paytm']


        // 'wallets' : ['amazonoay']
      }
    };
    print(options);
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {


    /*Map _body={
      "orderid" : "${widget.snapshotData.data.id}",
      "transid" : "${widget.snapshotData.data.transactionId}",
      "status" : "${widget.snapshotData.message}"
    };*/
    //_response= await _apiBaseHelper.postWithHeader("order/status/update", _body,"Bearer ${widget.userToken}");
    prefs.setString("cart_id","");
    print("cart id at payment success 1 == ${prefs.getString("cart_id")}");


    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //         builder: (context) => OrderDetailsPage()),ModalRoute.withName("/HomePage"));
    // builder: (context) =>LoginScreen(title: 'MyDoc')));
    //  builder: (context) =>MyApp()));
    // builder: (context) =>IndexPage(channelName: 'AriDoc')));
    ///////////
    prefs.setString("cart_id","");
    print("cart id at payment success 2 == ${prefs.getString("cart_id")}");

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);

    _razorPayBloc.addOrder(widget.product);
    // _showResponse("Success");

  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print(response.message);
    Map _body={
      // "orderid" : "${widget.snapshotData.data.id}",
      // "transid" : "${widget.snapshotData.data.transactionId}",
      // "status" : "${widget.snapshotData.message}"
    };
    _response= await _apiBaseHelper.postWithHeader("order/status/update", _body,"Bearer ${widget.userToken}");
    prefs.setString("cart_id","");
    print("cart id at payment success 2 == ${prefs.getString("cart_id")}");
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
    print("ERROR: " + response.code.toString() + " - " + response.message);
    prefs.setString("cart_id","");
    print("cart id at payment success 2 == ${prefs.getString("cart_id")}");
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => HomePage()));
    _showResponse("Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => IndexPage()));
  }

  Future<void> _showResponse(String status) async {
    if(status == 'Success'){
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment SuccessFul', style: TextStyle(
                color: Colors.greenAccent
            ),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Go to Home Page'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Go Back', style: TextStyle(
                  color: Colors.greenAccent
                ),),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(
                      builder: (context) => HomePage()));
                },
              ),
            ],
          );
        },
      );
    }
    else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Failed',
              style: TextStyle(
                  color: Colors.redAccent
              ),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Go to Home Page'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Go Back', style: TextStyle(
                    color: Colors.redAccent
                ),),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(
                      builder: (context) => HomePage()));
                },
              ),
            ],
          );
        },
      );
    }

  }
}