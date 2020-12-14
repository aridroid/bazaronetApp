import 'dart:async';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class CartBloc {
  CartRepository _cartRepository;

  StreamController _cartPageController;

  StreamSink<ApiResponse<UpdateCartModel>> get cartPageSink =>
      _cartPageController.sink;

  Stream<ApiResponse<UpdateCartModel>> get cartPageStream =>
      _cartPageController.stream;

  CartBloc() {
    _cartPageController = StreamController<ApiResponse<UpdateCartModel>>.broadcast();
    _cartRepository = CartRepository();

  }

  updateCartById(Map body, String cartId) async {
    print("body");
    print(body);
    cartPageSink.add(ApiResponse.loading('Submitting'));
    try {
      UpdateCartModel updateCartModel = await _cartRepository.updateCartById(body, cartId);
      cartPageSink.add(ApiResponse.completed(updateCartModel));
    } catch (e) {
      cartPageSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  // deleteCartById(String cartId) async {
  //   print("bloc");
  //   cartPageSink.add(ApiResponse.loading('Submitting'));
  //   try {
  //     UpdateCartModel updateCartModel = await _cartRepository.delete(cartId);
  //     cartPageSink.add(ApiResponse.completed(updateCartModel));
  //   } catch (e) {
  //     cartPageSink.add(ApiResponse.error(e.toString()));
  //     print(e);
  //   }
  // }

  dispose() {
    _cartPageController?.close();
    cartPageSink.close();
  }
}
