import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bazaronet_fresh/RazorPayPage/Model/AddOrderProductModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';
import 'package:bazaronet_fresh/helper/app_exceptions.dart';
import 'package:http/http.dart' as http;

class RazorPayRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddOrderProductModel> addToOrder(Map body) async {
    print("In Repo");
    final response = await _helper.postD('api/order', body);
    // print("response of add cart $response");
    return AddOrderProductModel.fromJson(response);
  }

  Future deleteCartByIds(Map ids) async {
    print("In Repo");
    log(jsonEncode(ids));
    String _baseUrl = "http://139.59.91.150:3333/";
    var responseJson;
    try {
      final response = await http.post(_baseUrl + 'api/cart/delete-all',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(ids));
      if(response.statusCode == 200){
        print("Status Code:"+response.statusCode.toString());
        responseJson = "Success";
      }
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

}