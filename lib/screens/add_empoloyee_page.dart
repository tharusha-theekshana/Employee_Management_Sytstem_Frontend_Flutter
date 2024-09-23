import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/empoyee_controller.dart';
import '../models/employee.dart';

class AddEmployeePage extends StatefulWidget {
  final Employee? employee;

  AddEmployeePage({this.employee});

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {

  final EmployeeController employeeController = Get.put(EmployeeController());
  late double _deviceHeight, _deviceWidth;

  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String birthday = '';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.employee != null){
      firstNameController.text = widget.employee!.firstName;
      lastNameController.text = widget.employee!.lastName;
      emailController.text = widget.employee!.email;
      birthdayController.text = widget.employee!.birthday;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newEmployee = Employee(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        birthday: birthdayController.text,
      );
      widget.employee != null ? employeeController.updateEmployee(widget.employee!.id, newEmployee) : employeeController.addEmployee(newEmployee);
    }
  }

  final RegExp dateRegExp = RegExp(r'^(19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$',);

  final RegExp emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Center(
        child: Container(
          width: kIsWeb ? _deviceWidth * 0.5 : _deviceWidth * 0.9,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: _deviceHeight * 0.01,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  controller: firstNameController,
                ),
                SizedBox(height: _deviceHeight * 0.01,),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                  controller: lastNameController,
                ),
                SizedBox(height: _deviceHeight * 0.01,),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !emailReg.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(height: _deviceHeight * 0.01,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Birthday (YYYY-MM-DD)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter birthday';
                    }else if(!dateRegExp.hasMatch(value)){
                      return 'Birthday is not valid format';
                    }
                    return null;
                  },
                  controller: birthdayController,
                ),
                SizedBox(height: _deviceHeight * 0.05,),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: widget.employee !=null ? Text("Update Employee") : Text('Add Employee'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}