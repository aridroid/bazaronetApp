import 'package:bazaronet_fresh/HomePage/Model/BannerModel.dart';
import 'package:bazaronet_fresh/HomePage/Model/CategoryModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class HomeRepository {

  ApiBaseHelper _helper = ApiBaseHelper();


  Future<BannerModel> getBannerData() async {
    final response = await _helper.get('api/banner');
    return BannerModel.fromJson(response);
  }

  Future<CategoryModel> getCategory() async {
    final response = await _helper.get('api/category');
    return CategoryModel.fromJson(response);
  }
}