import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../extentions/app_colors.dart';
import '../../../model/commission_history/commission_history_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/CommissionHestoryBlocs/commission_history_bloc.dart';
import '../../../view_model/CommissionHestoryBlocs/commission_history_events.dart';
import '../../../view_model/CommissionHestoryBlocs/commission_history_state.dart';
import '../../conectivity/connectivity.dart';
import '../ImageView/image_view_screen.dart';
import '../globle_shimmer_effect/shimmer_effect_class.dart';

class CommissionHistoryScreen extends StatefulWidget {
  const CommissionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CommissionHistoryScreen> createState() =>
      _CommissionHistoryScreenState();
}

class _CommissionHistoryScreenState extends State<CommissionHistoryScreen> {
  var refreshController = RefreshController(initialRefresh: false);
  MyCommissionHistoryBloc myCommissionHistoryBloc =
      MyCommissionHistoryBloc(MyCommissionHistoryInitialState());
  StreamSubscription? subscription;
  @override
  void initState() {
    myCommissionHistoryBloc.add(MyCommissionHistoryEvent());
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            myCommissionHistoryBloc.add(MyCommissionHistoryEvent());
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  File? _image;
  final picker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return null;
    }
  }

  List listofStatus = [
    'Transfer'.tr,
    'Submit'.tr,
    'Completed'.tr,
  ];

  List buttonColors = [
    Color(0xff40E0D0),
    Color(0xff6495ED),
    Color(0xffCCCCFF),
  ];
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sales'.tr,
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
      body: BlocConsumer<MyCommissionHistoryBloc, MyCommissionHistoryStates>(
        bloc: myCommissionHistoryBloc,
        listener: (context, state) {
          if (state is MyCommissionHistoryErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is MyCommissionHistoryLoadingState) {
            return Center(
                child: Center(
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: ShimmerSales()))
            );
          } else if (state is MyCommissionHistoryLoadedState) {
            return commissionHistory(
                context: context, commissionHistoryModel: state.response);
          } else {
            return Center(child: Text('data Not Loaded....'.tr).translate());
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

  Widget commissionHistory(
      {required CommissionHistory commissionHistoryModel,
      required BuildContext context}) {
    if (commissionHistoryModel.data == null ||
        commissionHistoryModel.data!.data == null ||
        commissionHistoryModel.data!.data!.length == 0) {
      return Center(
        child: Text('No Sales'),
      );
    }
    return Container(
      height: 100.h,
      width: 100.w,
      child: Column(
        children: [
          Expanded(
            child: RefreshControllerGlobal(
              controller: refreshController,
              onLoad: () {
                refreshController.loadComplete();
              },
              onRefresh: () async {
                myCommissionHistoryBloc.add(MyCommissionHistoryEvent());
                refreshController.refreshCompleted();
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var date = DateTime.parse(
                      "${commissionHistoryModel.data!.data![index].createdAt}");
                  return Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
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
                                            'Order ID  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          Text(
                                            '${commissionHistoryModel.data!.data![index].orderId}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                              fontFamily: AppFonts.segoeui,
                                            ),
                                          ).translate(),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (commissionHistoryModel
                                                  .data!
                                                  .data![index]
                                                  .paymentTransfer ==
                                              false) {
                                            File? newFile =
                                                await getImageFromGallery();
                                            if (newFile != null) {
                                              Get.to(imageViewScreen(
                                                orderId: commissionHistoryModel
                                                    .data!.data![index].orderId
                                                    .toString(),
                                                imagePath: newFile,
                                                paymentSent:
                                                    commissionHistoryModel.data!
                                                        .data![index].payToAdmin
                                                        .toString(),
                                              ))!
                                                  .then((value) {
                                                myCommissionHistoryBloc.add(
                                                    MyCommissionHistoryEvent());
                                              });
                                            }
                                          }
                                        },
                                        child: Visibility(
                                          visible: commissionHistoryModel
                                                          .data!
                                                          .data![index]
                                                          .paymentMethod ==
                                                      'COD' &&
                                                  commissionHistoryModel
                                                          .data!
                                                          .data![index]
                                                          .delivered_by_seller ==
                                                      1
                                              ? true
                                              : false,
                                          child: commissionHistoryModel
                                                      .data!
                                                      .data![index]
                                                      .paymentVerified !=
                                                  'yes'
                                              ? Container(
                                                  height: 3.h,
                                                  width: 10.h,
                                                  child: Center(
                                                    child: Text(
                                                      commissionHistoryModel
                                                                  .data!
                                                                  .data![index]
                                                                  .paymentTransfer ==
                                                              false
                                                          ? 'Transfer'
                                                          : 'Submitted',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.segoeui,
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      color: commissionHistoryModel
                                                                  .data!
                                                                  .data![index]
                                                                  .paymentTransfer ==
                                                              true
                                                          ? Colors.deepPurple
                                                              .shade300
                                                          : Colors.blueGrey),
                                                )
                                              : Container(
                                                  height: 3.h,
                                                  width: 10.h,
                                                  child: Center(
                                                    child: Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.segoeui,
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      color: Colors.green),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Order Code :'.tr +
                                    '   ${commissionHistoryModel.data!.data![index].orderNumber}',
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                ),
                              ).translate(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Admin Commission :'.tr +
                                          ' AED'.tr +
                                          '${commissionHistoryModel.data!.data![index].adminCommission}',
                                      style: TextStyle(
                                        //color: const Color(0xff524EB7),
                                        fontFamily: AppFonts.segoeui,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer: new TapGestureRecognizer(),
                                      // ..onTap = () {
                                      //   widget.onSignUp!;
                                      //},
                                      text: '',
                                      style: TextStyle(
                                        color: const Color(0xff40C057),
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
                                  horizontal: 8, vertical: 3),
                              child: Text('Date :'.tr +
                                      '  ${dateFormat.format(date)}')
                                  .translate(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Earning :'.tr +
                                      ' AED${commissionHistoryModel.data!.data![index].sellerEarning}')
                                  .translate(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Delivery Charges :'.tr +
                                      ' AED ${commissionHistoryModel.data!.data![index].deliveryCompanyCharges}')
                                  .translate(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Payment :'.tr +
                                      '  ${commissionHistoryModel.data!.data![index].paymentMethod}')
                                  .translate(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Payment Verified :'.tr +
                                  '  ${commissionHistoryModel.data!.data![index].paymentVerified == 'yes' ? 'Verified' : 'Pending'}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Service Fee :'.tr +
                                  ' AED ${commissionHistoryModel.data!.data![index].service_fee}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Text('Delivered by :'.tr +
                                  '  ${commissionHistoryModel.data!.data![index].delivered_by_housy == 1 ? 'Housy' : 'Seller'}'),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      )
                    ],
                  );
                },
                itemCount: commissionHistoryModel.data!.data!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
