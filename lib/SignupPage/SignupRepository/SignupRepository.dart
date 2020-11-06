import 'package:bazaronet_fresh/SignupPage/SignupModel/SignupModel.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/ProductModel.dart';
import 'package:bazaronet_fresh/SubCategoryPage/Model/SubCategoryModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class SignUpRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SignUpModel> signUp(Map body) async {
    final response = await _helper.post('api/users',body);
    return SignUpModel.fromJson(response);
  }


}