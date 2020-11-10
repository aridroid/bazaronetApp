
import 'package:bazaronet_fresh/ProductDetailPage/Model/AddToCartModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class AddToCartRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddToCartModel> addToCart(Map body) async {
    final response = await _helper.post('api/cart',body);
    return AddToCartModel.fromJson(response);
  }


}