import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/utils_services/refresh_controller.dart';

import '../../../../extentions/app_colors.dart';
import '../../../../model/delivery_model/delivery_model_list.dart';
import '../../../../utils_services/Loader.dart';
import '../../../../view_model/delivery_bloc/delivery_list_bloc/delivery_boy_events.dart';
import '../../../../view_model/delivery_bloc/delivery_list_bloc/delivery_boy_list_bloc.dart';
import '../../../../view_model/delivery_bloc/delivery_list_bloc/delivery_boy_state.dart';
import '../../../conectivity/connectivity.dart';
import '../Add Delivery Boy/add_delivery_boy_screen.dart';
import 'delivery_boy_detail.dart';

class DeliveryBoyListScreen extends StatefulWidget {
  const DeliveryBoyListScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryBoyListScreen> createState() => _DeliveryBoyListScreenState();
}

class _DeliveryBoyListScreenState extends State<DeliveryBoyListScreen> {
  DeliveryBoyBloc deliveryBoyBloc =
      DeliveryBoyBloc(DeliveryBoyListInitialState());
  var refreshController = RefreshController(initialRefresh: false);
  StreamSubscription? subscription;
  @override
  void initState() {
    deliveryBoyBloc.add(DeliveryBoyEvent());
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            deliveryBoyBloc.add(DeliveryBoyEvent());
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('All Drivers',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.segoeui)),
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
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddDeliveryBoyScreen())!.then((value) {
                  if (value == 'submit') {
                    deliveryBoyBloc.add(DeliveryBoyEvent());
                  }
                });
              },
              icon: Icon(
                Icons.add_circle,
                color: Colors.black,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocConsumer<DeliveryBoyBloc, DeliveryBoyListScreenState>(
        bloc: deliveryBoyBloc,
        listener: (context, state) {
          if (state is DeliveryBoyListErrorState) {}
        },
        builder: (context, state) {
          if (state is DeliveryBoyListLoadingState) {
            return Center(
                child: Center(
                    child: Shimmer.fromColors(
                        child: ShimmerBoyDeliveryList(),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100
                    )
                ));
          } else if (state is DeliveryBoyListLoadedState) {
            return BoyDeliveryList(
                boyList: state.res, context: context, state: state);
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
  }

  Widget BoyDeliveryList(
      {required DeliveryBoyList boyList,
      required BuildContext context,
      required DeliveryBoyListLoadedState state}) {
    return Column(
      children: [
        Expanded(
            child: RefreshControllerGlobal(
          controller: refreshController,
          onLoad: () {
            refreshController.loadComplete();
          },
          onRefresh: () async {
            deliveryBoyBloc.add(DeliveryBoyEvent());
            refreshController.refreshCompleted();
          },
          child: ListView.builder(
            itemCount: boyList.data!.length,
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
              child: InkWell(
                onTap: () {
                  Get.to(DeliveryBoyDetail(
                    wareHouseName: boyList.data![index].warehouses == null
                        ? ''
                        : boyList.data![index].warehouses![0].warehouseName,
                    wareHouseAddress: boyList.data![index].warehouses == null
                        ? ''
                        : boyList.data![index].warehouses![0].warehouseAddress,
                    wareHousePhoneNo: boyList.data![index].warehouses == null
                        ? ''
                        : boyList.data![index].warehouses![0].warehouseContact,
                    wareHouseCity: boyList.data![index].warehouses == null
                        ? ''
                        : boyList.data![index].warehouses![0].warehouseCity,
                    emiratesId: boyList.data![index].emiratesIdNo,
                    emiratesExpiryDate: boyList.data![index].emiratesIdExpiry,
                    emiratesImage: boyList.data![index].emiratesId,
                    passportId: boyList.data![index].passportNo,
                    passportExpiryDate: boyList.data![index].passportExpiry,
                    passportImage: boyList.data![index].passport,
                    licenseExpiryDate: boyList.data![index].licenseExpiry,
                    licenseId: boyList.data![index].licenseNo,
                    licenseImage: boyList.data![index].license,
                    visaId: boyList.data![index].visaNo,
                    visaExpiryDate: boyList.data![index].visaExpiry,
                    visaImage: boyList.data![index].visa,
                    boy_name: boyList.data![index].name,
                  ));
                },
                child: Container(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${boyList.data![index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.segoeui,
                            fontSize: 18),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.3.h,
                        ),
                        Text(
                          '${boyList.data![index].email}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.segoeui,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          '${boyList.data![index].phone}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.segoeui,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          boyList.data![index].verified == 'no'
                              ? 'Pending verification'
                              : 'Verified',
                          style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              color: boyList.data![index].verified == 'no'
                                  ? Colors.blueAccent
                                  : Colors.green,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 0.9.h,
                        ),
                        Divider(
                          color: Colors.blueGrey,
                        )
                      ],
                    ),
                    trailing: Wrap(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Driver'),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('You want to delete it?'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Ok'),
                                          onPressed: () async {
                                            DataProvider().deleteDeliveryBoy(
                                                boyList.data![index].id
                                                    .toString());
                                            state.res.data!.removeAt(index);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                height: 3.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                    child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(AddDeliveryBoyScreen(
                                  tag: 'update',
                                  name: boyList.data![index].name,
                                  email: boyList.data![index].email,
                                  phoneNo: boyList.data![index].phone,
                                  nationality: boyList.data![index].nationality,
                                  emiratesId: boyList.data![index].emiratesIdNo,
                                  emiratesExpiryDate:
                                      boyList.data![index].emiratesIdExpiry,
                                  //emiratesImage: boyList.data![index].emiratesIdNo,
                                  visaId: boyList.data![index].visaNo,
                                  visaExpiryDate:
                                      boyList.data![index].visaExpiry,
                                  passportId: boyList.data![index].passportNo,
                                  passportExpiryDate:
                                      boyList.data![index].passportExpiry,
                                  licenseId: boyList.data![index].licenseNo,
                                  licenseExpiryDate:
                                      boyList.data![index].licenseExpiry,
                                  Id: boyList.data![index].userId,
                                ));
                              },
                              child: Container(
                                height: 3.h,
                                width: 16.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text(
                                  'Update',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget ShimmerBoyDeliveryList() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                child: Container(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 2.h,
                            width: 15.w,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.3.h,
                        ),
                        Container(
                          height: 1.5.h,
                          width: 22.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          height: 1.5.h,
                          width: 18.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          height: 2.h,
                          width: 20.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 0.9.h,
                        ),
                        Divider(
                          color: Colors.black.withAlpha(100),
                          thickness: 1,
                        )
                      ],
                    ),
                    trailing: Wrap(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 3.h,
                              width: 16.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6),
                              ),

                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            Container(
                              height: 3.h,
                              width: 16.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
