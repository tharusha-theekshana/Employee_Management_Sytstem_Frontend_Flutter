import 'package:employee_mn_system/environment/env_data.dart';
import 'package:employee_mn_system/screens/home_page.dart';
import 'package:employee_mn_system/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class AuthService extends GetxController {
  var token = ''.obs;

  Future<void> login(String username, String password) async {

    final url = Uri.parse("${EnvData.baseUrl}${EnvData.auth}/login");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      token.value = responseData['data']["token"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppStrings.token, token.value);

      Get.offAll(const HomePage());
    } else {
      Get.snackbar('Error', 'Login failed. Please try Again.. !');
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? '';
  }
}
