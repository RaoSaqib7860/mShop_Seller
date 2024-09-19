import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';
import 'package:mShop_Seller/view/screens/LoginPages/login_screen.dart';

import '../../../utils_services/colors_util.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool loading = false;
  bool active_email_logo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Email Verification'.tr,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
          )),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(active_email_logo ? 40 : 80),
                    height: height / 3,
                    width: width,
                    child: active_email_logo
                        ? Image.asset(
                            'assets/image/email_sent.gif',
                          )
                        : Image.asset(
                            'assets/image/error.gif',
                          ),
                  ),
                  Text(
                      'Please verify your email by visiting the link we sent you at your email address'
                          .tr,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.segoeui),
                      textAlign: TextAlign.center),
                  SizedBox(height: 5),
                  Text(
                      'If you don\'t have one, resend the verification link by clicking the Resend Button'
                          .tr,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppFonts.segoeui,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black54
                                  : Colors.white),
                      textAlign: TextAlign.center),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () async {
                      loading = true;
                      setState(() {});
                      await DataProvider.auth_resend_code({
                        'email': user_model.user!.email,
                        'verify_by': 'email'
                      });
                      loading = false;
                      active_email_logo = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 4), () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                      });
                    },
                    child: Container(
                      height: height * 0.050,
                      width: width / 2,
                      child: Center(
                          child: Text(
                        'Resend Verification Link'.tr,
                        style: TextStyle(
                            color: Colors.white, fontFamily: AppFonts.segoeui),
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? blueGrey
                                  : Colors.black),
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              height: height,
              width: width),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
