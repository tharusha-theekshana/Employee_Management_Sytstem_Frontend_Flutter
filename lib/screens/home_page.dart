import 'package:employee_mn_system/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: Center(
        child: Text("Employee Management System Home Screen"),
      ),
    );
  }
}
