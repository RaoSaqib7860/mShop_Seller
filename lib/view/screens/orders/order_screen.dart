import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/order/my_order_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/order_bloc/my_order_blocs/my_order_bloc.dart';
import '../../../view_model/order_bloc/my_order_blocs/my_order_event.dart';
import '../../../view_model/order_bloc/my_order_blocs/my_order_state.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/app_font.dart';
import '../globle_shimmer_effect/shimmer_effect_class.dart';
import 'order_detail.dart';

class OrderScreen extends StatefulWidget {
  final bool? isBack;
  const OrderScreen({Key? key, this.isBack = false}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  MyOrdersBloc ordersBloc = MyOrdersBloc(MyOrdersInitialState());
  StreamSubscription? subscription;
  @override
  void initState() {
    ordersBloc.add(MyOrdersEvent());
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            ordersBloc.add(MyOrdersEvent());
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  List listofApiStatus = [
    'pending'.tr,
    'confirmed'.tr,
    'picked_up'.tr,
    'on_the_way'.tr,
    'delivered'.tr,
  ];
  List listofStatus = [
    'Received'.tr,
    'Confirmed'.tr,
    'Processed'.tr,
    'Shipped'.tr,
    'Delivered'.tr,
  ];

  List buttonColors = [
    Color(0xff40E0D0),
    Color(0xff6495ED),
    Color(0xffCCCCFF),
    Color(0xffFF7F50),
    Color(0xff40C057),
  ];

  var refreshController_all = RefreshController(initialRefresh: false);
  var refreshController_delivered = RefreshController(initialRefresh: false);
  var refreshController_cancelled = RefreshController(initialRefresh: false);

  DateFormat dateFormat = DateFormat("dd:mm:yyyy");
  int active_page = 1;
  int active_count = 20;
  int delivered_page = 1;
  int delivered_count = 20;
  int canceled_page = 1;
  int canceled_count = 20;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          elevation: 0,
          centerTitle: true,
          leading: !widget.isBack!
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
          title: Text(
            'Orders'.tr,
            style: TextStyle(
              fontFamily: AppFonts.segoeui,
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, v) {
            return [
              SliverPersistentHeader(
                  pinned: true, floating: true, delegate: MyTab())
            ];
          },
          floatHeaderSlivers: true,
          physics: NeverScrollableScrollPhysics(),
          body: TabBarView(
            children: [
              BlocConsumer<MyOrdersBloc, MyOrdersStates>(
                bloc: ordersBloc,
                listener: (context, state) {
                  if (state is MyOrdersErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is MyOrdersLoadingState) {
                    return Center(
                        child: Center(child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: ShimmerOrders())));
                  } else if (state is MyOrdersLoadedState) {
                    return Oders(
                        context: context,
                        model: state.response,
                        refreshController: refreshController_all,
                        tab_name: 'Active',
                        state: state);
                  } else {
                    return Center(child: Text('data Not Loaded....'.tr));
                  }
                },
              ),
              BlocConsumer<MyOrdersBloc, MyOrdersStates>(
                bloc: ordersBloc,
                listener: (context, state) {
                  if (state is MyOrdersErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is MyOrdersLoadingState) {
                    return Center(
                        child: Center(child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: ShimmerOrders())));
                  } else if (state is MyOrdersLoadedState) {
                    return Oders(
                        context: context,
                        model: state.response_delivered,
                        refreshController: refreshController_delivered,
                        tab_name: 'Delivered',
                        state: state);
                  } else {
                    return Center(child: Text('data Not Loaded....'.tr));
                  }
                },
              ),
              BlocConsumer<MyOrdersBloc, MyOrdersStates>(
                bloc: ordersBloc,
                listener: (context, state) {
                  if (state is MyOrdersErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is MyOrdersLoadingState) {
                    return Center(
                        child: Center(child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: ShimmerOrders())));
                  } else if (state is MyOrdersLoadedState) {
                    return Oders(
                        context: context,
                        model: state.response_cancelled,
                        refreshController: refreshController_cancelled,
                        tab_name: 'Canceled',
                        state: state);
                  } else {
                    return Center(child: Text('data Not Loaded....'.tr));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Oders(
      {required MyOrderModel model,
      required BuildContext context,
      required RefreshController refreshController,
      String? tab_name,
      MyOrdersLoadedState? state}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (model.data == null || model.data!.length == 0) {
      return Center(
        child: Text('No Orders'),
      );
    }
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Expanded(
            child: RefreshControllerGlobal(
              controller: refreshController,
              onLoad: () async {
                if (tab_name == 'Active') {
                  active_page = active_page + 1;
                  active_count = active_count + 20;
                  MyOrderModel response = await DataProvider().myOrderFunction(
                      page: '${active_page}',
                      status: 'pending,confirmed,picked_up,on_the_way',
                      count: '${active_count}');
                  state!.response.data!.addAll(response.data!);
                } else if (tab_name == 'Delivered') {
                  delivered_page = delivered_page + 1;
                  delivered_count = delivered_count + 20;
                  MyOrderModel response_delivered = await DataProvider()
                      .myOrderFunction(
                          page: '${delivered_page}',
                          status: 'delivered',
                          count: '${delivered_count}');
                  state!.response_delivered.data!
                      .addAll(response_delivered.data!);
                } else {
                  canceled_page = delivered_page + 1;
                  canceled_count = canceled_count + 20;
                  MyOrderModel response_cancel = await DataProvider()
                      .myOrderFunction(
                          page: '$delivered_page',
                          status: 'cancelled',
                          count: '$canceled_count');
                  state!.response_cancelled.data!.addAll(response_cancel.data!);
                }
                setState(() {});
                refreshController.loadComplete();
              },
              onRefresh: () async {
                active_page = 1;
                active_count = 20;
                delivered_page = 1;
                delivered_count = 20;
                canceled_page = 1;
                canceled_count = 20;
                ordersBloc.add(MyOrdersEvent());
                refreshController.refreshCompleted();
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  int index_of = listofApiStatus
                      .indexOf(model.data![index].deliveryStatus);
                  return Column(
                    children: [
                      SizedBox(height: 1.0.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetail(
                                  Id: model.data![index].id.toString(),
                                  link: '',
                                  boyName: model.data![index].deliveryBoy ==
                                          null
                                      ? ''
                                      : model.data![index].deliveryBoy!.name,
                                  wareHouseName:
                                      model.data![index].pickupPoint == null
                                          ? ''
                                          : model.data![index].pickupPoint!
                                              .warehouseName,
                                ),
                              )).then((value) {
                            if (value == true) {
                              ordersBloc.add(MyOrdersEvent());
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          // height: 34.h,
                          padding: const EdgeInsets.symmetric(vertical: 15),
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
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: 'Order ID  '.tr,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                recognizer:
                                                    new TapGestureRecognizer(),
                                                text:
                                                    '${model.data![index].id}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                          height: 3.h,
                                          width: 10.h,
                                          child: Center(
                                            child: Text(
                                              '${index_of == -1 ? 'Cancelled' : listofStatus[index_of]}',
                                              style: TextStyle(
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: index_of == -1
                                                  ? Colors.red
                                                  : buttonColors[index_of]),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 14,
                                          //color: const Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Order Code:  '.tr,
                                            style: TextStyle(
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 14),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                new TapGestureRecognizer(),
                                            // ..onTap = () {
                                            //   widget.onSignUp!;
                                            //},
                                            text:
                                                '${model.data![index].orderNumber}',
                                            style: TextStyle(
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Payment Status: '),
                                        Text(
                                          model.data![index].paymentStatus ==
                                                  'paid'
                                              ? 'Paid'
                                              : 'Unpaid',
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Order Date :'.tr +
                                      ' ${model.data![index].orderDate}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'Payment Method :' +
                                        '  ${model.data![index].paymentMethod}',
                                    style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 14),
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  'Delivery Status : ' +
                                      '${index_of == -1 ? 'Cancel' : listofStatus[index_of]}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  'Delivered by : ' +
                                      '${model.data![index].deliveredBySeller == 2 ? 'Not Assigned' : model.data![index].deliveredBySeller == 1 ? 'Seller' : 'Housy'}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(height: 5),
                              const Padding(
                                padding: EdgeInsets.only(left: 18, right: 18),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 8.h,
                                            width: 7.2.h,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${model.data![index].combineOrders![0].thumbnail}",
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.blue,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Visibility(
                                            child: Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: CircularProfileAvatar(
                                                '',
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.3)),
                                                  child: Center(
                                                    child: Text(
                                                      '${model.data![index].numberOfProducts! > 1 ? '+${model.data![index].numberOfProducts! - 1}' : '1'}',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                radius: 12,
                                              ),
                                            ),
                                            visible: model.data![index]
                                                    .numberOfProducts! >
                                                1,
                                          ),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 23.h,
                                          child: Text(
                                            "${model.data![index].combineOrders![0].productTitle}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                //color: const Color(0xff524EB7),
                                                fontFamily: AppFonts.segoeui,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${model.data![index].grandTotal}',
                                      style: TextStyle(
                                          color: const Color(0xff524EB7),
                                          fontFamily: AppFonts.segoeui,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      )
                    ],
                  );
                },
                itemCount: model.data!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTab extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double, bool) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      child: Column(
        children: [
          TabBar(
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: Container(
                    height: 20,
                    width: 60,
                    child: Center(
                      child: Text(
                        'Active'.tr,
                        style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 12,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      width: 65,
                      child: Center(
                        child: Text(
                          'Delivered'.tr,
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 12,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      height: 20,
                      width: 90,
                      child: Center(
                        child: Text(
                          'Canceled'.tr,
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 12,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
              indicatorColor: blueGrey),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 75;
  @override
  double minExtent = 75;
}
