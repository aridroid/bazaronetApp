import 'package:bazaronet_fresh/AddressPage/AddressBloc.dart';
import 'package:bazaronet_fresh/AddressPage/AddressModel/SaveAddressModel.dart';
import 'package:bazaronet_fresh/AddressPage/SelectAddressPage.dart';
import 'package:bazaronet_fresh/RazorPayPage/RazorPayPage.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _nameAddress = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _landmark = new TextEditingController();
  TextEditingController _city = new TextEditingController();
  TextEditingController _state = new TextEditingController();
  TextEditingController _zip = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _addressType = new TextEditingController();
  SharedPreferences prefs;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  String userId = "";
  String userName = "";
  String email = "";
  String token = "";
  AddressBloc _addressBloc;

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _addressType.text = 'Home';
    _addressBloc = AddressBloc();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    userName = prefs.getString("userName");
    email = prefs.getString("email");
    token = prefs.getString("token");
  }

  // navToAttachList(context) async {
  //   Future.delayed(Duration.zero, () {
  //     print("push");
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (BuildContext context) {
  //           return AddressListPage();
  //         }));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(239, 121, 57, 1),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Center(
                child: Text(
              "Add Address".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ]),
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            // Address Text.....

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Add New Address",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        debugPrint("Hello");
                        _getLocation();
                      },
                      icon:
                          Icon(Icons.my_location, color: orangeTheme, size: 18),
                    ),
                  )
                ],
              ),
            ),

            // StreamBuilder<ApiResponse<AddressAddModel>>(
            //   stream: _addressAddBloc.addressAddStream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       switch (snapshot.data.status) {
            //         case Status.LOADING:
            //           return Loading(
            //             loadingMessage: snapshot.data.message,
            //           );
            //           break;
            //         case Status.COMPLETED:
            //           print("complete");
            //           // managedSharedPref(snapshot.data.data);
            //           navToAttachList(context);
            //           Fluttertoast.showToast(
            //               msg: "Address Added Successfully",
            //               fontSize: 14,
            //               backgroundColor: Colors.white,
            //               textColor: darkThemeBlue,
            //               toastLength: Toast.LENGTH_LONG);
            //
            //           break;
            //         case Status.ERROR:
            //           return Error(
            //             errorMessage: snapshot.data.message,
            //           );
            //           break;
            //       }
            //     } else if (snapshot.hasError) {
            //       print("error");
            //     }
            //
            //     return Container();
            //   },
            // ),


            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 25, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _nameAddress,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Full Name of Address",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            Container(
                height: 45.0,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Address Type",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      )),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _addressType.text,
                        items: <String>['Home', 'Office'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(value, style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              )
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _addressType.text = value;
                            print("Address Type: "+_addressType.text);
                          });
                        },
                      ),
                    )
                  ],
                ),
            ),

            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _address,
                keyboardType: TextInputType.streetAddress,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_balance),
                    hintText: "Address",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            // Email Text Field.....
            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _phone,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: "Enter your mobile number",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _landmark,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.directions),
                    hintText: "Nearest Landmark",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            // Email Text Field.....

            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _city,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: "City",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            // Email Text Field.....

            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _state,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.landscape),
                    hintText: "State",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            // Email Text Field.....

            Container(
              height: 45.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                controller: _zip,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.pin_drop),
                    hintText: "PIN Code",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            //Sign Up Button.....

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: ButtonTheme(
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    Map body = {
                      "customer_id": "$userId",
                      "type": "${_addressType.text}",
                      "fullName": "${_nameAddress.text}",
                      "email": "$email",
                      "phone": "${_phone.text}",
                      "state": "${_state.text}",
                      "city": "${_city.text}",
                      "postcode": "${_zip.text}",
                      "address": "${_address.text}",
                    };
                    _addressBloc.saveAddress(body);
                  },
                  color: orangeTheme,
                  textColor: Colors.white,
                  child: StreamBuilder<ApiResponse<SaveAddressModel>>(
                    stream: _addressBloc.addressStream,
                    builder:(context, snapshot) {
                      if(snapshot.hasData)
                      {
                        switch(snapshot.data.status)
                        {
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
                            alert(context);
                            return Text("Save Address", style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            );
                            break;
                          case Status.ERROR:
                            print("Case 3");
                            Fluttertoast.showToast(
                                msg: "Failed to save address",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            return Text("Save Address", style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            );
                            break;
                        }
                      }

                      return Text("Save Address", style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      );
                    },
                  ),
                ),
              ),
            ),

            // New Sign up Text.....

            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      _nameAddress.text = userName;
      _address.text = first.addressLine;
      _landmark.text = "";
      _city.text = first.subAdminArea;
      _state.text = first.adminArea;
      _zip.text = first.postalCode;
    });
    /*print(first.addressLine);
    print(first.adminArea);
    print(first.locality);
    print(first.subLocality);
    print(first.adminArea);
    print(first.subAdminArea);
    print(first.featureName);
    print(first.subThoroughfare);
    print(first.thoroughfare);
    print(first.postalCode);*/

    /*_.text = "${first.addressLine}";
    print("${first.featureName} : ${first.addressLine}");*/
  }

  alert(BuildContext context){
    Future.delayed(Duration.zero, () async {
      Fluttertoast.showToast(
          msg: "Address added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddressListPage())
          );
    });
  }

}
