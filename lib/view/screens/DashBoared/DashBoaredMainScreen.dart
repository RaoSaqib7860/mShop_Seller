import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../extentions/app_colors.dart';
import '../../../model/Notification/in_app_notification.dart';
import '../../../model/dashboard/dashboard_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../utils_services/storage_util.dart';

import '../../conectivity/connectivity.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/custom_dropdown.dart';
import '../Home/home_screen/home_screen.dart';
import '../Notification/notifacation.dart';
import '../orders/order_screen.dart';
import 'components/contract_sms.dart';
import 'components/pie_chart.dart';
import 'components/shop_verification_sms.dart';

class DashBoardMainScreen extends StatefulWidget {
  final bool? leading;
  const DashBoardMainScreen({Key? key, this.leading = false}) : super(key: key);

  @override
  State<DashBoardMainScreen> createState() => _DashBoardMainScreenState();
}

class _DashBoardMainScreenState extends State<DashBoardMainScreen> {
  bool data_load = false;
  var refreshController = RefreshController(initialRefresh: false);
  List<String> days = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  StreamSubscription? subscription;
  @override
  void initState() {
    get_api_data();
    getApiData();
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            get_api_data();
            getApiData();
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  DashBoard? dashBoard;

  get_api_data() async {
    dashBoard = await DataProvider.get_dashboard_api();
    await DataProvider().loginFunction(
        Email: user_model.user!.email, Password: storage.read('user_password'));
    data_load = true;
    setState(() {});
  }

  int? indexes = 0;

  final List<ChartData> chartData = [];

  String selected_duration = 'Today'.tr;
  List list_of_duration = ['Today'.tr, 'Weeks'.tr, 'Months'.tr, 'Years'.tr];

  int calulationFunction() {
    dynamic cMonth = '${dashBoard!.data.soldAmount.currentMonth}'
        .replaceAll('AED', '')
        .trim()
        .replaceAll(',', '')
        .trim();
    dynamic lMonth = '${dashBoard!.data.soldAmount.lastMonth}'
        .replaceAll('AED', '')
        .trim()
        .replaceAll(',', '')
        .trim();
    double profit =
        ((double.parse(cMonth.toString()) - double.parse(lMonth.toString())) *
                100) /
            double.parse(lMonth.toString());
    print('profit...${profit}');
    return profit.isInfinite ? 0 : profit.round();
  }

  NotificationModel? notification_model;
  getApiData() async {
    notification_model =
        await DataProvider().get_app_notifications(count: 20, page: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : AppColors.blackColor,
        elevation: 0,
        leading: widget.leading!
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              )
            : null,
        centerTitle: true,
        title: Text(
          'Dashboard'.tr,
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          notification_model == null || notification_model!.count == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppNotification(),
                        )).then((value) {
                      getApiData();
                    });
                  },
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.black,
                    size: 25,
                  ))
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppNotification(),
                        )).then((value) {
                      getApiData();
                    });
                  },
                  child: Center(
                    child: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -2),
                      showBadge: true,
                      ignorePointer: false,
                      badgeColor: Colors.red,
                      badgeContent: Text('',
                          style: TextStyle(fontSize: 10, color: Colors.white)),
                      child: Icon(Icons.notifications_none_sharp,
                          color: Colors.black, size: 25),
                    ),
                  ),
                ),
          SizedBox(
            width: notification_model == null || notification_model!.count == 0
                ? 10
                : 20,
          )
        ],
      ),
      // backgroundColor: Colors.white,
      body: !data_load
          ? Center(
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: shimmerEffect( )))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshControllerGlobal(
                controller: refreshController,
                onLoad: () {
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  setState(() {
                    data_load = false;
                  });
                  await get_api_data();
                  refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Column(children: [
                    ShopVerificationSMS(),
                    SizedBox(height: 2.h),
                    ContractSms(update: () {
                      setState(() {});
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${user_model.user!.shopName}',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : AppColors.whiteColor,
                                  fontSize: 20,
                                  fontFamily: AppFonts.segoeui,
                                  letterSpacing: 0.5))
                          .translate(),
                    ),
                    Visibility(
                      visible: user_model.user!.shopVerfied == 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Verified'.tr,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppFonts.segoeui,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : AppColors.whiteColor)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Sales OverView',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : AppColors.whiteColor,
                                  fontSize: 20,
                                  fontFamily: AppFonts.segoeui,
                                  letterSpacing: 0.5))
                          .translate(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 7.h,
                        width: 90.w,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                        '${dashBoard!.data.soldAmount.currentMonth}  This Month Sales, Compare to last Month',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12))
                                    .translate(),
                              ),
                              Text('${calulationFunction()}',
                                      style: TextStyle(
                                          color: calulationFunction().isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 14))
                                  .translate(),
                              Icon(
                                calulationFunction().isNegative
                                    ? Icons.keyboard_arrow_down_rounded
                                    : Icons.keyboard_arrow_up_rounded,
                                color: calulationFunction().isNegative
                                    ? Colors.red
                                    : Colors.green,
                              )
                            ],
                          ),
                        )),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      //width: width,
                      height: height * 0.250,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.250,
                              child: Column(children: [
                                Icon(Icons.markunread_mailbox_outlined,
                                    size: 40),
                                SizedBox(height: 20),
                                Text('Products'.tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : AppColors.whiteColor,
                                        fontSize: 13)),
                                SizedBox(height: 7),
                                Text('${dashBoard!.data!.productCount!.value}',
                                        style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30))
                                    .translate(),
                              ], mainAxisAlignment: MainAxisAlignment.center),
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
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            },
                          ),
                          SizedBox(width: 15),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 40,
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Rating'.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 13)),
                                          SizedBox(height: 4),
                                          Text('${dashBoard!.data!.rating!.value['rating']}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.segoeui,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30))
                                              .translate(),
                                        ],
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center),
                                decoration: BoxDecoration(
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
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : AppColors.blackColor,
                                    borderRadius: BorderRadius.circular(20)),
                              )),
                              SizedBox(height: 15),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderScreen(),
                                            ));
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Total Orders'.tr,
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontSize: 11)),
                                            SizedBox(height: 4),
                                            Text('${dashBoard!.data!.totalOrder!.value}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.segoeui,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 23))
                                                .translate(),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      blueGrey.withOpacity(0.1),
                                                  offset: Offset(3, 3),
                                                  blurRadius: 7,
                                                  spreadRadius: 3),
                                              BoxShadow(
                                                  color:
                                                      blueGrey.withOpacity(0.1),
                                                  offset: Offset(-1, -1))
                                            ],
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : AppColors.blackColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Total Sales'.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 11)),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('${dashBoard!.data!.totalSales!.value}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              AppFonts.segoeui,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10))
                                                  .translate(),
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    blueGrey.withOpacity(0.1),
                                                offset: Offset(3, 3),
                                                blurRadius: 7,
                                                spreadRadius: 3),
                                            BoxShadow(
                                                color:
                                                    blueGrey.withOpacity(0.1),
                                                offset: Offset(-1, -1))
                                          ],
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : AppColors.blackColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Sales States'.tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFonts.segoeui,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 5),
                          SfCartesianChart(
                              primaryXAxis: DateTimeCategoryAxis(),
                              series: <ChartSeries<ChartData, DateTime>>[
                                ColumnSeries<ChartData, DateTime>(
                                    dataSource: [
                                      ...dashBoard!.data.salesRevenueData
                                          .map(
                                            (e) => ChartData(
                                                DateTime(e.year,
                                                    days.indexOf(e.month) + 1),
                                                e.revenue.toDouble()),
                                          )
                                          .toList(),
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y)
                              ]),
                        ],
                      ),
                      decoration: BoxDecoration(
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Orders'.tr,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.segoeui,
                              )).translate(),
                          Container(
                            width: 120,
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomDropdownButton2(
                                buttonDecoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                // buttonPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 0),
                                dropdownWidth: 31.w,
                                buttonWidth: 100.w,
                                hint: selected_duration,
                                dropdownItems: list_of_duration.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text('$value'),
                                  );
                                }).toList(),
                                onChanged: (data) async {
                                  selected_duration = data!;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    selected_duration == 'Today'.tr
                        ? order_by_duration(
                            cancel_order: dashBoard!.data!.orders!.today!.cancelled!
                                .toString(),
                            delivered: dashBoard!.data!.orders!.today!.delivered!
                                .toString(),
                            new_order: dashBoard!.data!.orders!.today!.newOrder!
                                .toString(),
                            on_delivery: dashBoard!
                                .data!.orders!.today!.onDelivery!
                                .toString())
                        : selected_duration == 'Weeks'.tr
                            ? order_by_duration(
                                cancel_order: dashBoard!
                                    .data!.orders!.thisWeek!.cancelled!
                                    .toString(),
                                delivered: dashBoard!
                                    .data!.orders!.thisWeek!.delivered!
                                    .toString(),
                                new_order: dashBoard!
                                    .data!.orders!.thisWeek!.newOrder!
                                    .toString(),
                                on_delivery: dashBoard!
                                    .data!.orders!.thisWeek!.onDelivery!
                                    .toString())
                            : selected_duration == 'Months'.tr
                                ? order_by_duration(
                                    cancel_order: dashBoard!
                                        .data!.orders!.thisMonth!.cancelled!
                                        .toString(),
                                    delivered: dashBoard!
                                        .data!.orders!.thisMonth!.delivered!
                                        .toString(),
                                    new_order: dashBoard!
                                        .data!.orders!.thisMonth!.newOrder!
                                        .toString(),
                                    on_delivery: dashBoard!
                                        .data!.orders!.thisMonth!.onDelivery!
                                        .toString())
                                : order_by_duration(
                                    cancel_order: dashBoard!.data!.orders!.thisYear!.cancelled!.toString(),
                                    delivered: dashBoard!.data!.orders!.thisYear!.delivered!.toString(),
                                    new_order: dashBoard!.data!.orders!.thisYear!.newOrder!.toString(),
                                    on_delivery: dashBoard!.data!.orders!.thisYear!.onDelivery!.toString()),
                    SizedBox(height: 20),
                    Container(
                      width: width,
                      height: height * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          children: [
                            Text('Sold Amount'.tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 20))
                                .translate(),
                            SizedBox(height: 7),
                            Text('Your  sold amount current month'.tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12))
                                .translate(),
                            Text('${dashBoard!.data!.soldAmount!.currentMonth}',
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30))
                                .translate(),
                            Text(
                                    'Last Month : ${dashBoard!.data!.soldAmount!.lastMonth}'
                                        .tr,
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : AppColors.whiteColor,
                                        fontSize: 12))
                                .translate(),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start),
                      decoration: BoxDecoration(
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 6.h,
                      //color: Colors.deepPurple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              indexes = 0;
                              setState(() {});
                            },
                            child: Container(
                              height: 4.5.h,
                              width: 20.w,
                              child: Center(
                                  child: Text(
                                'Today Sale',
                                style: TextStyle(fontSize: 12),
                              ).translate()),
                              decoration: BoxDecoration(
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              indexes = 1;
                              setState(() {});
                            },
                            child: Container(
                              height: 4.5.h,
                              width: 20.w,
                              child: Center(
                                  child: Text('This Week',
                                          style: TextStyle(fontSize: 12))
                                      .translate()),
                              decoration: BoxDecoration(
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              indexes = 2;
                              setState(() {});
                            },
                            child: Container(
                              height: 4.5.h,
                              width: 20.w,
                              child: Center(
                                  child: Text('This month',
                                          style: TextStyle(fontSize: 12))
                                      .translate()),
                              decoration: BoxDecoration(
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              indexes = 3;
                              setState(() {});
                            },
                            child: Container(
                              height: 4.5.h,
                              width: 20.w,
                              child: Center(
                                  child: Text('This year',
                                          style: TextStyle(fontSize: 12))
                                      .translate()),
                              decoration: BoxDecoration(
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 42.w,
                          height: height * 0.2,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                      indexes == 0
                                          ? 'Today Sales'
                                          : indexes == 1
                                              ? 'This Weak sales'
                                              : indexes == 2
                                                  ? 'This month sales'
                                                  : 'This year sales',
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 11))
                                  .translate(),
                              SizedBox(height: 4),
                              Text(
                                  indexes == 0
                                      ? dashBoard!.data!.salesToday!.revenue ==
                                              0
                                          ? 'AED0'
                                          : 'AED ${dashBoard!.data!.salesToday!.revenue}'
                                      : indexes == 1
                                          ? 'AED ${dashBoard!.data!.salesThisWeek!.revenue}'
                                          : indexes == 2
                                              ? 'AED ${dashBoard!.data!.salesThisMonth!.revenue}'
                                              : 'AED ${dashBoard!.data!.salesThisYear!.revenue}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
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
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Expanded(
                          child: Container(
                            //width: 42.w,
                            height: height * 0.2,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                        indexes == 0
                                            ? 'Today Orders'
                                            : indexes == 1
                                                ? 'This Weak Orders'
                                                : indexes == 2
                                                    ? 'This month Orders'
                                                    : 'This year Orders',
                                        style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 11))
                                    .translate(),
                                SizedBox(height: 4),
                                Text(
                                        indexes == 0
                                            ? '${dashBoard!.data!.salesToday!.count}'
                                            : indexes == 1
                                                ? '${dashBoard!.data!.salesThisWeek!.count}'
                                                : indexes == 2
                                                    ? '${dashBoard!.data!.salesThisMonth!.count}'
                                                    : '${dashBoard!.data!.salesThisYear!.count}',
                                        style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23))
                                    .translate(),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            decoration: BoxDecoration(
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
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : AppColors.blackColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    dashBoard!.data!.categoryWiseProduct!.isEmpty
                        ? SizedBox()
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Category wise Products'.tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: AppFonts.segoeui,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 5),
                                PieChartSample2(
                                  dashboard: dashBoard,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
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
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : AppColors.blackColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                    SizedBox(height: 20),
                  ], crossAxisAlignment: CrossAxisAlignment.start),
                ),
              ),
            ),
    );
  }
 Widget  shimmerEffect(){
    return Column(children: [

      SizedBox(height: 2.h),
      ContractSms(update: () {
        setState(() {});
      }),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 2.h,
          width: 30.w,
          color: Colors.grey.shade200.withOpacity(0.5),
        ),
      ),
      Visibility(
        visible: user_model.user!.shopVerfied == 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 2.h,
            width: 10.w,
            color: Colors.grey.shade200.withOpacity(0.5),
          ),
        ),
      ),
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 2.h,
          width: 30.w,
          color: Colors.grey.shade200.withOpacity(0.5),
        ),
      ),
      SizedBox(
        height: 2.h,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 7.h,
          width: 90.w,

          decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      Container(
        //width: width,
        height: height * 0.250,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            InkWell(
              child: Container(
                width: width * 0.4,
                height: height * 0.250,

                decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
              ),

            ),
            SizedBox(width: 15),
            Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    SizedBox(height: 15),
                    Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderScreen(),
                                      ));
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200.withOpacity(0.5),
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200.withOpacity(0.5),
                                    borderRadius:
                                    BorderRadius.circular(20)),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        height: 40.h,
        margin: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(
            horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
      ),

    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    subscription!.cancel();
  }

  Widget order_by_duration(
      {String? new_order,
      String? cancel_order,
      String? on_delivery,
      String? delivered}) {
    return Container(
      // width: width,
      height: height * 0.250,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: width * 0.4,
            height: height * 0.250,
            child: Column(children: [
              Icon(Icons.move_to_inbox_outlined, size: 40),
              SizedBox(height: 20),
              Text('New  Order'.tr,
                      style:
                          TextStyle(fontFamily: AppFonts.segoeui, fontSize: 13))
                  .translate(),
              SizedBox(height: 7),
              Text('$new_order',
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.bold,
                          fontSize: 30))
                  .translate(),
            ], mainAxisAlignment: MainAxisAlignment.center),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: blueGrey.withOpacity(0.1),
                      offset: Offset(3, 3),
                      blurRadius: 7,
                      spreadRadius: 3),
                  BoxShadow(
                      color: blueGrey.withOpacity(0.1), offset: Offset(-1, -1))
                ],
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : AppColors.blackColor,
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(width: 15),
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Container(
                child: Row(
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 40,
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Delivered Orders'.tr,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 8.sp))
                              .translate(),
                          SizedBox(height: 4),
                          Text('$delivered',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30))
                              .translate(),
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center),
                decoration: BoxDecoration(
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
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    borderRadius: BorderRadius.circular(20)),
              )),
              SizedBox(height: 15),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('On Delivery'.tr,
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 11))
                              .translate(),
                          SizedBox(height: 4),
                          Text('$on_delivery',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30))
                              .translate(),
                        ],
                      ),
                      decoration: BoxDecoration(
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cancel Order'.tr,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 11))
                              .translate(),
                          SizedBox(height: 4),
                          Text('$cancel_order',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30))
                              .translate(),
                        ],
                      ),
                      decoration: BoxDecoration(
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ))
            ],
          )),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
