import 'package:employee_mn_system/controller/auth_controller.dart';
import 'package:employee_mn_system/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => Container(
          width: _deviceWidth,
          height: _deviceHeight,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.crimson,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _textFormFields(),
                SizedBox(
                  height: _deviceHeight * 0.09,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.login(usernameController.text, passwordController.text);
                    }
                  },
                  child: const Text('Login',style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormFields(){
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }
}
