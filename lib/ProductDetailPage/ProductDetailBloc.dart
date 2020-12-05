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
    print("In Bloc");
    productDetailPageSink.add(ApiResponse.loading('Submitting'));
    try {
      print("In Try");
      AddToCartModel addToCartModel = await _addToCartRepository.addToCart(body);
      productDetailPageSink.add(ApiResponse.completed(addToCartModel));
    } catch (e) {
      print("In Catch");
      productDetailPageSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _productDetailPageController?.close();
    productDetailPageSink.close();
  }
}
