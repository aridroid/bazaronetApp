import 'package:bazaronet_fresh/ProductDetailPage/ProductDetailPage.dart';
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
          print("2nd Page");
          print(snapshot);
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
                        indicatorColor: Colors.white,
                        tabs: snapshot.data.data.map((e) {
                          return Text(e.name);
                        }).toList(),
                        isScrollable:
                        snapshot.data.data.length > 4 ? true : false,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(239, 121, 57, 1),
                    body: TabBarView(
                      children: snapshot.data.data.map((e) {
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
                                  child: Text("350 items found"),
                                  alignment: Alignment.center,
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => productdetails()),
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
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                                            image: AssetImage(
                                                                'images/diapers.jpg'),
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: _minimumPadding *
                                                              2),
                                                      child: Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                                "Pampers Diapers - S 76 Pieces"),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                Text(
                                                                  "  4.2",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .amber),
                                                                ),
                                                                Text(
                                                                    " 125 Reviews")
                                                              ],
                                                            ),
                                                            Text("₹  10.00"),
                                                            Row(
                                                              children: [
                                                                Icon(Icons
                                                                    .directions_car_sharp),
                                                                Text(
                                                                    "  Delivery within 2 hours")
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                      Alignment.topRight,
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          onPressed: () {}),
                                                    )
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
