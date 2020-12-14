import 'dart:async';
import 'package:bazaronet_fresh/CartPage/CartPageModel/UpdateCartModel.dart';
import 'package:bazaronet_fresh/CartPage/CartPageRepository/CartRepository.dart';
import 'package:bazaronet_fresh/RazorPayPage/Model/AddOrderProductModel.dart';
import 'package:bazaronet_fresh/RazorPayPage/Repository/RazorPayRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class RazorPayBloc {
  RazorPayRepository _razorPayRepository;

  StreamController _razorPayController;

  StreamSink<ApiResponse<AddOrderProductModel>> get razorPaySink =>
      _razorPayController.sink;

  Stream<ApiResponse<AddOrderProductModel>> get razorPayStream =>
      _razorPayController.stream;

  RazorPayBloc() {
    _razorPayController = StreamController<ApiResponse<AddOrderProductModel>>.broadcast();
    _razorPayRepository = RazorPayRepository();

  }

  addOrder(Map body) async {
    print("body");
    print(body);
    razorPaySink.add(ApiResponse.loading('Submitting'));
    try {
      AddOrderProductModel addOrderProductModel = await _razorPayRepository.addToOrder(body);
      razorPaySink.add(ApiResponse.completed(addOrderProductModel));
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
