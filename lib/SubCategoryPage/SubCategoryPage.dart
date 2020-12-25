import 'package:bazaronet_fresh/ProductDetailPage/ProductDetailPage.dart';
import 'package:bazaronet_fresh/ProductDetailPage/ServiceDetailPage.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart' as ProductData;
import 'package:bazaronet_fresh/SubCategoryPage/Model/SubCategoryModel.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Repository/SubCategoryRepository.dart';
import 'package:flutter/material.dart';

class SubCategoryPage extends StatefulWidget {
  String id;

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();

  SubCategoryPage({this.id}) {
    print("IDD:"+this.id);
  }
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  double _minimumPadding = 5.0;
  SubCategoryRepository _subCategoryRepository;
  int discount = 0;
  Color orangeTheme = Color.fromRGBO(239, 121, 57, 1);
  @override
  void initState() {
    _subCategoryRepository = SubCategoryRepository();
  }

  calculateDiscount(ProductData.Data data) {
    double discount2 = (1 - data.variant[0].price/data.variant[0].actualPrice)*100;
    discount = discount2.round();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SubCategoryModel>(
      future: _subCategoryRepository.getSubCategory(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                orangeTheme
                  ),
            ),
          );
        } else {
          if (snapshot.data.data.length > 0) {
            return DefaultTabController(
                length: snapshot.data.data.length,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color.fromRGBO(239, 121, 57, 1),
                      title: Container(
                        child: Row(
                          children: [
                            Image.asset('images/logo.png', width: 150.0)
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: null)
                      ],
                      elevation: 0.0,
                      bottom: TabBar(
                        labelColor: Color.fromRGBO(239, 121, 57, 1),
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.white,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            color: Colors.white
                        ),
                        tabs: snapshot.data.data.map((e) {
                          return Container(
                            padding: EdgeInsets.only(bottom: _minimumPadding*2, top: _minimumPadding*2),
                            child: Text(
                              e.name, style: TextStyle(
                                fontSize: 15.0
                            ),
                            ),
                          );
                        }).toList(),
                        isScrollable:
                        snapshot.data.data.length > 2 ? true : false,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(239, 121, 57, 1),
                    body: TabBarView(
                      children: snapshot.data.data.map((e) {
                        print("Sub-Cat-Id:"+e.sId);
                        return FutureBuilder<ProductData.ProductModel>(
                            future: _subCategoryRepository.getProductBySubCategory(e.sId),
                            builder: (context, snapshot2) {
                              if (!snapshot2.hasData) {
                                print("Snapshot 1");
                                print(snapshot2);
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0)),
                                        color: Colors.white),
                                    child: Card(
                                        clipBehavior: Clip.hardEdge,
                                        color: Colors.white70,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                                        ),
                                        child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        orangeTheme
                                  ),
                                )
                                )
                              )
                              );
                              }
                              else {
                                print("Snapshot 2");
                                print(snapshot2);
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)),
                                      color: Colors.white),
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.white70,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.only(
                                              top: _minimumPadding,
                                              bottom: _minimumPadding,
                                              right: _minimumPadding),
                                          margin:
                                          EdgeInsets.only(bottom: _minimumPadding),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(_minimumPadding*2, _minimumPadding, 0, _minimumPadding),
                                              child: Text(
                                                  snapshot2.data.data.length.toString()+" data found",
                                                  style: TextStyle(
                                                    fontSize: 15.0
                                                  ),
                                              )
                                          ),
                                          alignment: Alignment.topLeft,
                                        ),
                                        Expanded(
                                            child: ListView.builder(
                                                itemCount: snapshot2.data.data.length,
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  calculateDiscount(snapshot2.data.data[index]);
                                                  return InkWell(
                                                    onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) =>
                                                                productdetails(data: snapshot2.data.data[index]))
                                                        );
                                                    },
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
                                                                            snapshot2.data.data[index].image[0]),
                                                                    fit: BoxFit.fill,

                                                                  )),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  top: _minimumPadding *
                                                                      2,
                                                              bottom: _minimumPadding*2,
                                                              left: _minimumPadding),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                      snapshot2.data.data[index].name.length > 19 ?
                                                                      '${snapshot2.data.data[index].name.substring(0,19)}...': snapshot2.data.data[index].name,
                                                                      style: TextStyle(
                                                                        fontSize: 15.0
                                                                      ),
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
                                                                      Text("Rs."+snapshot2.data.data[index].variant[0].price.toString()+" ",
                                                                        style: TextStyle(
                                                                            fontSize: 15.0,),
                                                                      ),
                                                                      Text("Rs."+snapshot2.data.data[index].variant[0].actualPrice.toString(), style: TextStyle(
                                                                          decoration: TextDecoration.lineThrough,
                                                                        color: Colors.grey,
                                                                        fontSize: 15.0),
                                                                      ),
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
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Spacer(),
                                                                  Row(
                                                                    children: [
                                                                      Text("Sold by ",
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          color: Colors.blue[800],
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                      Text(snapshot2.data.data[index].vendorId.name.length > 16 ?
                                                                      '${snapshot2.data.data[index].vendorId.name.substring(0,16)}...': snapshot2.data.data[index].vendorId.name,
                                                                        style: TextStyle(
                                                                          fontSize: 15.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Container(
                                                                  padding: EdgeInsets.only(right: _minimumPadding, top: _minimumPadding*2),
                                                                  alignment: Alignment.topRight,
                                                                  child: InkWell(
                                                                    onTap: () {

                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite_border,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                )
                                                            ),
                                                            // Expanded(
                                                            //   child: Stack(
                                                            //     children: [
                                                            //       Positioned(
                                                            //         top: 10,
                                                            //         right: 5,
                                                            //         child: InkWell(
                                                            //           onTap: () {
                                                            //
                                                            //           },
                                                            //           child: Icon(
                                                            //             Icons
                                                            //                 .favorite_border,
                                                            //             color: Colors.grey,
                                                            //           ),
                                                            //         ),
                                                            //       )
                                                            //     ],
                                                            //   ),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }))
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                        );
                      }).toList(),
                    )));
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(239, 121, 57, 1),
                  title: Container(
                    child: Row(
                      children: [Image.asset('images/logo.png', width: 150.0)],
                    ),
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: null)
                  ],
                  elevation: 0.0,
                ),
                backgroundColor: Color.fromRGBO(239, 121, 57, 1),
                body: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)),
                    color: Colors.white70),
                    child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.white70,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                        ),
                    child: ListView()
                    )
                  )
                );
      }
      }
      },
    );
  }
}
