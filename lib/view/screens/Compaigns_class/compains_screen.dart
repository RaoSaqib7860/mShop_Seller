import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';
import 'package:mShop_Seller/view/screens/globle_shimmer_effect/shimmer_effect_class.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/Compaigns/compaign_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/campaigns_blocs/campaigns_bloc.dart';
import '../../../view_model/campaigns_blocs/campaigns_events.dart';
import '../../../view_model/campaigns_blocs/campaigns_states.dart';
import '../../conectivity/connectivity.dart';
import 'add_new_campaign.dart';
import 'campaign_detail.dart';
import 'campaing_list_repo.dart';

class CompaignScreen extends StatefulWidget {
  const CompaignScreen({Key? key}) : super(key: key);

  @override
  State<CompaignScreen> createState() => _CompaignScreenState();
}

//campaign
class _CompaignScreenState extends State<CompaignScreen>
    with getCompaingsPagination {
  StreamSubscription? subscription;
  @override
  void initState() {
    page = 1;
    myCompaignsBloc.add(MyCompaignsEvent(page: page, count: count));
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            page = 1;
            myCompaignsBloc.add(MyCompaignsEvent(page: page, count: count));
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
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
          'Campaign',
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 17,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ).translate(),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(NewCampaign(
                  tag: 'add',
                ))!
                    .then((value) {
                  if (value == 'add') {
                    myCompaignsBloc.add(MyCompaignsEvent());
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
      body: BlocConsumer<MyCompaignsBloc, MyCompaignsStates>(
        bloc: myCompaignsBloc,
        listener: (context, state) {
          if (state is MyCompaignsErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is MyCompaignsLoadingState) {
            return Center(
                child: Center(
                    child: Shimmer.fromColors(
                        child: ShimmerWarehouse(),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100
                    )
                ));
          } else if (state is MyCompaignsLoadedState) {
            return campaignUi(
                onLoad: () async {
                  CompaignModel res = await getCampaingList();
                  state.response!.data!.data!.addAll(res.data!.data!);
                  setState(() {});
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  page = 1;
                  CompaignModel res = await DataProvider()
                      .get_compaign_function(page: page, count: count);
                  state.response.data!.data = res.data!.data;
                  setState(() {});
                  refreshController.refreshCompleted();
                },
                context: context,
                state: state,
                compaignModel: state.response);
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

  Widget campaignUi(
      {required CompaignModel compaignModel,
      required BuildContext context,
      Function()? onRefresh,
      Function()? onLoad,
      required MyCompaignsLoadedState? state}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (compaignModel.data!.data!.isEmpty) {
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
                  // int index_of =
                  // listofApiStatus.indexOf(model.data![index].orderStatus);
                  return Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(CampaignDetailScreen(
                            name: compaignModel.data!.data![index].name,
                            discount: compaignModel.data!.data![index].discount,
                            discount_type:
                                compaignModel.data!.data![index].discountType,
                            startDate:
                                compaignModel.data!.data![index].startDate,
                            endDate: compaignModel.data!.data![index].endDate,
                            status: compaignModel.data!.data![index].isActive,
                            product_count:
                                compaignModel.data!.data![index].productIds,
                            campaignId: compaignModel.data!.data![index].id,
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
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
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '  ${compaignModel.data!.data![index].name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ).translate()
                                        ],
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
                                        icon: Icon(Icons.more_vert),
                                        onSelected: (value) {
                                          // your logic
                                        },
                                        itemBuilder: (BuildContext bc) {
                                          return [
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    bool result =
                                                        await DataProvider()
                                                            .update_new_campaign(
                                                                object: {
                                                          'name':
                                                              '${compaignModel.data!.data![index].name}',
                                                          'discount':
                                                              '${compaignModel.data!.data![index].discount}',
                                                          'discount_type':
                                                              '${compaignModel.data!.data![index].discountType}',
                                                          'start_date':
                                                              '${compaignModel.data!.data![index].startDate}',
                                                          'end_date':
                                                              '${compaignModel.data!.data![index].endDate}',
                                                          'is_active': compaignModel
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .isActive ==
                                                                  0
                                                              ? '1'
                                                              : '0',
                                                          'product_ids[]':
                                                              compaignModel
                                                                  .data!
                                                                  .data![index]
                                                                  .productIds!
                                                                  .join(','),
                                                          'campaign_id':
                                                              '${compaignModel.data!.data![index].id}'
                                                        });
                                                    if (result == true) {
                                                      page = 1;
                                                      CompaignModel res =
                                                          await DataProvider()
                                                              .get_compaign_function(
                                                                  page: page,
                                                                  count: count);
                                                      state!.response.data!
                                                              .data =
                                                          res.data!.data;
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop('update');
                                                    }
                                                  },
                                                  child: Text(compaignModel
                                                                  .data!
                                                                  .data![index]
                                                                  .isActive ==
                                                              1
                                                          ? "Inactive"
                                                          : 'Active')
                                                      .translate()),
                                              value: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .isActive ==
                                                      1
                                                  ? "/Inactive"
                                                  : '/Active',
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    await _dialogBuilder(
                                                      id: compaignModel.data!
                                                          .data![index].id,
                                                      context: bc,
                                                    ).then((value) {
                                                      Navigator.pop(context);
                                                      page = 1;
                                                      myCompaignsBloc.add(
                                                          MyCompaignsEvent(
                                                              page: page,
                                                              count: count));
                                                    });
                                                    setState(() {});
                                                  },
                                                  child: Text("Remove")
                                                      .translate()),
                                              value: '/Remove',
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                  onTap: () async {
                                                    Get.to(NewCampaign(
                                                      tag: 'update',
                                                      name: compaignModel.data!
                                                          .data![index].name,
                                                      discount_type:
                                                          compaignModel
                                                              .data!
                                                              .data![index]
                                                              .discountType,
                                                      campaignId: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .id,
                                                      discount: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .discount,
                                                      endDate: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .endDate,
                                                      startDate: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .startDate,
                                                      productId: compaignModel
                                                          .data!
                                                          .data![index]
                                                          .productIds!,
                                                      active_or_inactive:
                                                          compaignModel
                                                              .data!
                                                              .data![index]
                                                              .isActive
                                                              .toString(),
                                                    ))!
                                                        .then((value) {
                                                      if (value == 'update') {
                                                        Navigator.pop(context);
                                                        page = 1;
                                                        myCompaignsBloc.add(
                                                            MyCompaignsEvent(
                                                                page: page,
                                                                count: count));
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  child: Text("Update")
                                                      .translate()),
                                              value: '/Update',
                                            ),
                                          ];
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 12,
                                          //color: const Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Discount : '.tr,
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
                                                'AED ${compaignModel.data!.data![index].discount}',
                                            style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Discount type : ',
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 14),
                                        ).translate(),
                                        Text(
                                          '  ${compaignModel.data!.data![index].discountType}',
                                          style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ).translate()
                                      ],
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14,
                                      //color: const Color(0xff000000),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Start Date :'.tr +
                                            '  ${compaignModel.data!.data![index].startDate}',
                                        style: TextStyle(
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                        recognizer: new TapGestureRecognizer(),
                                        // ..onTap = () {
                                        //   widget.onSignUp!;
                                        //},
                                        text: '',
                                        style: TextStyle(
                                          //color: const Color(0xff40C057),
                                          fontFamily: AppFonts.segoeui,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: Text(
                                  'End Date :'.tr +
                                      ' ${compaignModel.data!.data![index].endDate}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ).translate(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: Row(
                                  children: [
                                    Text(
                                      'Status :'.tr,
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 14),
                                    ).translate(),
                                    Text(
                                      ' ${compaignModel.data!.data![index].isActive == 1 ? 'Active' : 'Inactive'}',
                                      style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 14,
                                          color: compaignModel.data!
                                                      .data![index].isActive ==
                                                  1
                                              ? Colors.green
                                              : Colors.red),
                                    ).translate(),
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
                itemCount: compaignModel.data!.data!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder({
    required BuildContext context,
    int? id,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure want to delete Warehouse?').translate(),
          actions: <Widget>[
            TextButton(
              child: Text('No').translate(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes').translate(),
              onPressed: () async {
                await DataProvider().removeToCompaignFunction(Id: id);
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
