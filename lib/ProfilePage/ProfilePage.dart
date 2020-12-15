import 'package:bazaronet_fresh/AddressPage/SelectAddressPage.dart';
import 'package:bazaronet_fresh/ProfilePage/Model/ProfilePageModel.dart';
import 'package:bazaronet_fresh/ProfilePage/Repository/ProfilePageRepository.dart';
import 'package:bazaronet_fresh/new_login_page/new_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double _minimumPadding = 5.0;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  SharedPreferences prefs;
  String userId;
  String userName;
  String email;
  String token;
  bool checkValue;
  bool loading = true;
  ProfilePageRepository _profilePageRepository = ProfilePageRepository();

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      checkValue = prefs.containsKey('userId');
      userId = prefs.getString("userId");
      userName = prefs.getString("userName");
      email = prefs.getString("email");
      token = prefs.getString("token");
      loading = false;
      print("In async");
    });
  }


  @override
  void initState() {
    createSharedPref();
    print("In init");
  }

  removeValue() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove("userName");
    prefs.remove("email");
    prefs.remove("token");
    navigateScreen();
  }
  navigateScreen() {
    Future.delayed(Duration.zero, () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewLoginPage(data: null)));
    });
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
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(orangeTheme),
                ),
              )
          )
      );
    }
    if(!checkValue) {
      navigateScreen();
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
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(orangeTheme),
                ),
              )
          )
      );
    }
    else {
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
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
            ),
            child: FutureBuilder<ProfilePageModel>(
                future: _profilePageRepository.getProfile(userId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(239, 121, 57, 1)),
                      ),
                    );
                  }
                  else if (snapshot.hasData) {
                    return ListView(
                      children: [
                        Container(
                          height: 135.0,
                          margin: EdgeInsets.all(_minimumPadding),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),),
                              elevation: 5.0,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        _minimumPadding * 2, 0, _minimumPadding * 2, 0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage('images/user.jpg'),
                                      radius: 40,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: _minimumPadding *
                                          2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                                snapshot.data.name,
                                                //textAlign: TextAlign.left,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  color: Colors.black87,
                                                )
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                snapshot.data.email,
                                                //textAlign: TextAlign.left,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 18.0,
                                                  color: Colors.grey,
                                                )
                                            ),
                                          ),
                                          Container
                                            (child: Text(
                                              "+91"+snapshot.data.phone,
                                              // textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 18.0,
                                                color: Colors.grey,
                                              )
                                          ),),


                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, _minimumPadding, _minimumPadding, 0),
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.grey,)
                                    ),
                                  )
                                ],)

                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),),
                            elevation: 5.0,
                            margin: EdgeInsets.only(top: 15.0),
                            child:
                            Container(
                              child: Column(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => AddressListPage()
                                    ));
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.location_on, color: orangeTheme,),
                                    title: Text('Address'),
                                  ),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(Icons.notifications,
                                    color: orangeTheme,),
                                  title: Text('Notification'),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(Icons.star, color: orangeTheme,),
                                  title: Text('My Reviews'),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(Icons.lock, color: orangeTheme,),
                                  title: Text('Change Password'),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    removeValue();
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.logout, color: orangeTheme,),
                                    title: Text('Logout'),
                                  ),
                                ),

                              ],),),

                          ),
                        ),

                      ],);
                  }
                  else {
                    return Container();
                  }
                }),

          ));
    }
  }
}


/*class ProfileImage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      AssetImage assetImage = AssetImage("images/profile.png");
      Image image = Image(image: assetImage);
      return Container(child: image,width: 100.0,height: 100.0,);
    }
}*/