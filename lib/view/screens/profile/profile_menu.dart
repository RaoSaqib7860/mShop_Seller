import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/screens/Home/home_screen/home_screen.dart';
import 'package:mShop_Seller/view/screens/profile/profile_main_screen.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/Notification/in_app_notification.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/storage_util.dart';
import '../../global_widgets/web_view_global.dart';
import '../Compaigns_class/compains_screen.dart';
import '../Delivery/Delivery Boys/delivery_boys_list_screen.dart';
import '../Invoice Screen/invoice_page.dart';
import '../LoginPages/login_screen.dart';
import '../MediaManagment/BulkUpload.dart';
import '../MediaManagment/Media.dart';
import '../Notification/notifacation.dart';
import '../PaymentSendToAdmin/payment_send_to_admin_screen.dart';
import '../Reports/reports_main_screen.dart';
import '../WareHouse List/ware_house_list_screen.dart';
import '../orders/order_screen.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  void initState() {
    getApiData();
    super.initState();
  }

  bool _value = false;
  NotificationModel? model;
  getApiData() async {
    model = await DataProvider().get_app_notifications(count: 20, page: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.0.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 200,
                      width: 350,
                      //color: Colors.grey,
                      child: Column(
                        children: [
                          Builder(builder: (context) {
                            return Container(
                              height: 90,
                              child: Image.asset(
                                'assets/image/Profile_image.png',
                              ),
                            );
                          }),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Text(
                            '${user_model.user!.shopName}',
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xff000000)
                                  : AppColors.whiteColor,
                              //const Color(0xff000000),
                            ),
                          ).translate(),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Text(
                            '${user_model.user!.email}',
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontSize: 12,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xff000000)
                                  : AppColors.whiteColor,
                              //const Color(0xff000000),
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Text(
                            '${user_model.user!.phone}',
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontSize: 12,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xff000000)
                                  : AppColors.whiteColor,
                              //const Color(0xff000000),
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'General'.tr,
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff000000)
                                    : AppColors.whiteColor,
                            //const Color(0xff000000),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ThemeChangeScreen(),));
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'Settings'.tr,
                        //         style: TextStyle(
                        //             fontSize: width * 0.045, fontWeight: FontWeight.bold,color: AppColors.allButtonColor),
                        //       ),
                        //       SizedBox(width: width * 0.005,),
                        //       Icon(Icons.arrow_forward_ios,color: AppColors.allButtonColor,size: width * 0.04,)
                        //
                        //       // Padding(
                        //       //   padding: EdgeInsets.only(left: width * 0.020),
                        //       //   child: CupertinoSwitch(
                        //       //     value: _value,
                        //       //     onChanged: ( value) {
                        //       //       setState(() {
                        //       //         _value = value;
                        //       //         if (_value)
                        //       //           MyApp.of(context)!.changeTheme(ThemeMode.dark);
                        //       //         else
                        //       //           MyApp.of(context)!.changeTheme(ThemeMode.light);
                        //       //       });
                        //       //     },
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      //Colors.grey.shade200,
                      child: SvgPicture.asset(
                        'assets/svgs/product.svg',
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'Product'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(isBack: true),
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: SvgPicture.asset(
                        'assets/svgs/order.svg',
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'Orders'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentToAdminScreen(),
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: SvgPicture.asset(
                        'assets/svgs/order.svg',
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'Payments',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ).translate(),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  ListTile(
                    onTap: () {
                      if (user_model.user!.shopVerfied == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileMainScreen(
                                display_data: true,
                                verifiedUser: true,
                              ),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileMainScreen(
                                verifiedUser: true,
                              ),
                            ));
                      }
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: Icon(
                        Icons.storefront_outlined,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'Shop'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(DeliveryBoyListScreen());
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: Icon(
                        Icons.drive_eta,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'Drivers',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ).translate(),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(WareHouseListScreen());
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: Icon(
                        Icons.home_work_outlined,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      ),
                    ),
                    title: Text(
                      'WareHouses',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ).translate(),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Divider(),
                  // ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade200
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(
                        Icons.perm_media_outlined,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MediaPage(),
                          ));
                    },
                    title: Text(
                      'Gallery'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(Icons.cloud_upload_outlined,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BulkUpload(),
                          ));
                    },
                    title: Text(
                      'Bulk Upload'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(Icons.campaign,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompaignScreen(),
                          ));
                    },
                    title: Text(
                      'Campaign',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ).translate(),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(Icons.notifications_none_sharp,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppNotification(),
                          )).then((value) {
                        getApiData();
                      });
                    },
                    title: Row(
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 16,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff000000)
                                    : AppColors.whiteColor,
                            //const Color(0xff000000),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (model != null && model!.count != 0)
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blueGrey),
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                '${model!.count}',
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 10,
                                  color: Colors.white,
                                  //const Color(0xff000000),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(Icons.notifications_none_sharp,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvoicePage(),
                          )).then((value) {
                        getApiData();
                      });
                    },
                    title: Row(
                      children: [
                        Text(
                          'Invoice',
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 16,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff000000)
                                    : AppColors.whiteColor,
                            //const Color(0xff000000),
                          ),
                        ),

                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : AppColors.blackColor,
                      child: Center(
                          child: Icon(Icons.add_chart,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportsMainScreen(),
                          ));
                    },
                    title: Text(
                      'Reports',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ).translate(),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    ),
                  ),
                  if (user_model.user!.contractLink != null)
                    ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : AppColors.blackColor,
                        child: Center(
                            child: Icon(Icons.contact_mail,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : AppColors.whiteColor)),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewGlobal(
                                url: user_model.user!.contractLink,
                                title: 'Seller Contract',
                              ),
                            ));
                      },
                      title: Text(
                        'Seller Contract',
                        style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 16,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff000000)
                                  : AppColors.whiteColor,
                          //const Color(0xff000000),
                        ),
                      ).translate(),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     radius: 20,
                  //     backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black:Colors.white,
                  //     child: Icon(Icons.ac_unit, color: Theme.of(context).brightness == Brightness.light ? Colors.black:Colors.white),
                  //   ),
                  //   title: Text(
                  //     'Theme',
                  //     style: TextStyle(
                  //       fontFamily: AppFonts.segoeui,
                  //       fontSize: 16,
                  //       color: Theme.of(context).brightness == Brightness.light
                  //           ? Colors.black
                  //           : Colors.white,
                  //     ),
                  //   ).translate(),
                  //   trailing: CupertinoSwitch(
                  //     value: _value,
                  //     onChanged: (value) {
                  //       _value = value;
                  //       if (_value) {
                  //         setState(() {
                  //           MyApp.of(context)!.changeTheme(ThemeMode.dark);
                  //         });
                  //       } else {
                  //         setState(() {
                  //           MyApp.of(context)!.changeTheme(ThemeMode.light);
                  //         });
                  //       }
                  //     },
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      storage.erase();
                      Get.offAll(LoginScreen());
                    },
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : AppColors.blackColor,
                        child: Icon(
                          Icons.login,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : AppColors.whiteColor,
                        )),
                    title: Text(
                      'Sign Out'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xff000000)
                            : AppColors.whiteColor,
                        //const Color(0xff000000),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
