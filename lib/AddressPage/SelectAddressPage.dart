import 'package:bazaronet_fresh/AddressPage/AddressModel/SelectAddressModel.dart';
import 'package:bazaronet_fresh/AddressPage/AddressPage.dart';
import 'package:bazaronet_fresh/AddressPage/AddressRepository/AddressRepository.dart';
import 'package:bazaronet_fresh/RazorPayPage/RazorPayPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<Data> data;
  String userToken = "";
  Map body;
  String userId = "";
  int selectedAddressIndex;
  Future<SelectAddressModel> _addressApi;
  AddressRepository _repository = AddressRepository();
  double screenWidth;
  double screenHeight;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  Future<void> createSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("address page");
    userId = prefs.getString("userId");
    userToken = prefs.getString("token");
    _addressApi = _repository.getAddress(userId, userToken);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  String _addressId="";
  String _address="";

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            if(_addressId!=""){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RazorPayScreen()));
            }
            else{
              Fluttertoast.showToast(
                  msg: "Please Select a Address",
                  fontSize: 16,
                  backgroundColor: Colors.white,
                  textColor: Colors.red,
                  toastLength: Toast.LENGTH_LONG);
            }
          },
          elevation: 5.0,
          label: Container(
            height: 35.0,
            child: Center(
              child: Text(
                "  Checkout >>>  ",
                style:
                TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
              ),
            ),
          ),
        ),
        appBar: AppBar(
            backgroundColor: orangeTheme,
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Center(
                child: Text(
                  "Select Address".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04),
                )),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ]),
        backgroundColor: Colors.white70,
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressPage()));
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.add,
                        size: 25.0,
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: Text(
                          " Add New Address",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            FutureBuilder<SelectAddressModel>(
                future: _addressApi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data.data;
                    if(selectedAddressIndex == null)  {
                      selectedAddressIndex = snapshot.data.data.length - 1;
                    }
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          if(selectedAddressIndex == index){
                            _addressId = snapshot.data.data[index].sId;
                          }
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                            margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                            // height: 160,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Radio(
                                        value: snapshot.data.data[index].sId,
                                        groupValue: _addressId,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedAddressIndex = index;
                                            _addressId = value;
                                            print("ID:"+_addressId+"Selected Index:"+selectedAddressIndex.toString());
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 8.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data.data[index].fullName}",
                                              style: TextStyle(
                                                  color: Colors.lightBlue[900],
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: ButtonTheme(
                                          height: 25.0,
                                          // minWidth: 10.0,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: orangeTheme,
                                                  width: 1.3,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            textColor: Colors.white,
                                            child: Text(
                                              "edit",
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2.0, 0.0, 8.0, 5.0),
                                        child: Text(
                                          snapshot.data.data[index].address,
                                          // "${snapshot.data.data[index].address}, ${snapshot.data.data[index].landmark}, ${snapshot.data.data[index].city}, ${snapshot.data.data[index].state}, ${snapshot.data.data[index].zip}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("No Data Found");
                  } else
                    return Center(
                      heightFactor: 5,
                      widthFactor: 10,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(orangeTheme)
                      ),
                    );
                }),
          ],
        ),
      ),
    );
  }
}
