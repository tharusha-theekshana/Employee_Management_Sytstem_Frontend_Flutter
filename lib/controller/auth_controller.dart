import 'package:employee_mn_system/service/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  AuthService authService = AuthService();

  Future<void> login(String userName,String password) async {
    await authService.login(userName, password);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}