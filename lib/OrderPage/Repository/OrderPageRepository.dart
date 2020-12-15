import 'package:bazaronet_fresh/OrderPage/Model/OrderPageModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPageRepository {

  ApiBaseHelper _helper = ApiBaseHelper();


  Future<OrderPageModel> getOrders(String id, String token) async {
    final response = await _helper.getWithHeader('api/order-one/'+id, token);
    return OrderPageModel.fromJson(response);
  }

}