import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';

import '../../../api_repo/api_utils.dart';
import '../../../utils_services/app_font.dart';

class imageViewScreen extends StatefulWidget {
  final File? imagePath;
  final String? paymentSent;
  final String? orderId;
  const imageViewScreen(
      {Key? key, this.paymentSent, this.orderId, this.imagePath})
      : super(key: key);

  @override
  State<imageViewScreen> createState() => _imageViewScreenState();
}

class _imageViewScreenState extends State<imageViewScreen> {
  bool loader = false;

  uploadFile() async {
    await DataProvider().sendPaymentReceiptFunction(map: {
      'order_id': '${widget.orderId}',
      'payment_receipt':
          await dio.MultipartFile.fromFile(widget.imagePath!.path),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: Text('Upload Receipt', style: TextStyle(color: Colors.black)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    child: Image.file(widget.imagePath!, fit: BoxFit.fill),
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 12,
                          color: const Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                              text: '  Amount to transfer :  '.tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          TextSpan(
                            recognizer: new TapGestureRecognizer(),
                            text: ' AED ${widget.paymentSent}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.segoeui,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 5.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey),
                          child: const Center(
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15))),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          loader = true;
                          setState(() {});
                          await uploadFile();
                          loader = false;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 5.h,
                          width: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: blueGrey),
                          child: const Center(
                              child: Text('Upload',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: loader,
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Processing',
                    style: TextStyle(fontSize: 20, color: Colors.black),
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
