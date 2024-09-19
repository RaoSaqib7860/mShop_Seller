import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mShop_Seller/view/screens/WareHouse%20List/repository.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/all_ware_house/all_ware_house_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/get_ware_house_blocs/get_ware_house_bloc.dart';
import '../../../view_model/get_ware_house_blocs/get_ware_house_events.dart';
import '../../../view_model/get_ware_house_blocs/get_ware_house_state.dart';
import '../../conectivity/connectivity.dart';
import '../globle_shimmer_effect/shimmer_effect_class.dart';
import 'Add WareHouse/add_ware_house_screen.dart';

class WareHouseListScreen extends StatefulWidget {
  const WareHouseListScreen({Key? key}) : super(key: key);

  @override
  State<WareHouseListScreen> createState() => _WareHouseListScreenState();
}

class _WareHouseListScreenState extends State<WareHouseListScreen>
    with getWarehousePagination {
  StreamSubscription? subscription;
  @override
  void initState() {
    page = 1;
    wareHouseListBloc.add(MyWareHouseListEvent(page: page, count: count));
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            page = 1;
            wareHouseListBloc.add(MyWareHouseListEvent(page: page, count: count));
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  var appBarHeight = AppBar().preferredSize.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
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
        title: Text(
          'All Warehouses',
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddWareHouse(
                  tag: 'add',
                ),))!
                    .then((value) {
                  if (value == 'add') {
                    wareHouseListBloc.add(MyWareHouseListEvent());
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
      body: BlocConsumer<MyWareHouseListBloc, MyWareHouseListStates>(
        bloc: wareHouseListBloc,
        listener: (context, state) {
          if (state is MyWareHouseListErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is MyWareHouseListLoadingState) {
            return Center(
                child: Center(child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ShimmerWarehouse())));
          } else if (state is MyWareHouseListLoadedState) {
            return wareHousesList(
                onLoad: () async {
                  allWareHouseModel res = await getwarehouse();
                  state.response!.data!.dataView!.addAll(res.data!.dataView!);
                  setState(() {});
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  page = 1;
                  allWareHouseModel res = await DataProvider()
                      .ware_house_all_api(page: page, count: count);
                  state.response!.data!.dataView = res.data!.dataView;
                  setState(() {});
                  refreshController.refreshCompleted();
                },
                context: context,
                model: state.response!);
          } else {
            return Center(child: Text('data Not Loaded....'));
          }
        },
      ),
    );
  }

  Widget wareHousesList({
    required allWareHouseModel model,
    required BuildContext context,
    Function()? onRefresh,
    Function()? onLoad,
  }) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (model.data!.dataView!.isEmpty) {
      return Center(child: Text('No Data'));
    }
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Expanded(
            child: RefreshControllerGlobal(
              controller: refreshController,
              onLoad: onLoad,
              onRefresh: onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                            //color: const Color(0xff000000),
                                          ),
                                          children: [
                                            TextSpan(
                                              recognizer:
                                                  new TapGestureRecognizer(),
                                              // ..onTap = () {
                                              //   widget.onSignUp!;
                                              //},
                                              text:
                                                  '${model.data!.dataView![index].warehouseName}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
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
                                        onSelected: (value) {
                                          // your logic
                                        },
                                        itemBuilder: (BuildContext bc) {
                                          return [
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    await _dialogBuilder(
                                                            index: model
                                                                .data!
                                                                .dataView![
                                                                    index]
                                                                .id,
                                                            context: bc,
                                                            detailModel: model)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                      page = 1;
                                                      wareHouseListBloc.add(
                                                          MyWareHouseListEvent(
                                                              page: page,
                                                              count: count));
                                                    });
                                                    setState(() {});
                                                  },
                                                  child: Text("Remove")),
                                              value: '/Remove',
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.to(AddWareHouse(
                                                      tag: 'update',
                                                      name: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseName,
                                                      address: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseAddress,
                                                      state: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseState,
                                                      city: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseCity,
                                                      contact: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseContact,
                                                      location: model
                                                          .data!
                                                          .dataView![index]
                                                          .warehouseGoogleLocation,
                                                      id: model.data!
                                                          .dataView![index].id,
                                                    ))!
                                                        .then((value) {
                                                      if (value == 'update') {
                                                        Navigator.of(context)
                                                            .pop();
                                                        page = 1;
                                                        wareHouseListBloc.add(
                                                            MyWareHouseListEvent(
                                                                page: page,
                                                                count: count));
                                                      }
                                                    });
                                                  },
                                                  child: Text("Update")),
                                              value: '/Update',
                                            ),
                                          ];
                                        },
                                        icon: Icon(Icons.more_vert),
                                      )
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12,
                                        //color: const Color(0xff000000),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Warehouse ID : '.tr,
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
                                              '${model.data!.dataView![index].id}',
                                          style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 14,
                                            color: Colors.black,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'WareHouse Address :' +
                                    ' ${model.data!.dataView![index].warehouseAddress}',
                                style: TextStyle(
                                    fontFamily: AppFonts.segoeui, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              child: Text(
                                'Contact No :' +
                                    ' +971${model.data!.dataView![index].warehouseContact}',
                                style: TextStyle(
                                    fontFamily: AppFonts.segoeui, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              child: Text(
                                'Country :' +
                                    ' ${model.data!.dataView![index].warehouseCountry}',
                                style: TextStyle(
                                    fontFamily: AppFonts.segoeui, fontSize: 14),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(
                                    Uri.parse(
                                        '${model.data!.dataView![index].warehouseGoogleLocation}'),
                                    mode: LaunchMode.externalApplication);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                child: Text(
                                  'View in Google Map',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      )
                    ],
                  );
                },
                itemCount: model.data!.dataView!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder({
    required BuildContext context,
    int? index,
    required allWareHouseModel detailModel,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure want to delete Warehouse?').translate(),
          actions: <Widget>[
            TextButton(
              child: const Text('No').translate(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes').translate(),
              onPressed: () async {
                await DataProvider().removeToWareHouseFunction(
                    map: {'warehouse_id': '${index}'});
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
