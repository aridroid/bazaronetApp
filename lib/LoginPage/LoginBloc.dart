import 'dart:async';
import 'package:bazaronet_fresh/LoginPage/LoginModel/LoginModel.dart';
import 'package:bazaronet_fresh/LoginPage/LoginRepository/LoginRepository.dart';
import 'package:bazaronet_fresh/helper/api_response.dart';


class LoginBloc {
  LoginRepository _loginRepository;

  StreamController _loginController;

  StreamSink<ApiResponse<LoginModel>> get loginSink =>
      _loginController.sink;

  Stream<ApiResponse<LoginModel>> get loginStream =>
      _loginController.stream;

  LoginBloc() {
    _loginController = StreamController<ApiResponse<LoginModel>>.broadcast();
    _loginRepository = LoginRepository();

  }

  login(Map body) async {
    print("body");
    print(body);
    loginSink.add(ApiResponse.loading('Submitting'));
    try {
      LoginModel loginModel = await _loginRepository.login(body);
      loginSink.add(ApiResponse.completed(loginModel));
    } catch (e) {
      loginSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _loginController?.close();
    loginSink.close();
  }
}
