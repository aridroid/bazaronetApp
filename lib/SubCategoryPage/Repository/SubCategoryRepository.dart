import 'package:bazaronet_fresh/SubCategoryPage/Model/SubCategoryModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class SubCategoryRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SubCategoryModel> getSubCategory(String id) async {
    final response = await _helper.get('api/sub-category/category/'+id);
    return SubCategoryModel.fromJson(response);
  }
}