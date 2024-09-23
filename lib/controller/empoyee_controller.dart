import 'package:get/get.dart';

import '../models/employee.dart';
import '../service/employee_service.dart';

class EmployeeController extends GetxController {

  List<Employee> employees = [];

  var isLoading = true.obs;
  final EmployeeService employeeService = EmployeeService();


  // Get all employees
  Future<void> fetchEmployees() async {
    try {
      isLoading(true);
      var result = await employeeService.getAllEmployees();
      employees.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Add new employee
  Future<void> addEmployee(Employee employee) async {
    try {
      await employeeService.addEmployee(employee);
      fetchEmployees();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Update employee profile picture
  Future<void> updateProfilePic(int id, String filePath) async {
    try {
      await employeeService.updateProfilePicture(id, filePath);
      fetchEmployees(); // Refresh the list
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Update employee data
  Future<void> updateEmployee(int? id, Employee employee) async {
    try {
      await employeeService.updateEmployee(id!, employee);
      fetchEmployees(); // Refresh the list
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete employee
  Future<void> deleteEmployee(int id) async {
    try {
      await employeeService.deleteEmployee(id);
      fetchEmployees(); // Refresh the list
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
