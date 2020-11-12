import 'dart:async';
import 'package:bazaronet_fresh/AddressPage/AddressModel/SaveAddressModel.dart';
import 'package:bazaronet_fresh/AddressPage/AddressRepository/AddressRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class AddressBloc {
  AddressRepository _addressRepository;

  StreamController _addressController;

  StreamSink<ApiResponse<SaveAddressModel>> get addressSink =>
      _addressController.sink;

  Stream<ApiResponse<SaveAddressModel>> get addressStream =>
      _addressController.stream;

  AddressBloc() {
    _addressController = StreamController<ApiResponse<SaveAddressModel>>.broadcast();
    _addressRepository = AddressRepository();

  }

  saveAddress(Map body) async {
    print("body");
    print(body);
    addressSink.add(ApiResponse.loading('Submitting'));
    try {
      SaveAddressModel addressModel = await _addressRepository.saveAddress(body);
      addressSink.add(ApiResponse.completed(addressModel));
    } catch (e) {
      addressSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _addressController?.close();
    addressSink.close();
  }
}
