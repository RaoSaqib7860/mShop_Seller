import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back,color: Colors.black)),
        title: Text(
          'Change Password'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 4.h,),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Current Password'.tr),
              ),
              subtitle: Container(
                height: 7.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      //color: const Color(0x290bab0d),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextFormField(

                  decoration: InputDecoration(
                    suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
                      labelText: 'Please enter your current password'.tr,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('New Password'.tr),
              ),
              subtitle: Container(
                height: 7.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      //color: const Color(0x290bab0d),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
                      labelText: '   Please enter your new password'.tr,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),

                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Container(
              height: 6.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.deepPurple,
              ),
              child: Center(
                child: Text('Submit'.tr,style: TextStyle(color: Colors.white,fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
