import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class CartRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  // Future<CartPageModel> addToCart(Map body) async {
  //   final response = await _helper.post('api/cart',body);
  //   return CartPageModel.fromJson(response);
  // }

  Future<CartPageModel> getCartById(String id) async {
    final response = await _helper.get('api/cart/'+id);
    return CartPageModel.fromJson(response);
  }

}