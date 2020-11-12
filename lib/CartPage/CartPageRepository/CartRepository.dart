import 'package:bazaronet_fresh/CartPage/CartPageModel/CartPageModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class CartRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UpdateCartModel> updateCartById(Map body, String cartId) async {
    final response = await _helper.put('api/cart/'+cartId, body);
    return UpdateCartModel.fromJson(response);
  }

  Future<CartPageModel> getCartById(String id) async {
    final response = await _helper.get('api/cart/'+id);
    return CartPageModel.fromJson(response);
  }

  // Future delete(String id) async {
  //   final response = await _helper.delete('api/cart/'+id);
  //   return (response);
  // }


}