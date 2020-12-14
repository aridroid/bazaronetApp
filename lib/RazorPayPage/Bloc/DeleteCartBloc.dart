import 'dart:async';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/RazorPayPage/Repository/RazorPayRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class DeleteCartBloc {
  RazorPayRepository _razorPayRepository;

  // ignore: close_sinks
  StreamController _razorPayController;

  StreamSink<ApiResponse> get razorPaySink =>
      _razorPayController.sink;

  Stream<ApiResponse> get razorPayStream =>
      _razorPayController.stream;

  DeleteCartBloc() {
    _razorPayController = StreamController<ApiResponse>.broadcast();
    _razorPayRepository = RazorPayRepository();

  }

  deleteCartIds(Map ids) async {
    razorPaySink.add(ApiResponse.loading('Submitting'));
    try {
      var updateCartModel = await _razorPayRepository.deleteCartByIds(ids);
      razorPaySink.add(ApiResponse.completed(updateCartModel));
    } catch (e) {
      razorPaySink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _razorPayController?.close();
    razorPaySink.close();
  }
}
