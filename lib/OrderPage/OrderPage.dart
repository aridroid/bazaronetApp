import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  SharedPreferences prefs;
  String userToken="";
  String userId="";
  // OrderDetailsRepository _orderDetailsRepository;
  // Future<OrderDetailsModel> _orderDetailsApi;
  Map _body;
  double screenHeight;
  double screenWidth;
  var statusCol;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  var now = new DateTime.now();
  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userToken=prefs.getString("token");
    userId=prefs.getString("userId");
    _body={
      "userId":"$userId"
    };
    // _orderDetailsRepository=new OrderDetailsRepository();
    // _orderDetailsApi=_orderDetailsRepository.orderDetails(_body, userToken);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight= MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0))),
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.white70,
            child: ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index){
                    // if(snapshot.data.data[index].transactionStatus=="Pending"){
                    //   statusCol=Colors.red;
                    // }else{
                    //   statusCol=Colors.green;
                    // }
                    statusCol=Colors.red;
                    return InkWell(
                      onTap: (){

                      },

                      child: Container(
                        height: screenHeight*0.17,
                        width: screenWidth,
                        margin: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    color: Colors.orange[100],
                                    child:Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          // color: lightThemeBlue,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/diapers.jpg"),
                                              fit: BoxFit.fill)),
                                    )
                                )
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(height: screenHeight*0.15, child: VerticalDivider(color: Colors.black,thickness: 1.0,)),
                                    ),
                                    Expanded(
                                        flex: 8,
                                        child: Container(
                                            padding: EdgeInsets.fromLTRB(0.0,5.0,5.0,5.0),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("ORDER ID : 123",
                                                    style: TextStyle(
                                                        // color: lightThemeBlue,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("Order Values : 123",
                                                    style: TextStyle(
                                                        // color: lightThemeBlue,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Text("Order Date : "+now.toString(),
                                                    style: TextStyle(
                                                      //   color: lightThemeBlue,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                  Row(
                                                    children: [
                                                      Text("Status : ",
                                                        style: TextStyle(
                                                            // color: lightThemeBlue,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w600
                                                        ),),
                                                      Text("Dummy Order",
                                                        style: TextStyle(
                                                            color: statusCol,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w600
                                                        ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                        )
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },

                )
              ],
            )
        )
    );
  }
}