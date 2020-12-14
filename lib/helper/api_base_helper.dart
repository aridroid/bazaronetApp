import 'dart:developer';
import 'dart:io';
import 'package:bazaronet_fresh/ProductDetailPage/Model/AddToCartModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

import 'app_exceptions.dart';

class ApiBaseHelper {
  static String _baseUrl = "http://139.59.91.150:3333/";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> getWithHeader(String url, String token) async {
    //print('Api Post, url $_baseUrl+url');
    print(_baseUrl + url);
    print('Api token, token $token');
    var responseJson;
    try {
      final response =
          await http.get(_baseUrl + url, headers: {"token": token});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }

  Future<dynamic> post(String url, Map body) async {
    print('Api Post, url $url');
    log(jsonEncode(body));
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> postD(String url, Map map) async {
    log("Product3:"+jsonEncode(map));
    log(map.toString());
    print("incep");


    print("bhul");
    var body = json.encode(map);

    var response = await http.post(_baseUrl + url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
   var  responseJson = _returnResponse(response);
    print("kano");
    print("${response.statusCode}");
    print("${response.body}");
    return responseJson;
    ///////////////////

  /*  print('Api Post, url $url');



  // log(jsonEncode(body));
    var body = jsonEncode(map);
    AddToCartModel responseJson;
    try {
      print("ari");
      Response response = await http.post(_baseUrl + url, headers: {
        "Accept": "Content-Type application/json",
      }, body: body);

      print("samiran");
      print(response.body.toString());

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson*/;
  }

  Future<dynamic> postWithHeader(String url, Map body, String token) async {
    //print('Api Post, url $_baseUrl+url');
    print(_baseUrl + url);
    log(jsonEncode(body));
    print(token);
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          body: jsonEncode(body),
          headers: {
            "Authorization": token,
            "Content-Type": "application/json"
          });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }

  Future<dynamic> deleteWithHeader(String url, String token) async {
    print(_baseUrl + url);
    print('Api token, token $token');
    var responseJson;
    try {
      final response =
      await http.delete(_baseUrl + url, headers: {"token": token});
      if(response.statusCode == 200){
        responseJson = "Success";
      }
      // responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 201:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
