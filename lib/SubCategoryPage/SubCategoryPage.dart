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
          if(!snapshot.hasData) {
            return Center(
              child:
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(239, 121, 57, 1)),
              ),
            );
          }
          else {
            print("2nd Page");
            print(snapshot);
            return DefaultTabController(
                length: snapshot.data.data.length,
                child: Scaffold(
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
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      tabs: snapshot.data.data.map((e) {
                        return Text(e.name);
                      }
                      ).toList(),
                      isScrollable: snapshot.data.data.length >4 ? true : false,
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
                            child:
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding, right: _minimumPadding),
                                    margin: EdgeInsets.only(bottom: _minimumPadding),
                                    child: Text("350 items found"),
                                    alignment: Alignment.center,
                                  ),

                                ],
                              ),
                            ),
                          )
                      );
                    }).toList(),
                  )
                )
            );
          }
        },
      );
  }
}
