import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';

import '../../../extentions/app_colors.dart';
import '../../../model/All Products/all_products_model.dart';
import '../../../model/Compaigns/all_product_model_compain.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/web_view_global.dart';
import 'add_new_campaign.dart';

class CampaignDetailScreen extends StatefulWidget {
  String? name;
  dynamic discount;
  String? discount_type;
  String? startDate;
  String? endDate;
  int? status;
  List<String>? product_count;
  int? campaignId;
  CampaignDetailScreen(
      {Key? key,
      this.status,
      this.product_count,
      this.name,
      this.endDate,
      this.startDate,
      this.campaignId,
      this.discount,
      this.discount_type})
      : super(key: key);

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  GetAllProductModelsCompain? getAllProduct;
  StreamSubscription? subscription;
  @override
  void initState() {
    apiCall();
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            apiCall();
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  apiCall() async {
    getAllProduct = await DataProvider().get_all_product_Functions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
          title: Text(
            'Campaign Details',
            style: TextStyle(
              fontFamily: AppFonts.segoeui,
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: getAllProduct != null
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 100.h,
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 24.h,
                      width: 97.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: AppFonts.segoeui,
                                ),
                              ),
                              PopupMenuButton(
                                offset: Offset(3.3, 42.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                onSelected: (value) {},
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (BuildContext bc) {
                                  return [
                                    PopupMenuItem(
                                      child: InkWell(
                                          onTap: () async {
                                            Get.to(NewCampaign(
                                              tag: 'update',
                                              name: widget.name,
                                              discount_type:
                                                  widget.discount_type,
                                              campaignId: widget.campaignId,
                                              discount: widget.discount,
                                              endDate: widget.startDate,
                                              startDate: widget.endDate,
                                              productId: widget.product_count!,
                                            ))!
                                                .then((value) {
                                              if (value == 'update') {
                                                apiCall();
                                              }
                                            });
                                          },
                                          child: Text("Update")),
                                      value: '/Update',
                                    ),
                                  ];
                                },
                              )
                            ],
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 14,
                                //color: const Color(0xff000000),
                              ),
                              children: [
                                TextSpan(
                                    text: 'Discount : '.tr, style: TextStyle()),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.discount}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discount type',
                              ),
                              Text(
                                ' : ${widget.discount_type}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppFonts.segoeui,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Start Date : '.tr,
                                ),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.startDate}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 14,
                                // color: const Color(0xff000000),
                              ),
                              children: [
                                TextSpan(
                                  text: 'End Date : '.tr,
                                ),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer(),
                                  text: '${widget.endDate}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status : '),
                              Text(
                                widget.status == 1 ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: widget.status == 1
                                      ? Colors.green
                                      : Colors.red,
                                  fontFamily: AppFonts.segoeui,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        )),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    if (getAllProduct != null)
                      Expanded(
                          child: ListView.builder(
                        itemCount: getAllProduct!.data.length,
                        itemBuilder: (context, index) {
                          return widget.product_count!
                                  .contains('${getAllProduct!.data[index].id}')
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewGlobal(
                                            url:
                                                getAllProduct!.data[index].link,
                                            title: 'Mate Seller',
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    width: 97.w,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                            height: 8.h,
                                            width: 7.2.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${getAllProduct!.data[index].thumbnailImg}",
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.white,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          title: Container(
                                            width: 20.w,
                                            height: 6.h,
                                            child: Text(
                                              '${getAllProduct!.data[index].name}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1.h)
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ))
                  ],
                ),
              )
            : Center(
                child: screenLoader(use_opacity: false),
              ));
  }
}
