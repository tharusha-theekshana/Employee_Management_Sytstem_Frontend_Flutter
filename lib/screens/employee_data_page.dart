import 'package:employee_mn_system/screens/add_empoloyee_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/empoyee_controller.dart';

class EmployeeDataPage extends StatefulWidget {

  @override
  State<EmployeeDataPage> createState() => _EmployeeDataPageState();
}

class _EmployeeDataPageState extends State<EmployeeDataPage> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeController.fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddEmployeePage());
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (employeeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (employeeController.employees.isEmpty) {
          return const Center(child: Text('No employees found'));
        } else {
          return Center(
            child: Container(
              width: _deviceWidth * 0.6,
              child: ListView.builder(
                itemCount: employeeController.employees.length,
                itemBuilder: (context, index) {
                  final employee = employeeController.employees[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(AddEmployeePage(employee: employee));
                    },
                    child: ListTile(
                      title: Text('${employee.firstName} ${employee.lastName}'),
                      subtitle: Text(employee.email),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          employeeController.deleteEmployee(employee.id!);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
