import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../view/screens/orders/order_detail.dart' as order_page;
import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/Invoice/invoice_model.dart';
import '../../../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/Invoice_Bloc/invoice_bloc_events.dart';
import '../../../view_model/Invoice_Bloc/invoice_bloc_states.dart';
import '../../../view_model/Invoice_Bloc/invoice_bloc_view.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/web_view_global.dart';
import '../Products/product_details.dart';
import '../globle_shimmer_effect/shimmer_effect_class.dart';
import 'invoice_repository.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> with invoiceRepo {
  StreamSubscription? subscription;
  @override
  void initState() {
    page = 1;
    myInvoiceBloc.add(MyInvoiceEvent(page: page, count: count));
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            page = 1;
            myInvoiceBloc.add(MyInvoiceEvent(page: page, count: count));
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
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.whiteColor,
                size: 30)),
        title: Text(
          'Invoice',
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
      body: BlocConsumer<MyInvoiceBloc, MyInvoiceStates>(
        bloc: myInvoiceBloc,
        listener: (context, state) {
          if (state is MyInvoiceErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is MyInvoiceLoadingState) {
            return Center(
                child: Center(child: Shimmer.fromColors(
                    child: ShimmerWarehouse(),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100
                )));
          } else if (state is MyInvoiceLoadedState) {
            return viewInvoiceList(
                onLoad: () async {
                  invoiceModelView res = await getInvoiceProduct();
                  state.response!.data!.addAll(res.data!);
                  setState(() {});
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  page = 1;
                  invoiceModelView res = await DataProvider()
                      .viewInvoiceFunction(page: page, count: count);
                  state.response!.data = res.data;
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

  Widget viewInvoiceList({
    required invoiceModelView model,
    required BuildContext context,
    Function()? onRefresh,
    Function()? onLoad,
  }) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (model.data!.isEmpty) {
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => order_page.OrderDetail(
                                    Id: '${model.data![index].id.toString()}',
                                    link: '',
                                    boyName: 'boy name',
                                    wareHouseName: 'Dubai Store'),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: 'Invoice No : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 18,
                                              color: Colors.black,
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
                                                    '${model.data![index].invoiceNumber}',
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
                                            text: 'Order No : '.tr,
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
                                  'Order Date :' +
                                      ' ${model.data![index].orderDate}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: Text(
                                  'Delivery Status :' +
                                      ' ${model.data![index].deliveryStatus}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: Text(
                                  'Payment Method :' +
                                      ' ${model.data![index].paymentMethod}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: Text(
                                  'Payment Status :' +
                                      ' ${model.data![index].paymentStatus}',
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 14),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print(
                                      'view invoice${model.data![index].invoice}');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewGlobal(
                                          url: model.data![index].invoice,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    'View Invoice',
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
