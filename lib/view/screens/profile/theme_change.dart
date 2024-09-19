import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/view/screens/profile/profile_menu.dart';

import '../../../extentions/app_colors.dart';
import '../../../main.dart';
import '../../global_widgets/AppSize.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {

  bool _value = false;
  bool _valuee = false;
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor,
        title: Text(
          'Theme Change'.tr,
          style: TextStyle(color: AppColors.allButtonColor),
        ),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileMenu(),));
            },
            child: Icon(Icons.arrow_back,color: AppColors.allButtonColor,)),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: width * 0.03,right: width * 0.03),
        child: Column(
          children: [
            Container(
              height: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Theme'.tr,
                    style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.05),
                  ),
                  Switch(
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        if (_value == true)
                          MyApp.of(context)!.changeTheme(ThemeMode.dark);
                        else
                          MyApp.of(context)!.changeTheme(ThemeMode.light);
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                var locale = Locale('en', 'US');
                Get.updateLocale(locale);
              },
              child: Row(
                children: [
                  Text(
                    'English',
                    style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.05),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                var locale = Locale('ar', 'IQ');
                Get.updateLocale(locale);
              },
              child: Row(
                children: [
                  Text(
                    'العربية ',
                    style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.05),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
