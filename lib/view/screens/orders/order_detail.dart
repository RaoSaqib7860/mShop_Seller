import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mShop_Seller/extentions/app_colors.dart';
import 'package:mShop_Seller/model/delivery_model/delivery_model_list.dart'
    as model_warehouse;
import 'package:mShop_Seller/view/global_widgets/web_view_global.dart';
import 'package:mShop_Seller/view/screens/orders/repository_orders.dart';
import '../../../model/order/company_type.dart' as company_type;
import '../../../api_repo/api_utils.dart';
import '../../../model/delivery_model/delivery_model_list.dart'
    as delivery_model;
import '../../../model/delivery_model/delivery_model_list.dart';
import '../../../model/order/order_detail_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/order_bloc/order_detail_bloc/order_detail_bloc.dart';
import '../../../view_model/order_bloc/order_detail_bloc/order_detail_event.dart';
import '../../../view_model/order_bloc/order_detail_bloc/order_detail_state.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/app_font.dart';
import '../../global_widgets/cupertino_dialog.dart';

class OrderDetail extends StatefulWidget {
  final String? Id;
  final String? link;
  final String? boyName;
  final String? wareHouseName;
  const OrderDetail(
      {Key? key, this.Id, this.link, required this.boyName, this.wareHouseName})
      : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> with orderDetailRepository {
  int STEPS = 5;
  final pageController = PageController();
  List textList = [
    'Ordered'.tr,
    'Ordered'.tr,
    'Ordered'.tr,
    'Ordered'.tr,
    'Ordered'.tr,
  ];
  int initialPage = 0;
  String? boyname;
  List listofStatus = [
    'Order'.tr,
    'Receive'.tr,
    'Process'.tr,
    'Ship'.tr,
    'Deliver'.tr,
  ];
  var refreshController = RefreshController(initialRefresh: false);
  OrdersDetailBloc ordersDetailBloc =
      OrdersDetailBloc(OrdersDetailInitialState());
  StreamSubscription? subscription;
  @override
  void initState() {
    boyname = widget.boyName;
    getDeliveryBoyList();
    get_wareHouse_list();
    ordersDetailBloc.add(OrdersDetailEvent(Id: widget.Id));
    //get_ware_house();
    selected_data = delivery_model.Data(
      name: boyname,
    );
    selected_warehouse =
        delivery_model.Warehouses(warehouseName: widget.wareHouseName);
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            boyname = widget.boyName;
            getDeliveryBoyList();
            get_wareHouse_list();
            ordersDetailBloc.add(OrdersDetailEvent(Id: widget.Id));
            //get_ware_house();
            selected_data = delivery_model.Data(
              name: boyname,
            );
            selected_warehouse =
                delivery_model.Warehouses(warehouseName: widget.wareHouseName);
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  bool assign = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(assign == true ? true : null);
            }),
        title: Text(
          'Order Detail'.tr,
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<OrdersDetailBloc, OrdersDetailStates>(
        bloc: ordersDetailBloc,
        listener: (context, state) {
          if (state is OrdersDetailErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is OrdersDetailLoadingState) {
            return Center(child: Shimmer.fromColors(
                child: ShimmerOrderDetailUi(),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100
            ));
          } else if (state is OrdersDetailLoadedState) {
            if (state.response.data!.deliveredByHousy != 2 &&
                state.response.data!.deliveredBySeller != 2) {
              if (state.response.data!.deliveredByHousy == 1) {
                deliverd_by = 'Housy'.tr;
              } else {
                deliverd_by = 'Seller'.tr;
              }
            }
            selected_status = state.response.data!.paymentStatus;
            selected_order_status = state.response.data!.deliveryStatus;
            if (state.response.data!.deliveredByHousy == 1 &&
                selected_ware_house == null &&
                state.response.data!.pickup_point != null) {
              selected_ware_house = model_warehouse.Warehouses.fromJson(
                  state.response.data!.pickup_point!.toJson());
            }
            if (state.response.data!.delivery_package != null) {
              selected_company_type = company_type.Data(
                  id: state.response.data!.delivery_package!.id,
                  title: state.response.data!.delivery_package!.title);
            }
            return orderDetailUi(
                detailModel: state.response, context: context, state: state);
          } else {
            return Center(child: Text('data Not Loaded....'.tr).translate());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  List<String> list_of_status = ['Paid'.tr, 'Un Paid'.tr];
  String? selected_status;
  List<String> list_of_delivery_company = ['Company 1'.tr, 'Company 2'.tr];
  String? selected_delivery_company;
  List<String> list_of_order_status = [
    'Pending'.tr,
    'Confirmed'.tr,
    'Picked Up'.tr,
    'On The Way'.tr,
    'Delivered'.tr
  ];
  String? selected_order_status;
  String? deliverd_by = '';
  List listofApiStatus = [
    'pending'.tr,
    'confirmed'.tr,
    'picked_up'.tr,
    'on_the_way'.tr,
    'delivered'.tr,
  ];
  DeliveryBoyList? deliveryBoyList;
  List<delivery_model.Data> list_of_selected_wearhouse = [];
  List<delivery_model.Warehouses>? selected_warehouses = [];
  delivery_model.Data? selected_data;
  delivery_model.Warehouses? selected_warehouse;
  Future getDeliveryBoyList() async {
    deliveryBoyList = await DataProvider().getDeliveryBoyListFunction();
    list_of_selected_wearhouse = deliveryBoyList!.data!;
    setState(() {});
  }

  Widget orderDetailUi(
      {required OrderDetailModel detailModel,
      required BuildContext context,
      OrdersDetailLoadedState? state}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return RefreshControllerGlobal(
      controller: refreshController,
      onLoad: () {
        refreshController.loadComplete();
      },
      onRefresh: () async {
        ordersDetailBloc.add(OrdersDetailEvent(Id: widget.Id));
        refreshController.refreshCompleted();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text('Delivered By'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFonts.segoeui))
                                .translate(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewGlobal(
                                            url: state!
                                                .response.data!.invoiceLink,
                                          ),
                                        ));
                                    print(
                                        'veiw Invoice${state!.response.data!.invoiceLink}');
                                  },
                                  child: Container(
                                    height: 3.h,
                                    width: 25.w,
                                    child: Center(
                                      child: Text(
                                        'View invoice'.tr,
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff524EB7)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      IgnorePointer(
                        ignoring: deliverd_by!.isNotEmpty,
                        child: Row(
                          children: [
                            Checkbox(
                                value: deliverd_by == 'Seller'.tr,
                                onChanged: (v) {
                                  show_cupertino_alert(
                                      context: context,
                                      title:
                                          'If you update the Delivered-By status, it is unchanged able.'
                                              .tr,
                                      ok: () {
                                        deliverd_by = 'Seller'.tr;
                                        state!.response.data!
                                            .deliveredBySeller = 1;
                                        state.response.data!.deliveredByHousy =
                                            0;
                                        setState(() {});
                                        DataProvider.update_delivarable_by_api(
                                            id: widget.Id,
                                            object: {
                                              'delivered_by_seller'.tr: '1',
                                              'delivered_by_housy'.tr: '0'
                                            });
                                      });
                                }),
                            Text('Seller'.tr,
                                    style:
                                        TextStyle(fontFamily: AppFonts.segoeui))
                                .translate(),
                            Checkbox(
                                value: deliverd_by == 'Housy'.tr,
                                onChanged: (v) {
                                  show_cupertino_alert(
                                      context: context,
                                      title:
                                          'If you update the Delivered-By status, it is unchanged able.'
                                              .tr,
                                      ok: () {
                                        state!.response.data!
                                            .deliveredBySeller = 0;
                                        state.response.data!.deliveredByHousy =
                                            1;
                                        deliverd_by = 'Housy'.tr;
                                        DataProvider.update_delivarable_by_api(
                                            id: widget.Id,
                                            object: {
                                              'delivered_by_seller'.tr: '0',
                                              'delivered_by_housy'.tr: '1'
                                            });
                                        setState(() {});
                                      });
                                }),
                            Text('Housy'.tr,
                                style: TextStyle(fontFamily: AppFonts.segoeui)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      if (deliverd_by != '')
                        deliverd_by == 'Seller'.tr
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: IgnorePointer(
                                          ignoring: selected_status != 'paid'.tr
                                              ? false
                                              : true,
                                          child: Column(
                                            children: [
                                              Text('Payment Status'.tr),
                                              SizedBox(height: 3),
                                              Container(
                                                width: width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.5),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton<dynamic>(
                                                    items: list_of_status
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          dynamic>(
                                                        value: value,
                                                        child: Text('${value}')
                                                            .translate(),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                            selected_status ==
                                                                    null
                                                                ? 'Payment Status'
                                                                    .tr
                                                                : '${selected_status}',
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                        .translate(),
                                                    onChanged: (data) {
                                                      selected_status = data;
                                                      state!.response.data!
                                                              .paymentStatus =
                                                          selected_status;
                                                      setState(() {});
                                                      DataProvider
                                                          .update_payment_status_api({
                                                        'id': widget.Id
                                                            .toString(),
                                                        'payment_status'.tr:
                                                            selected_status ==
                                                                    'Paid'
                                                                ? 'paid'
                                                                : 'unpaid'
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IgnorePointer(
                                          ignoring: selected_order_status !=
                                                  'Delivered'
                                              ? false
                                              : true,
                                          child: Column(
                                            children: [
                                              Text('Delivery Status'.tr),
                                              SizedBox(height: 3),
                                              Container(
                                                width: width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.5),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton<dynamic>(
                                                    items: list_of_order_status
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          dynamic>(
                                                        value: value,
                                                        child: Text('${value}')
                                                            .translate(),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                            selected_order_status ==
                                                                    null
                                                                ? 'Order Status'
                                                                    .tr
                                                                : '${selected_order_status}',
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                        .translate(),
                                                    onChanged: (data) {
                                                      print(
                                                          '${selected_status}');
                                                      if (selected_status ==
                                                              'Un Paid' &&
                                                          data == 'Delivered') {
                                                        snackBarFailer(
                                                            'Payment not received');
                                                      } else {
                                                        print(
                                                            '${selected_status}');
                                                        print('${data}');
                                                        selected_order_status =
                                                            data;
                                                        state!.response.data!
                                                                .deliveryStatus =
                                                            selected_order_status;
                                                        setState(() {});
                                                        int index =
                                                            list_of_order_status
                                                                .indexOf(
                                                                    selected_order_status!);
                                                        print(
                                                            '${selected_order_status}');
                                                        DataProvider
                                                            .update_delivery_status_api({
                                                          'id': widget.Id
                                                              .toString(),
                                                          'delivery_status':
                                                              listofApiStatus[
                                                                  index]
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text('Assign Delivery Boy',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500))
                                      .translate(),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text('Select Delivery boy'.tr)
                                                .translate(),
                                            SizedBox(height: 3),
                                            Container(
                                              width: width,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: const Color(0xffffffff),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade300
                                                        .withOpacity(0.5),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: IgnorePointer(
                                                ignoring: !widget
                                                        .wareHouseName!.isEmpty
                                                    ? true
                                                    : false,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton<dynamic>(
                                                    items:
                                                        list_of_selected_wearhouse
                                                            .map((value) {
                                                      return DropdownMenuItem<
                                                          dynamic>(
                                                        value: value,
                                                        child: Text(
                                                                '${value.name}')
                                                            .translate(),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                            selected_data !=
                                                                    null
                                                                ? '${selected_data!.name}'
                                                                : 'Select WareHouse',
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                        .translate(),
                                                    onChanged: (data) {
                                                      selected_data = data
                                                          as delivery_model
                                                              .Data;
                                                      if (selected_warehouse !=
                                                          null) {
                                                        selected_warehouses!
                                                            .forEach((element) {
                                                          wareHouseModel!.data!
                                                              .remove(element);
                                                        });
                                                      }
                                                      selected_warehouses =
                                                          selected_data!
                                                              .warehouses!;
                                                      selected_warehouses!
                                                          .forEach((element) {
                                                        wareHouseModel!.data!
                                                            .insert(0, element);
                                                      });
                                                      setState(() {});
                                                    },
                                                    isExpanded: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text('Select WareHouse'.tr),
                                            SizedBox(height: 3),
                                            IgnorePointer(
                                              ignoring: !widget
                                                      .wareHouseName!.isNotEmpty
                                                  ? false
                                                  : true,
                                              child: Container(
                                                width: width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.5),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: wareHouseModel == null
                                                    ? SizedBox()
                                                    : DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            dynamic>(
                                                          items: wareHouseModel!
                                                              .data!
                                                              .map((value) {
                                                            return DropdownMenuItem<
                                                                dynamic>(
                                                              value: value,
                                                              child: selected_data!
                                                                              .warehouses !=
                                                                          null &&
                                                                      selected_data!
                                                                          .warehouses!
                                                                          .contains(
                                                                              value)
                                                                  ? Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              10,
                                                                          width:
                                                                              10,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                5),
                                                                        Text('${value.warehouseName}')
                                                                            .translate()
                                                                      ],
                                                                    )
                                                                  : Text('${value.warehouseName}')
                                                                      .translate(),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                              selected_warehouse !=
                                                                      null
                                                                  ? '${selected_warehouse!.warehouseName}'
                                                                  : 'Warehouse'),
                                                          onChanged: (data) {
                                                            selected_warehouse =
                                                                data;
                                                            setState(() {});
                                                          },
                                                          isExpanded: true,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: InkWell(
                                      onTap: () async {
                                        if (selected_data!.id != null &&
                                            selected_warehouse!.id != null) {
                                          DataProvider()
                                              .getDeliveryAssign(map: {
                                            'delivery_boy_id':
                                                '${selected_data!.id}',
                                            'order_id': '${widget.Id}',
                                            'pickup_point_id':
                                                '${selected_warehouse!.id}',
                                          });
                                          assign = true;
                                          setState(() {});
                                        } else {
                                          snackBarFailer(
                                              'Select delivery boy and warehouse first.');
                                        }
                                      },
                                      child: Container(
                                        height: 5.h,
                                        width: 80.w,
                                        child: Center(
                                            child: Text(
                                          assign || boyname!.isNotEmpty
                                              ? 'Reassign'
                                              : 'Assign',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: wareHouseModel == null ||
                                            wareHouseModel!.data == null
                                        ? SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('  Warehouse',
                                                      style: TextStyle())
                                                  .translate(),
                                              SizedBox(height: 10),
                                              Container(
                                                width: width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.5),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton<dynamic>(
                                                    items: wareHouseModel!.data!
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          dynamic>(
                                                        value: value,
                                                        child: Text(
                                                                '${value.warehouseName}')
                                                            .translate(),
                                                      );
                                                    }).toList(),
                                                    hint: Builder(
                                                        builder: (context) {
                                                      return Text(
                                                              selected_ware_house ==
                                                                      null
                                                                  ? 'Warehouses'
                                                                      .tr
                                                                  : '${selected_ware_house!.warehouseName}',
                                                              style: TextStyle(
                                                                  fontSize: 12))
                                                          .translate();
                                                    }),
                                                    onChanged: (data) {
                                                      selected_ware_house =
                                                          data;
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: company_type_model == null ||
                                            company_type_model!.data == null
                                        ? SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Delivery type',
                                                  style: TextStyle()),
                                              SizedBox(height: 10),
                                              Container(
                                                width: width,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .grey.shade300
                                                          .withOpacity(0.5),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton<dynamic>(
                                                    items: company_type_model!
                                                        .data!
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          dynamic>(
                                                        value: value,
                                                        child: Text(
                                                                '${value.title}')
                                                            .translate(),
                                                      );
                                                    }).toList(),
                                                    hint: Builder(
                                                        builder: (context) {
                                                      return Text(
                                                          selected_company_type ==
                                                                  null
                                                              ? 'Delivery type'
                                                                  .tr
                                                              : '${selected_company_type!.title}',
                                                          style: TextStyle(
                                                              fontSize: 12));
                                                    }),
                                                    onChanged: (data) {
                                                      selected_company_type =
                                                          data;
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  (detailModel.data!.deliveredByHousy == 1 &&
                                          selected_ware_house != null &&
                                          detailModel.data!.pickup_point !=
                                              null)
                                      ? SizedBox()
                                      : Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 25),
                                              InkWell(
                                                onTap: () async {
                                                  await DataProvider()
                                                      .getSelectedWearHouse(
                                                          map: {
                                                        'warehouse_id':
                                                            '${selected_ware_house!.id}',
                                                        'order_id':
                                                            '${widget.Id}',
                                                        'company_type':
                                                            '${selected_company_type!.id}'
                                                      });
                                                  assign = true;
                                                  ordersDetailBloc.add(
                                                      OrdersDetailEvent(
                                                          Id: widget.Id));
                                                },
                                                child: Container(
                                                    height: 5.h,
                                                    width: width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Colors.blueGrey,
                                                      //color: const Color(0xffffffff),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade300
                                                              .withOpacity(0.5),
                                                          offset: Offset(0, 3),
                                                          blurRadius: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                              detailModel.data!
                                                                              .deliveredByHousy ==
                                                                          1 &&
                                                                      selected_ware_house !=
                                                                          null &&
                                                                      detailModel
                                                                              .data!
                                                                              .pickup_point !=
                                                                          null
                                                                  ? 'Reassign'
                                                                  : 'Assign',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))
                                                          .translate(),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
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
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Order  ID :'.tr + ' ${widget.Id}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Order  Code :'.tr +
                                ' ${detailModel.data!.orderCode}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ).translate(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Placed on :'.tr +
                                ' ${detailModel.data!.orderDate}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Payment Type :'.tr +
                                  '  ${detailModel.data!.paymentType}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Payment Status :'.tr +
                                  '  ${detailModel.data!.paymentStatus}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Tax :'.tr + '  ${detailModel.data!.tax}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Shipping :'.tr +
                                  '  ${detailModel.data!.shippingCost}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Coupon :'.tr +
                                  '  ${detailModel.data!.couponDiscount}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Sub Total :'.tr +
                                  '  ${detailModel.data!.subtotal}',
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui, fontSize: 14),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: Text(
                            'Total :'.tr + ' ${detailModel.data!.total}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          child: Text(
                            'Service Fee :'.tr + ' ${detailModel.data!.service_fee}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: detailModel.data!.delivery_company_detail != null,
                  child: ListTile(
                    title: Text('Delivery company detail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        )),
                  ),
                ),
                Visibility(
                  visible: detailModel.data!.delivery_company_detail != null,
                  child: detailModel.data!.delivery_company_detail == null
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: double.infinity,
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
                                SizedBox(
                                  height: 1.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
                                  child: Text('Name :'.tr +
                                      ' ${detailModel.data!.delivery_company_detail!.name}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
                                  child: Text('Email :'.tr +
                                      ' ${detailModel.data!.delivery_company_detail!.email}'),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                        Uri.parse(
                                            "tel://+971${detailModel.data!.delivery_company_detail!.phone}"),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Mobile :'.tr,
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          ' +971${detailModel.data!.delivery_company_detail!.phone}',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                if(detailModel.data!.shippingAddress!=null)
                ListTile(
                  title: Text('Customer Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      )),
                ),
                if(detailModel.data!.shippingAddress!=null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
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
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          child: Text(
                            'Name :'.tr +
                                ' ${detailModel.data!.shippingAddress!.name}',
                            style: TextStyle(
                                fontFamily: AppFonts.segoeui, fontSize: 14),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(
                                Uri.parse(
                                    "tel://+971${detailModel.data!.shippingAddress!.phone}"),
                                mode: LaunchMode.externalApplication);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            child: Row(
                              children: [
                                Text(
                                  'Mobile :'.tr,
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                                Text(
                                  ' +971${detailModel.data!.shippingAddress!.phone}',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          child: Text('Address :'.tr +
                                  ' ${detailModel.data!.shippingAddress!.address}')
                              .translate(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          child: Text('City :'.tr +
                                  ' ${detailModel.data!.shippingAddress!.city}')
                              .translate(),
                        ),
                        InkWell(
                          onTap: () async {
                            await launchUrl(
                                Uri.parse(
                                    '${detailModel.data!.shippingAddress!.location}'),
                                mode: LaunchMode.externalApplication);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            child: Row(
                              children: [
                                Text(
                                  'View in Google Map',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Order Items  '.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      )).translate(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Column(
                            children: detailModel.data!.orderItems!.map((e) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .push(MaterialPageRoute(
                                  //     builder: (c) => ProductDetailPage(
                                  //       Id: e.
                                  //           .toString(),
                                  //     )));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewGlobal(
                                          url: e.link,
                                          title: 'Housy',
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        child: Container(
                                          height: 8.h,
                                          width: 7.2.h,
                                          child: CachedNetworkImage(
                                            imageUrl: "${e.thumbnail}",
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.name}",
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontWeight: FontWeight.w600),
                                            ).translate(),
                                            Text(
                                              "Quantity : ${e.qTY}".tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ).translate(),
                                            Text(
                                              " ${e.description}",
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ).translate(),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${e.price}'.tr,
                                        style: TextStyle(
                                            color: const Color(0xff524EB7),
                                            fontFamily: AppFonts.segoeui,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ShimmerOrderDetailUi() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child:Container(
                            height: 2.h,
                            width: 20.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 3.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.grey.shade300),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 3.h,
                          width: 5.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 2.w,),
                        Container(
                          height: 2.h,
                          width: 9.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 2.w,),
                        Container(
                          height: 3.h,
                          width: 5.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 2.w,),
                        Container(
                          height: 2.h,
                          width: 9.w,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 2.h,
                                width: 20.w,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 5.h,
                                width: 40.w,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 2.h,
                                width: 20.w,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 5.h,
                                width: 40.w,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      height: 2.5.h,
                      width: 20.w,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 2.h,
                                width: 20.w,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 5.h,
                                width: 40.w,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 2.h,
                                width: 20.w,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 5.h,
                                width: 40.w,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Center(
                      child: Container(
                        height: 4.h,
                        width: 70.w,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 2.h,)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: blueGrey.withOpacity(0.1),
                      //       offset: Offset(3, 3),
                      //       blurRadius: 7,
                      //       spreadRadius: 3),
                      //   BoxShadow(
                      //       color: blueGrey.withOpacity(0.1),
                      //       offset: Offset(-1, -1))
                      // ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 20.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 2.h,
                          width: 25.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
                ListTile(
                  title: Container(
                    height: 2.5.h,
                    width: 23.w,
                    color: Colors.grey.shade300,
                  ),
                ),
              SizedBox(height: 2.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: blueGrey.withOpacity(0.1),
                        //       offset: Offset(3, 3),
                        //       blurRadius: 7,
                        //       spreadRadius: 3),
                        //   BoxShadow(
                        //       color: blueGrey.withOpacity(0.1),
                        //       offset: Offset(-1, -1))
                        // ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: 0.5.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: 0.5.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: 0.5.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: 0.5.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 2.h,
                            width: 25.w,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                title: Container(
                  height: 2.5.h,
                  width: 30.w,
                  color: Colors.grey.shade300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: blueGrey.withOpacity(0.1),
                      //       offset: Offset(3, 3),
                      //       blurRadius: 7,
                      //       spreadRadius: 3),
                      //   BoxShadow(
                      //       color: blueGrey.withOpacity(0.1),
                      //       offset: Offset(-1, -1))
                      // ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Column(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      height: 8.h,
                                      width: 7.2.h,
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 2.h,
                                          width: 25.w,
                                          color: Colors.grey.shade300,
                                        ),
                                        SizedBox(height: 0.5.h,),
                                      Container(
                                        height: 1.7.h,
                                        width: 15.w,
                                        color: Colors.grey.shade300,
                                      ),
                                        SizedBox(height: 0.5.h,),
                                    Container(
                                      height: 1.7.h,
                                      width: 5.w,
                                      color: Colors.grey.shade300,
                                    ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 10.w,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
