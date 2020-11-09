import 'package:bazaronet_fresh/LoginPage/LoginModel/LoginModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class LoginRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<LoginModel> login(Map body) async {
    final response = await _helper.post('api/login',body);
    return LoginModel.fromJson(response);
  }


}