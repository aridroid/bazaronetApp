import 'dart:async';
import 'package:bazaronet_fresh/ProductDetailPage/Model/AddToCartModel.dart';
import 'package:bazaronet_fresh/ProductDetailPage/Repository/AddToCartRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class ProductDetailBloc {
  AddToCartRepository _addToCartRepository;

  StreamController _productDetailPageController;

  StreamSink<ApiResponse<AddToCartModel>> get productDetailPageSink =>
      _productDetailPageController.sink;

  Stream<ApiResponse<AddToCartModel>> get productDetailPageStream =>
      _productDetailPageController.stream;

  ProductDetailBloc() {
    _productDetailPageController = StreamController<ApiResponse<AddToCartModel>>.broadcast();
    _addToCartRepository = AddToCartRepository();

  }

  addToCart(Map body) async {
    print("body");
    print(body);
    productDetailPageSink.add(ApiResponse.loading('Submitting'));
    try {
      AddToCartModel addToCartModel = await _addToCartRepository.addToCart(body);
      productDetailPageSink.add(ApiResponse.completed(addToCartModel));
    } catch (e) {
      productDetailPageSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _productDetailPageController?.close();
    productDetailPageSink.close();
  }
}
