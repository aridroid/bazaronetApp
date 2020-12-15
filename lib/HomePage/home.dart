import 'dart:async';

import 'package:bazaronet_fresh/HomePage/Model/BannerModel.dart';
import 'package:bazaronet_fresh/HomePage/Model/CategoryModel.dart';
import 'package:bazaronet_fresh/HomePage/Repository/HomeRepository.dart';
import 'package:bazaronet_fresh/SubCategoryPage/SubCategoryPage.dart';
import 'package:bazaronet_fresh/VerificationPage/VerificationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _minimumPadding = 5.0;
  HomeRepository _homeRepository;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  ScrollController controller;
  List<String> Images = [
    'images/cleaning.png',
    'images/electrical.png',
    'images/sink.png',
    'images/cleaning.png',
    'images/electrical.png',
    'images/sink.png'
  ];
  List<String> Names = [
    'Cleaning',
    'Electrician',
    'Plumber',
    'Cleaning',
    'Electrician',
    'Plumber',
  ];


  @override
  void initState() {
    _homeRepository = HomeRepository();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
          color: Colors.white,
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white70,
          child: ListView(
            controller: controller,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: _minimumPadding * 2, right: _minimumPadding * 2),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.greenAccent,
                      ),
                    ),
                    Expanded(
                      child: Text("Elgin Road, 700563",
                          style: TextStyle(
                            fontSize: 15.0,
                          )),
                    ),
                    ButtonTheme(
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Color.fromRGBO(239, 121, 57, 1),
                        child: Text(
                          "Change",
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 150.0,
                  margin: EdgeInsets.only(left: _minimumPadding, right: _minimumPadding),
                  child: FutureBuilder<BannerModel>(
                      future: _homeRepository.getBannerData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(239, 121, 57, 1)),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Container(
                            child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  height: 150.0,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemCount: snapshot.data.data.length,
                                itemBuilder:
                                    (BuildContext context, int itemIndex) {
                                  return Image.network(
                                      'http://139.59.91.150:3333/uploads/' +
                                          snapshot.data.data[itemIndex].image,
                                      fit: BoxFit.fitHeight);
                                }),
                          );
                        } else {
                          return Container();
                        }
                      })
              ),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                    left: _minimumPadding * 2,
                    right: _minimumPadding * 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Nearby shops ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: orangeTheme,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding, right: _minimumPadding, left: _minimumPadding),
                  height: 120.0,
                  margin: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin:
                            EdgeInsets.only(
                                right: _minimumPadding * 2,
                                top: _minimumPadding,
                                bottom: _minimumPadding),
                            child: Card(
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 3.0,
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.all(_minimumPadding),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/coffeemaker.jpg'),
                                            fit: BoxFit.fill)),
                                  ),
                                  Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            _minimumPadding),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "New Coffee Shop",
                                              style: TextStyle(fontSize: 18),
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
                                                  "4.2",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(255, 165, 0, 1),
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.timer,
                                                  color: Colors.grey,
                                                  size: 12.0,
                                                ),
                                                Text(
                                                  "9AM - 7PM",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Open Now",
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      " Elgin Road, 700563",
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.grey)),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.push_pin,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                ),
                                                Text(" -------25-------",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey)),
                                                Container(
                                                  child: Icon(
                                                    Icons.card_travel,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  child: Icon(
                                                    Icons.call,
                                                    color: Color.fromRGBO(255, 165, 0, 1),
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                    left: _minimumPadding * 2,
                    right: _minimumPadding * 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Shop by Category ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: orangeTheme,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child:
                FutureBuilder<CategoryModel>(
                    future: _homeRepository.getCategory(),
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
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: _minimumPadding,
                              mainAxisSpacing: _minimumPadding,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SubCategoryPage(
                                              id: snapshot.data
                                                  .data[index].sId)
                                  ),
                                );
                              },
                              child: Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5.0,
                                    child: Image.network(
                                      'http://139.59.91.150:3333/uploads/'
                                          + snapshot.data.data[index].image,
                                      fit: BoxFit.fill,)
                                  // ignore: dead_code
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                    left: _minimumPadding * 2,
                    right: _minimumPadding * 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Domestic Services ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                          color: orangeTheme,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                  height: 120.0,
                  margin: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding, right: _minimumPadding, left: _minimumPadding),
                  child: ListView.builder(
                      itemCount: Images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(10),
                                // image: DecorationImage(
                                //     image: AssetImage('images/coffeemaker.jpg'),
                                //     fit: BoxFit.fill)
                                ),
                            margin: EdgeInsets.only(
                                right: _minimumPadding*2,
                                top: _minimumPadding,
                                bottom: _minimumPadding
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5.0,
                              margin: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: _minimumPadding*4,
                                          left: _minimumPadding*3,
                                          right: _minimumPadding*3
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(Images[index]),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(Names[index]),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 220,
                  margin: EdgeInsets.fromLTRB(_minimumPadding, _minimumPadding*2, _minimumPadding, _minimumPadding*2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: AssetImage('images/bottle.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.fromLTRB(_minimumPadding, _minimumPadding*2, _minimumPadding, _minimumPadding*2),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(_minimumPadding*2, _minimumPadding*2, 0, _minimumPadding*2),
                      child: Text(
                        "Offer for you",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      ),
                    ),
                    Container(
                        child: CarouselSlider(
                            items: [
                              Image.asset('images/coupon1.png', fit: BoxFit.fill),
                              Image.asset('images/coupon2.png', fit: BoxFit.fill),
                              Image.asset('images/coupon3.png', fit: BoxFit.fill),
                            ],
                            options: CarouselOptions(
                              height: 140.0,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.6,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ))),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //       top: _minimumPadding * 2,
              //       bottom: _minimumPadding * 2,
              //       left: _minimumPadding * 2,
              //       right: _minimumPadding * 2),
              //   color: Colors.white,
              //   child: Row(
              //     children: [
              //       Text("Offers  ",
              //           style: TextStyle(
              //               fontSize: 18.0, fontWeight: FontWeight.bold)),
              //       Image.asset(
              //         'images/price-tag.png',
              //         height: 20.0,
              //         alignment: Alignment.topLeft,
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //     margin: EdgeInsets.only(
              //         top: _minimumPadding, bottom: _minimumPadding),
              //     height: 150.0,
              //     child: CarouselSlider(
              //         items: [
              //           Image.asset('images/coupon1.png', fit: BoxFit.fill),
              //           Image.asset('images/coupon2.png', fit: BoxFit.fill),
              //           Image.asset('images/coupon3.png', fit: BoxFit.fill),
              //         ],
              //         options: CarouselOptions(
              //           height: 140.0,
              //           aspectRatio: 16 / 9,
              //           viewportFraction: 0.6,
              //           initialPage: 0,
              //           enableInfiniteScroll: true,
              //           reverse: false,
              //           autoPlay: true,
              //           autoPlayInterval: Duration(seconds: 3),
              //           autoPlayAnimationDuration: Duration(milliseconds: 800),
              //           autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              //           enlargeCenterPage: true,
              //           scrollDirection: Axis.horizontal,
              //         ))),
            ]
            ,
          )
          ,
        )
    );
  }
}
