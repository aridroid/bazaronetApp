
import 'package:bazaronet_fresh/ProductDetailPage/Model/AddToCartModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class AddToCartRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddToCartModel> addToCart(Map body) async {
    print("In Repo");
    final response = await _helper.postD('api/cart',body);
    print("response of add cart $response");
    return AddToCartModel.fromJson(response);
  }


}