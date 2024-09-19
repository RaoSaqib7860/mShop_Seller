import 'dart:async';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/view/screens/PaymentSendToAdmin/payment_send_repo.dart';
import 'package:mShop_Seller/view/screens/PaymentSendToAdmin/view_received_image.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view/screens/orders/order_detail.dart' as order_page;
import '../../../view_model/payment_sent_blocs/payment_send_to_admin_bloc.dart';
import '../../../view_model/payment_sent_blocs/payment_send_to_admin_events.dart';
import '../../../view_model/payment_sent_blocs/payment_send_to_admin_state.dart';
import '../../conectivity/connectivity.dart';
import '../globle_shimmer_effect/shimmer_effect_class.dart';

class PaymentToAdminScreen extends StatefulWidget {
  const PaymentToAdminScreen({Key? key}) : super(key: key);

  @override
  State<PaymentToAdminScreen> createState() => _PaymentToAdminScreenState();
}

class _PaymentToAdminScreenState extends State<PaymentToAdminScreen>
    with getPaymentPagination {
  StreamSubscription? subscription;
  @override
  void initState() {
    page = 1;
    myPaymentSendToAdminBloc
        .add(MyPaymentSendToAdminEvent(page: page, count: count));
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            page = 1;
            myPaymentSendToAdminBloc
                .add(MyPaymentSendToAdminEvent(page: page, count: count));
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
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back,
                size: 25,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white)),
        title: Text(
          'Payment',
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ).translate(),
      ),
      body: BlocConsumer<MyPaymentSendToAdminBloc, MyPaymentSendToAdminStates>(
        bloc: myPaymentSendToAdminBloc,
        listener: (context, state) {
          if (state is MyPaymentSendToAdminErrorState) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is MyPaymentSendToAdminLoadingState) {
            return Center(
                child: Center(child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ShimmerSales())));
          } else if (state is MyPaymentSendToAdminLoadedState) {
            return paymentSendToAdmin(
                onLoad: () async {
                  PaymentSentModel res = await getPayment();
                  state.response!.data!.addAll(res.data!);
                  setState(() {});
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  page = 1;
                  PaymentSentModel? res = await DataProvider()
                      .paymentToAdminFunction(page: page, count: count);
                  state.response!.data = res!.data!;
                  setState(() {});
                  refreshController.refreshCompleted();
                },
                context: context,
                paymentSentModel: state.response);
          } else {
            return Center(child: Text('No Payment'.tr));
          }
        },
      ),
    );
  }

  Widget paymentSendToAdmin({
    required PaymentSentModel paymentSentModel,
    required BuildContext context,
    Function()? onRefresh,
    Function()? onLoad,
  }) {
    if (paymentSentModel.data == null || paymentSentModel.data!.length == 0) {
      return Center(
        child: Text('No Payments'),
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
              onLoad: onLoad,
              onRefresh: onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => order_page.OrderDetail(
                                  Id: '${paymentSentModel.data![index].orderDetail!.orderId}',
                                  link: '',
                                  boyName: 'boy name',
                                  wareHouseName: 'Dubai Store')));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 90.w,
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
                                                  text: 'Payment ID  '.tr,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                recognizer:
                                                    new TapGestureRecognizer(),
                                                text:
                                                    '${paymentSentModel.data![index].id}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: AppFonts.segoeui,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 3.h,
                                              width: 10.h,
                                              child: Center(
                                                child: Text(
                                                  paymentSentModel.data![index]
                                                              .paymentVerified ==
                                                          'yes'
                                                      ? 'Transferred'
                                                      : 'Pending',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ).translate(),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: paymentSentModel
                                                              .data![index]
                                                              .paymentVerified ==
                                                          'yes'
                                                      ? Colors.green
                                                      : Colors.amber),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context.pushTransparentRoute(
                                                    ViewReceivedImage(
                                                  image: paymentSentModel
                                                      .data![index]
                                                      .paymentReceipt,
                                                ));
                                              },
                                              child: Container(
                                                height: 3.h,
                                                width: 10.h,
                                                child: Center(
                                                  child: Text(
                                                    'View Receipt',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.segoeui,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ).translate(),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Paid to:  ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppFonts.segoeui,
                                                    fontSize: 14))
                                            .translate(),
                                        Text(
                                          '  ${paymentSentModel.data![index].paidTo}',
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 14),
                                        ).translate(),
                                      ],
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'Order id:  '.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 14)),
                                          TextSpan(
                                            recognizer:
                                                new TapGestureRecognizer(),
                                            text:
                                                '${paymentSentModel.data![index].orderDetail!.orderId}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.segoeui,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'Order Code:  '.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 14)),
                                          TextSpan(
                                            recognizer:
                                                new TapGestureRecognizer(),
                                            text:
                                                '${paymentSentModel.data![index].order_code}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.segoeui,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'Amount Paid:  '.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 14)),
                                          TextSpan(
                                            recognizer:
                                                new TapGestureRecognizer(),
                                            text:
                                                '${paymentSentModel.data![index].amountPaid}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: AppFonts.segoeui,
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
                                  'Payment Method :' +
                                      ' ${paymentSentModel.data![index].paymentMethod}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Payment Verified :'.tr +
                                      '  ${paymentSentModel.data![index].paymentVerified}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Service Fee :'.tr +
                                      '  AED ${paymentSentModel.data![index].orderDetail!.service_fee}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 8, vertical: 3),
                              //   child: Text(
                              //     'Driver :'.tr +
                              //         ' ${paymentSentModel.data![index].deliveryBoy == null ? '' : paymentSentModel.data![index].deliveryBoy!.name}',
                              //     style: TextStyle(
                              //         fontFamily: AppFonts.segoeui, fontSize: 14),
                              //   ).translate(),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 8, vertical: 3),
                              //   child: Text(
                              //     'Driver Mail :'.tr +
                              //         ' ${paymentSentModel.data![index].deliveryBoy == null ? '' : paymentSentModel.data![index].deliveryBoy!.email}',
                              //     style: TextStyle(
                              //         fontFamily: AppFonts.segoeui, fontSize: 14),
                              //   ).translate(),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 8, vertical: 3),
                              //   child: Text(
                              //     'WareHouse Name :'.tr +
                              //         ' ${paymentSentModel.data![index].pickupPoint == null ? '' : paymentSentModel.data![index].pickupPoint!.warehouseName}',
                              //     style: TextStyle(
                              //         fontFamily: AppFonts.segoeui, fontSize: 14),
                              //   ).translate(),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 8, vertical: 3),
                              //   child: Text(
                              //     'WareHouse Address :'.tr +
                              //         ' ${paymentSentModel.data![index].pickupPoint == null ? '' : paymentSentModel.data![index].pickupPoint!.warehouseAddress}',
                              //     style: TextStyle(
                              //         fontFamily: AppFonts.segoeui, fontSize: 14),
                              //   ).translate(),
                              // ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: paymentSentModel.data!.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
