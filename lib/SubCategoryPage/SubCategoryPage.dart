import 'package:bazaronet_fresh/ProductDetailPage/ProductDetailPage.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/SubCategoryModel.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Repository/SubCategoryRepository.dart';
import 'package:flutter/material.dart';

class SubCategoryPage extends StatefulWidget {
  String id;

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();

  SubCategoryPage({this.id}) {
    print(this.id);
  }
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  double _minimumPadding = 5.0;
  SubCategoryRepository _subCategoryRepository;

  @override
  void initState() {
    _subCategoryRepository = SubCategoryRepository();
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
                  Color.fromRGBO(239, 121, 57, 1)),
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
                                fontWeight: FontWeight.bold,
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
                        return FutureBuilder<ProductModel>(
                            future: _subCategoryRepository.getProductBySubCategory(e.sId),
                            builder: (context, snapshot2) {
                              if (!snapshot2.hasData) {
                                print("Snapshot 1");
                                print(snapshot2);
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        Color.fromRGBO(255, 241, 232, 1),
                                  ),
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
                                      color: Color.fromRGBO(255, 241, 232, 1)),
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    color: Color.fromRGBO(255, 241, 232, 1),
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
                                          child: Text(snapshot2.data.data.length.toString()+" data found"),
                                          alignment: Alignment.center,
                                        ),
                                        Expanded(
                                            child: ListView.builder(
                                                itemCount: snapshot2.data.data.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => productdetails(
                                                          data: snapshot2.data.data[index],
                                                        )),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100.0,
                                                      margin: EdgeInsets.only(
                                                          bottom: _minimumPadding,
                                                          left: _minimumPadding,
                                                          right: _minimumPadding),
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
                                                              margin: EdgeInsets.only(
                                                                  right:
                                                                  _minimumPadding),
                                                              width:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width *
                                                                  0.3,
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
                                                              bottom: _minimumPadding*2),
                                                              child: Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                        snapshot2.data.data[index].name.length > 25 ?
                                                                        '${snapshot2.data.data[index].name.substring(0,24)}...': snapshot2.data.data[index].name,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 18.0
                                                                    ),),
                                                                    Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.star,
                                                                          color: Color.fromRGBO(239, 121, 57, 1),
                                                                          size: 15.0,
                                                                        ),
                                                                        Text(
                                                                          "  4.2",
                                                                          style: TextStyle(
                                                                              color: Color.fromRGBO(239, 121, 57, 1),
                                                                          fontSize: 12.0,
                                                                              fontStyle: FontStyle.italic),
                                                                        ),
                                                                        Text(
                                                                            " 125 Reviews",
                                                                        style: TextStyle(
                                                                          fontSize: 12.0,
                                                                          fontStyle: FontStyle.italic
                                                                        ),)
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        Text("Rs."+snapshot2.data.data[index].actualPrice.toString()+" ",
                                                                          style: TextStyle(
                                                                              color: Color.fromRGBO(239, 121, 57, 1),
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.bold),),
                                                                        Text(" Rs."+snapshot2.data.data[index].price.toString(), style: TextStyle(
                                                                            decoration: TextDecoration.lineThrough,
                                                                          color: Colors.grey,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 12.0
                                                                        ),),
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    Row(
                                                                      children: [
                                                                        Text("Delivery within 2 hours",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.0
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Container(
                                                                  alignment: Alignment.topRight,
                                                                  child: IconButton(
                                                                      alignment: Alignment.topRight,
                                                                      icon: Icon(
                                                                        Icons
                                                                            .favorite_border,
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                      onPressed: () {}),
                                                                )
                                                            ),
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
                    color: Color.fromRGBO(255, 241, 232, 1)),
                    child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: Color.fromRGBO(255, 241, 232, 1),
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
