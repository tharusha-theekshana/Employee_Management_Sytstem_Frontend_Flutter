import 'dart:convert';

import 'package:employee_mn_system/controller/auth_controller.dart';
import 'package:employee_mn_system/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDataPage extends StatefulWidget {
  @override
  State<ProfileDataPage> createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {

  final AuthController authController = Get.put(AuthController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getUserData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('Username: ${authController.username.value}', style: TextStyle(fontSize: 18))),
            Obx(() => Text('Email: ${authController.email.value}', style: TextStyle(fontSize: 18))),
            Obx(() => Text('Roles: ${authController.roles.join(', ')}', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}
