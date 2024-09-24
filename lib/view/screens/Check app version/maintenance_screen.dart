import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
        centerTitle: true,
        // leading: InkWell(
        //     onTap: (){
        //       Navigator.of(context).pop();
        //     },
        //     child: Icon(Icons.arrow_back_ios,color: Colors.black)),
        // title: Text(
        //   'Maintenance'.tr,
        //   style: TextStyle(
        //     fontSize: 16,
        //     color: Theme.of(context).brightness == Brightness.light
        //         ? Colors.black
        //         : Colors.white,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/maintenance.png'),
              SizedBox(height: 2.h,),
              Text('We will be back soon',style: TextStyle(fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}
