import 'dart:async';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class DeleteProductBloc {
  CartRepository _cartRepository;

  // ignore: close_sinks
  StreamController _deleteProductController;

  StreamSink<ApiResponse> get deleteProductSink =>
      _deleteProductController.sink;

  Stream<ApiResponse> get deleteProductStream =>
      _deleteProductController.stream;

  DeleteProductBloc() {
    _deleteProductController = StreamController<ApiResponse>.broadcast();
    _cartRepository = CartRepository();

  }

  deleteCartById(String cartId) async {
    deleteProductSink.add(ApiResponse.loading('Submitting'));
    try {
      var updateCartModel = await _cartRepository.deleteCartById(cartId);
      deleteProductSink.add(ApiResponse.completed(updateCartModel));
    } catch (e) {
      deleteProductSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _deleteProductController?.close();
    deleteProductSink.close();
  }
}
