import 'package:bazaronet_fresh/AddressPage/AddressModel/SaveAddressModel.dart';
import 'package:bazaronet_fresh/AddressPage/AddressModel/SelectAddressModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SaveAddressModel> saveAddress(Map body) async {
    final response = await _helper.post('api/address', body);
    return SaveAddressModel.fromJson(response);
  }

  Future<SelectAddressModel> getAddress(String id, String token) async {
    final response = await _helper.getWithHeader('api/address/'+id, token);
    return SelectAddressModel.fromJson(response);
  }

}