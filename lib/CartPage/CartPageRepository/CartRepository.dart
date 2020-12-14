import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UpdateCartModel> updateCartById(Map body, String cartId) async {
    final response = await _helper.put('api/cart/'+cartId, body);
    return UpdateCartModel.fromJson(response);
  }

  Future<CartPageModel> getCartById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await _helper.getWithHeader('api/cart/'+id, token);
    return CartPageModel.fromJson(response);
  }

  Future deleteCartById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await _helper.deleteWithHeader('api/cart/'+id, token);
    return response;
  }

}