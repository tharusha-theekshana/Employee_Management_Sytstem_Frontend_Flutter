import 'dart:convert';

import 'package:employee_mn_system/screens/login_page.dart';
import 'package:employee_mn_system/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  var username = ''.obs;
  var email = ''.obs;
  var roles = <String>[].obs;
  final AuthService authService = Get.put(AuthService());

  Future<void> login(String userName,String password) async {
    await authService.login(userName, password);
  }

  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userData = pref.getString('userData'); // Adjust this key to match your app
    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      username.value = userMap['username'];
      email.value = userMap['email'];
      roles.value = List<String>.from(userMap['roles']);
    }
  }

  void logout() async {
    Get.offAll(LoginPage());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}