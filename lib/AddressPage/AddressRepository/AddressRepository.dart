import 'package:bazaronet_fresh/AddressPage/AddressModel/SaveAddressModel.dart';
import 'package:bazaronet_fresh/helper/api_base_helper.dart';

class AddressRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<SaveAddressModel> saveAddress(Map body) async {
    final response = await _helper.post('api/address', body);
    return SaveAddressModel.fromJson(response);
  }

}