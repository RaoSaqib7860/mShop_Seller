import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils_services/app_font.dart';
import '../../../../utils_services/colors_util.dart';
import '../../../../utils_services/global_variable.dart';
import '../../profile/profile_main_screen.dart';

class ShopVerificationSMS extends StatefulWidget {
  const ShopVerificationSMS({Key? key}) : super(key: key);

  @override
  State<ShopVerificationSMS> createState() => _ShopVerificationSMSState();
}

class _ShopVerificationSMSState extends State<ShopVerificationSMS> {
  @override
  Widget build(BuildContext context) {
    return user_model.user!.shopVerfied == 1
        ? SizedBox()
        : user_model.user!.shopVerficationSubmitted == 0 &&
                user_model.user!.shopVerfied == 0
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    //Icon(Icons.warning_amber_outlined, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          'Verify your shop, products will not published without verification.'
                              .tr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.segoeui,
                              color: Colors.red)),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileMainScreen(verifiedUser: true),
                            ));
                      },
                      child: Text('verify Shop'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.segoeui,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: blueGrey.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          'Shop verification is submitted, wait for approval.'
                              .tr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.segoeui,
                              color: Colors.blueGrey)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileMainScreen(
                                  verifiedUser: true, display_data: true),
                            ));
                      },
                      child: Text('View'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.segoeui,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              );
  }
}
