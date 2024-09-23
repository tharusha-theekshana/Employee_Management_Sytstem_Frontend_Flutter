import 'dart:convert';
import 'package:employee_mn_system/environment/env_data.dart';
import 'package:employee_mn_system/screens/employee_data_page.dart';
import 'package:employee_mn_system/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';

class EmployeeService {
  final String baseUrl = EnvData.baseUrl+EnvData.employee;

  var token = '';

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppStrings.token) ?? '';
  }

  // Fetch all employees
  Future<List<Employee>> getAllEmployees() async {
    await loadToken();

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      List<dynamic> body = responseBody['data'];
      return body.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  // Save a new employee
  Future<void> addEmployee(Employee employee) async {
    await loadToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'firstName': employee.firstName,
        'lastName': employee.lastName,
        'email': employee.email,
        'birthday': employee.birthday,
      }),
    );

    if (response.statusCode == 201) {
      Get.snackbar('Success','Employee add Successfully !');
      Get.to(EmployeeDataPage());
    } else {
      throw Exception('Failed to save employee');
    }
  }

  // Update employee profile picture
  Future<void> updateProfilePicture(int id, String filePath) async {
    await loadToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/uploadProfilePic/$id'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile picture');
    }
  }

  // Update employee data
  Future<void> updateEmployee(int id, Employee employee) async {
    await loadToken();

    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'firstName': employee.firstName,
        'lastName': employee.lastName,
        'email': employee.email,
        'birthday': employee.birthday,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success','Employee updated Successfully !');
      Get.to(EmployeeDataPage());
    } else {
      throw Exception('Failed to update employee');
    }
  }

  // Delete employee (Admin only)
  Future<void> deleteEmployee(int id) async {
    await loadToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete employee');
    }else{
      Get.snackbar('Success','Employee deleted Successfully !');
    }
  }

}
