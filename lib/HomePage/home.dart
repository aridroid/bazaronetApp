import 'package:bazaronet_fresh/HomePage/Model/BannerModel.dart';
import 'package:bazaronet_fresh/HomePage/Model/CategoryModel.dart';
import 'package:bazaronet_fresh/HomePage/Repository/HomeRepository.dart';
import 'package:bazaronet_fresh/SubCategoryPage/SubCategoryPage.dart';
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
  @override
  void initState() {
    _homeRepository = HomeRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0)),
            color: Color.fromRGBO(255, 241, 232, 1)),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Color.fromRGBO(255, 241, 232, 1),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.2,
                child: FutureBuilder<BannerModel>(
                    future: _homeRepository.getBannerData(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (!snapshot.hasData) {
                        return Center(
                          child:
                          CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 121, 57, 1)),
                          ),
                        );

                      }
                      else if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.only(top: _minimumPadding * 2),
                          child: CarouselSlider.builder(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * 0.2,
                              ),
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (BuildContext context, int itemIndex) {
                                return Image.network(
                                    'http://139.59.91.150:3333/uploads/' +
                                        snapshot.data.data[itemIndex].image,
                                    fit: BoxFit.fill);
                              }),
                        );
                      }
                      else {
                        return Container();
                      }
                    }
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  top: _minimumPadding*2,
                  bottom: _minimumPadding*2,
                  left: _minimumPadding *2,
                  right: _minimumPadding*2
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Text("Shop Nearby  ", style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    )
                    ),
                    Expanded(
                        child: Image.asset('images/shopping-bag.png', height: 20.0, alignment: Alignment.topLeft,)
                    ),
                    ButtonTheme(
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {

                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Color.fromRGBO(239, 121, 57, 1),
                        child: Text("Within 2 hours delivary", style: TextStyle(
                            color: Colors.white
                        ),
                        ),
                        elevation: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 135.0,
                child: Container(
                  margin: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: FutureBuilder<CategoryModel>(
                    future: _homeRepository.getCategory(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (!snapshot.hasData) {
                        return Center(
                          child:
                          CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 121, 57, 1)),
                          ),
                        );
                      }
                      else if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data.data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context,int index){
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SubCategoryPage(
                                      id: snapshot.data.data[index].sId
                                    )),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.only(right: _minimumPadding),
                                  child: Image.network(
                                      'http://139.59.91.150:3333/uploads/' +
                                          snapshot.data.data[index].image,
                                      fit: BoxFit.fill
                                  ),
                                ),
                              );
                            }
                          )
                        );
                      }
                      else {
                        return Container();
                      }
                    }
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding*2,
                    bottom: _minimumPadding*2,
                    left: _minimumPadding *2,
                    right: _minimumPadding*2
                ),
                color: Colors.white,
                child: Row(
                  children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("Shop by Category  ", style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                )
                                ),
                                Image.asset('images/choose.png', height: 20.0, alignment: Alignment.topLeft,)
                              ],
                            ),
                            Text("Far away store", style: TextStyle(
                              color: Color.fromRGBO(239, 121, 57, 1),
                            ),
                            ),
                          ],
                    ),
                    Expanded(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: ButtonTheme(
                            height: 30.0,
                            child: RaisedButton(
                              onPressed: () {

                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color.fromRGBO(239, 121, 57, 1),
                              child: Text("Delivary in 2-7 days", style: TextStyle(
                                  color: Colors.white
                              ),
                              ),
                              elevation: 0.0,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 135.0,
                child: Container(
                  margin: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: FutureBuilder<CategoryModel>(
                      future: _homeRepository.getCategory(),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (!snapshot.hasData) {
                          return Center(
                            child:
                            CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 121, 57, 1)),
                            ),
                          );
                        }
                        else if (snapshot.hasData) {
                          return Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context,int index){
                                    return InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        margin: EdgeInsets.only(right: _minimumPadding),
                                        child: Image.network(
                                            'http://139.59.91.150:3333/uploads/' +
                                                snapshot.data.data[index].image,
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    );
                                  }
                              )
                          );
                        }
                        else {
                          return Container();
                        }
                      }
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding*2,
                    bottom: _minimumPadding*2,
                    left: _minimumPadding *2,
                    right: _minimumPadding*2
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Text("Domestic Services  ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    )
                    ),
                    Image.asset('images/gdp.png', height: 20.0, alignment: Alignment.topLeft,)
                  ],
                ),
              ),
              SizedBox(
                height: 135.0,
                child: Container(
                  margin: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: FutureBuilder<CategoryModel>(
                      future: _homeRepository.getCategory(),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (!snapshot.hasData) {
                          return Center(
                            child:
                            CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 121, 57, 1)),
                            ),
                          );
                        }
                        else if (snapshot.hasData) {
                          return Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context,int index){
                                    return InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        margin: EdgeInsets.only(right: _minimumPadding),
                                        child: Image.network(
                                            'http://139.59.91.150:3333/uploads/' +
                                                snapshot.data.data[index].image,
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    );
                                  }
                              )
                          );
                        }
                        else {
                          return Container();
                        }
                      }
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: _minimumPadding*2,
                    bottom: _minimumPadding*2,
                    left: _minimumPadding *2,
                    right: _minimumPadding*2
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Text("Offers  ", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    )
                    ),
                    Image.asset('images/price-tag.png', height: 20.0, alignment: Alignment.topLeft,)
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  height: 150.0,
                  child: CarouselSlider(
                      items: [
                        Image.asset('images/coupon1.png',fit: BoxFit.fill),
                        Image.asset('images/coupon2.png',fit: BoxFit.fill),
                        Image.asset('images/coupon3.png', fit: BoxFit.fill),
                      ],
                      options: CarouselOptions(
                        height: 140.0,
                        aspectRatio: 16/9,
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
                      )
                  )
                ),
            ],
          ),
        )
    );
  }
}
