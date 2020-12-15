import 'package:bazaronet_fresh/ProfilePage/Model/ProfilePageModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class ProfilePageRepository {

  ApiBaseHelper _helper = ApiBaseHelper();


  Future<ProfilePageModel> getProfile(String id) async {
    final response = await _helper.get('api/users/'+id);
    return ProfilePageModel.fromJson(response);
  }

}