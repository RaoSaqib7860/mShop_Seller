import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';

import '../../../model/Notification/in_app_notification.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view/screens/orders/order_detail.dart' as order_page;
import '../../conectivity/connectivity.dart';
import '../DashBoared/DashBoaredMainScreen.dart';

class AppNotification extends StatefulWidget {
  const AppNotification({super.key});

  @override
  State<AppNotification> createState() => _AppNotificationState();
}

class _AppNotificationState extends State<AppNotification> {
  StreamSubscription? subscription;
  @override
  void initState() {
    getApiData();
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            getApiData();
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  var refreshController = RefreshController(initialRefresh: false);
  bool loadData = false;
  int count = 20;
  int page = 1;
  NotificationModel? model;
  getApiData() async {
    model =
        await DataProvider().get_app_notifications(count: count, page: page);
    loadData = true;
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
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 17,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: !loadData
          ? Center(
          child: Center(child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ShimmerLoder())))
          : model!.data.data.isEmpty
              ? Center(child: Text('No Data'))
              : Column(children: [
                  Expanded(
                      child: RefreshControllerGlobal(
                    controller: refreshController,
                    onLoad: () async {
                      page = page + 1;
                      NotificationModel? v = await DataProvider()
                          .get_app_notifications(count: count, page: page);
                      model!.data.data.addAll(v.data.data);
                      setState(() {});
                      refreshController.loadComplete();
                    },
                    onRefresh: () async {
                      page = 1;
                      model = await DataProvider()
                          .get_app_notifications(count: count, page: page);
                      setState(() {});
                      refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              ListTile(
                                // leading: model!.data.data[i].visited == 1
                                //     ? Text('•',
                                //         style:
                                //             TextStyle(fontSize: 40, color: Colors.white))
                                //     : Text('•', style: TextStyle(fontSize: 40)),
                                title: Text(
                                    model!.data.data[i].visited == 1
                                        ? '   ' +
                                            '${model!.data.data[i].notificationHeading}'
                                        : '•  ' +
                                            '${model!.data.data[i].notificationHeading}',
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                      '${model!.data.data[i].notificationContent}',
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui)),
                                ),
                                onTap: () {
                                  if (model!.data.data[i].visited == 0) {
                                    DataProvider().update_notification(
                                        id: '${model!.data.data[i].id}');
                                  }
                                  if (model!.data.data[i].action!=null && model!.data.data[i].action!.name ==
                                      'ORDER_DETAIL') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                order_page.OrderDetail(
                                                    Id:
                                                        '${model!.data.data[i].orderId}',
                                                    link: '',
                                                    boyName: 'boy name',
                                                    wareHouseName:
                                                        'Dubai Store'))).then(
                                        (value) async {
                                      page = 1;
                                      NotificationModel? v =
                                          await DataProvider()
                                              .get_app_notifications(
                                                  count: count, page: page);
                                      model = v;
                                      setState(() {});
                                    });
                                  } else {
                                    print('${model!.data.data[i].action}');
                                    Get.to(DashBoardMainScreen(
                                      leading: true,
                                    ))!
                                        .then((value) async {
                                      page = 1;
                                      NotificationModel? v =
                                          await DataProvider()
                                              .get_app_notifications(
                                                  count: count, page: page);
                                      model = v;
                                      setState(() {});
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: Divider(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: model!.data.data.length,
                    ),
                  ))
                ]),
    );
  }
  Widget ShimmerLoder(){
    return Column(children: [
      Expanded(
          child: ListView.builder(
            itemBuilder: (c, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    ListTile(
                      // leading: model!.data.data[i].visited == 1
                      //     ? Text('•',
                      //         style:
                      //             TextStyle(fontSize: 40, color: Colors.white))
                      //     : Text('•', style: TextStyle(fontSize: 40)),
                      title: Container(
                    height: 2.h,
                  width: 20.w,
                        color: Colors.grey.shade200.withOpacity(0.5),
                ),
                      subtitle: Container(
                        height: 2.h,
                        width: 60.w,
                        color: Colors.grey.shade200.withOpacity(0.5),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Divider(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
            itemCount: 20,
          ))
    ]);
  }
}
