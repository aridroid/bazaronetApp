import 'dart:async';
import 'package:bazaronet_fresh/SignupPage/SignupModel/SignupModel.dart';
import 'package:bazaronet_fresh/SignupPage/SignupRepository/SignupRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';
import 'package:bazaronet_fresh/helper/movie_response.dart';


class SignupBloc {
  SignUpRepository _signUpRepository;

  StreamController _signUpController;

  StreamSink<ApiResponse<SignUpModel>> get signupSink =>
      _signUpController.sink;

  Stream<ApiResponse<SignUpModel>> get signUpStream =>
      _signUpController.stream;

  SignupBloc() {
    _signUpController = StreamController<ApiResponse<SignUpModel>>();
    _signUpRepository = SignUpRepository();

  }

  signUp(Map body) async {
    print("body");
    print(body);
    signupSink.add(ApiResponse.loading('Submitting'));
    try {
      SignUpModel signUpModel = await _signUpRepository.signUp(body);
      signupSink.add(ApiResponse.completed(signUpModel));
    } catch (e) {
      signupSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _signUpController?.close();
  }
}
