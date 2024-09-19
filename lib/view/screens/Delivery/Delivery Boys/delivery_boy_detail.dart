import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';

import '../../../../extentions/app_colors.dart';
import '../../../../utils_services/app_font.dart';
import '../../../../utils_services/colors_util.dart';
import '../../../global_widgets/image_view_custom.dart';

class DeliveryBoyDetail extends StatefulWidget {
  String? wareHouseName;
  String? wareHousePhoneNo;
  String? wareHouseAddress;
  String? wareHouseCity;
  String? emiratesId;
  String? emiratesExpiryDate;
  String? emiratesImage;
  String? passportId;
  String? passportExpiryDate;
  String? passportImage;
  String? visaId;
  String? visaExpiryDate;
  String? visaImage;
  String? licenseId;
  String? licenseExpiryDate;
  String? licenseImage;
  String? boy_name;

  DeliveryBoyDetail(
      {Key? key,
      this.wareHouseName,
      this.emiratesId,
      this.visaImage,
      this.passportExpiryDate,
      this.visaExpiryDate,
      this.emiratesExpiryDate,
      this.emiratesImage,
      this.licenseExpiryDate,
      this.licenseId,
      this.licenseImage,
      this.passportId,
      this.passportImage,
      this.visaId,
      this.wareHouseAddress,
      this.wareHouseCity,
      this.boy_name,
      this.wareHousePhoneNo})
      : super(key: key);

  @override
  State<DeliveryBoyDetail> createState() => _DeliveryBoyDetailState();
}

class _DeliveryBoyDetailState extends State<DeliveryBoyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('${widget.boy_name}',
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.segoeui))
            .translate(),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.whiteColor,
                size: 30)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.wareHouseName!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12),
                  child: Text('Assigned WareHouse',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppFonts.segoeui,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.whiteColor,
                      )).translate(),
                ),
              if (widget.wareHouseName!.isNotEmpty)
                SizedBox(
                  height: 2.h,
                ),
              if (widget.wareHouseName!.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : AppColors.blackColor,
                      boxShadow: [
                        BoxShadow(
                            color: blueGrey.withOpacity(0.1),
                            offset: Offset(3, 3),
                            blurRadius: 7,
                            spreadRadius: 3),
                        BoxShadow(
                            color: blueGrey.withOpacity(0.1),
                            offset: Offset(-1, -1))
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'WareHouse Name :  '.tr,
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui)),
                                  TextSpan(
                                    recognizer: new TapGestureRecognizer(),
                                    text: '${widget.wareHouseName}',
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 0.5.h),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Mobile Number :  '.tr,
                                      style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                      )),
                                  TextSpan(
                                    recognizer: new TapGestureRecognizer(),
                                    // ..onTap = () {
                                    //   widget.onSignUp!;
                                    //},
                                    text: '${widget.wareHousePhoneNo}',
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 0.5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address :',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ).translate(),
                                Text(
                                  ' ${widget.wareHouseAddress}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ).translate()
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'City :  '.tr,
                                      style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                      )),
                                  TextSpan(
                                    recognizer: new TapGestureRecognizer(),
                                    // ..onTap = () {
                                    //   widget.onSignUp!;
                                    //},
                                    text: '${widget.wareHouseCity}',
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 12),
                child: Text('Emirates Id',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFonts.segoeui,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    )).translate(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // height: 34.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    boxShadow: [
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 7,
                          spreadRadius: 3),
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(-1, -1))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: InkWell(
                              onTap: () {
                                context.pushTransparentRoute(ImageView(
                                  imageV: ["${widget.emiratesImage}"],
                                  slectedIndex: 0,
                                ));
                              },
                              child: Container(
                                height: 8.h,
                                width: 9.h,
                                child: CachedNetworkImage(
                                  imageUrl: "${widget.emiratesImage}",
                                  placeholder: (context, url) => Container(
                                    color: Colors.blue,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Emirates ID :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.emiratesId}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Emirates Expiry :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.emiratesExpiryDate}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 12),
                child: Text('Passport',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFonts.segoeui,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    )).translate(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    boxShadow: [
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 7,
                          spreadRadius: 3),
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(-1, -1))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: InkWell(
                              onTap: () {
                                context.pushTransparentRoute(ImageView(
                                  imageV: ["${widget.passportImage}"],
                                  slectedIndex: 0,
                                ));
                              },
                              child: Container(
                                height: 8.h,
                                width: 9.h,
                                child: CachedNetworkImage(
                                  imageUrl: "${widget.passportImage}",
                                  placeholder: (context, url) => Container(
                                    color: Colors.blue,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Passport ID :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.passportId}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Expiry Date :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.passportExpiryDate}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 12),
                child: Text('Visa',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFonts.segoeui,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    )).translate(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // height: 34.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    boxShadow: [
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 7,
                          spreadRadius: 3),
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(-1, -1))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: InkWell(
                              onTap: () {
                                context.pushTransparentRoute(ImageView(
                                  imageV: ["${widget.visaImage}"],
                                  slectedIndex: 0,
                                ));
                              },
                              child: Container(
                                height: 8.h,
                                width: 9.h,
                                child: CachedNetworkImage(
                                  imageUrl: "${widget.visaImage}",
                                  placeholder: (context, url) => Container(
                                    color: Colors.blue,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Visa No :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.visaId}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Expiry Date :  '.tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui)),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.visaExpiryDate}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 12),
                child: Text('Driving Licence',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFonts.segoeui,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppColors.whiteColor,
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    boxShadow: [
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 7,
                          spreadRadius: 3),
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(-1, -1))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: InkWell(
                              onTap: () {
                                context.pushTransparentRoute(ImageView(
                                  imageV: ["${widget.licenseImage}"],
                                  slectedIndex: 0,
                                ));
                              },
                              child: Container(
                                height: 8.h,
                                width: 9.h,
                                child: CachedNetworkImage(
                                  imageUrl: "${widget.licenseImage}",
                                  placeholder: (context, url) => Container(
                                    color: Colors.blue,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Licence No :  '.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                    )),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.licenseId}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                              ),
                              children: [
                                TextSpan(
                                    text: 'Expiry Date :  '.tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui)),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.licenseExpiryDate}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
