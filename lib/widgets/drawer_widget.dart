import 'package:employee_mn_system/screens/employee_data_page.dart';
import 'package:employee_mn_system/screens/profile_data_page.dart';
import 'package:employee_mn_system/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  late double _deviceWidth,_deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: kIsWeb ? _deviceWidth * 0.3 : _deviceWidth * 0.7,
      child: ListView(
        children: <Widget>[
          const DrawerHeader(child: Text('Employee Management System',style: TextStyle(
              fontSize: 20.0,
              color: AppColors.crimson,
              fontWeight: FontWeight.bold
          ),textAlign: TextAlign.center,)),
          _listTile("Profile", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileDataPage();
            }));
          }),
          _listTile("Employees", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EmployeeDataPage();
            }));
          }),
        ],
      ),
    );
  }

  Widget _listTile(String name, Function() onTap){
    return ListTile(
        title: Text(name.toString()),
        onTap: onTap
    );
  }
}
