import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/reports/total_sale_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../global_widgets/Sackbars.dart';
import 'total_graph.dart';

class TotalSaleReportScreen extends StatefulWidget {
  const TotalSaleReportScreen({Key? key}) : super(key: key);

  @override
  State<TotalSaleReportScreen> createState() => _TotalSaleReportScreenState();
}

class _TotalSaleReportScreenState extends State<TotalSaleReportScreen> {
  TotalSaleModel? totalSaleModel;
  Future apiCall() async {
    totalSaleModel = await DataProvider().get_total_sale_report();
    getListData();
    setState(() {});
  }

  bool isShowingMainData = true;
  @override
  void initState() {
    apiCall();
    super.initState();
  }

  List<ChartDataForTotalSale> chartData = [];

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return totalSaleModel == null
        ? Center(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ShimmerScreen()))
        : SingleChildScrollView(
            child: Container(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              File? file = await _downloadFile(
                                  url: '${totalSaleModel!.reportUrl}',
                                  filename: 'Total Sales Report.pdf');
                              if (file != null) {
                                print(file.path);
                                await Share.shareXFiles([XFile('${file.path}')]);
                              }
                            },
                            child: Container(
                              height: 3.5.h,
                              width: 15.h,
                              child: Center(
                                child: Text(
                                  'Download Report',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ).translate(),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueGrey),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        width: 97.w,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'NO. OF SALES  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 18),
                                      ).translate(),
                                      SizedBox(width: 10),
                                      Text(
                                        ' ${totalSaleModel!.data!.numOfSales}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 18,
                                          color: Color(0xff524EB7),
                                        ),
                                      ).translate()
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DELIVERY COMPANY CHARGES  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${totalSaleModel!.data!.deliveryCompanyCharges}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12,
                                      color: Color(0xff524EB7),
                                    ),
                                  ).translate()
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mate COMMISSION  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${totalSaleModel!.data!.adminCommission}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12,
                                      color: Color(0xff524EB7),
                                    ),
                                  ).translate()
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SELLER EARNINGS  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${totalSaleModel!.data!.salesProfit}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12,
                                      color: Color(0xff524EB7),
                                    ),
                                  ).translate()
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'REVENUE  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${totalSaleModel!.data!.salesExpense}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12,
                                      color: Color(0xff524EB7),
                                    ),
                                  ).translate()
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      AspectRatio(
                        aspectRatio: 1.23,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 6),
                                    child: ReportTotalGraph(
                                        list_of_total_sale: chartData),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      // SfCartesianChart(
                      //     primaryXAxis: CategoryAxis(),
                      //     tooltipBehavior: TooltipBehavior(enable: true),
                      //     legend: Legend(
                      //         isVisible: true,
                      //         position: LegendPosition.top,
                      //         orientation: LegendItemOrientation.auto),
                      //     series: <ChartSeries>[
                      //       StackedLineSeries<ChartDataForTotalSale, String>(
                      //           dataSource: chartData,
                      //           xValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.month_name,
                      //           yValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.delivery_company_charges,
                      //           name: 'company_charges'.tr,
                      //           markerSettings:
                      //               MarkerSettings(isVisible: true)),
                      //       StackedLineSeries<ChartDataForTotalSale, String>(
                      //           dataSource: chartData,
                      //           xValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.month_name,
                      //           yValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.admin_commission,
                      //           name: 'admin_commission'.tr,
                      //           markerSettings:
                      //               MarkerSettings(isVisible: true)),
                      //       StackedLineSeries<ChartDataForTotalSale, String>(
                      //           dataSource: chartData,
                      //           xValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.month_name,
                      //           yValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.num_of_sales,
                      //           name: 'admin_commission'.tr,
                      //           markerSettings: MarkerSettings(
                      //             isVisible: true,
                      //           )),
                      //       StackedLineSeries<ChartDataForTotalSale, String>(
                      //           dataSource: chartData,
                      //           xValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.month_name,
                      //           yValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.sales_expense,
                      //           name: 'sales_expense'.tr,
                      //           markerSettings:
                      //               MarkerSettings(isVisible: true)),
                      //       StackedLineSeries<ChartDataForTotalSale, String>(
                      //           dataSource: chartData,
                      //           xValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.month_name,
                      //           yValueMapper: (ChartDataForTotalSale data, _) =>
                      //               data.sales_profit,
                      //           name: 'sales_profit'.tr,
                      //           markerSettings:
                      //               MarkerSettings(isVisible: true)),
                      //     ])
                    ],
                  ),
                  Visibility(
                      visible: visible, child: screenLoader(use_opacity: false))
                ],
              ),
            ),
          );
  }

  Widget ShimmerScreen() {
    return SingleChildScrollView(
      child: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 3.5.h,
                      width: 15.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 20.h,
                  width: 97.w,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 2.h,
                                  width: 20.w,
                                  color: Colors.grey.shade300,
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 2.h,
                                  width: 20.w,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.grey.shade300,
                            ),
                            Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  height: 40.h,
                  width: 90.w,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getListData() {
    print(
        'step 1 ${totalSaleModel!.data!.dateWiseSales!.toJson().entries.length}');
    if (totalSaleModel!.data!.dateWiseSales != null) {
      print(
          'step 1 ${totalSaleModel!.data!.dateWiseSales!.toJson().entries.length}');
      chartData =
          totalSaleModel!.data!.dateWiseSales!.toJson().entries.map((e) {
        print('stepstep=${e.key}');
        Apr062023 data = Apr062023.fromJson(e.value);
        return ChartDataForTotalSale(
            month_name: '${e.key}',
            admin_commission:
                data.adminCommission == null ? 0.0 : data.adminCommission,
            delivery_company_charges: data.deliveryCompanyCharges == null
                ? 0.0
                : double.parse('${data.deliveryCompanyCharges!}'),
            num_of_sales:
                data.numOfSales == null ? 0.0 : data.numOfSales!.toDouble(),
            sales_expense:
                data.salesExpense == null ? 0.0 : data.salesExpense!.toDouble(),
            sales_profit:
                data.salesProfit == null ? 0.0 : data.salesProfit!.toDouble());
      }).toList();
    }
  }

  static var httpClient = new HttpClient();
  Future<File?> _downloadFile({String? url, String? filename}) async {
    var request = await httpClient.getUrl(Uri.parse(url!));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      Directory? tempDir = await getApplicationDocumentsDirectory();
      File file = new File('${tempDir!.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      snackBarFailer('Storage Permission denied'.tr);
    }
    return null;
  }
}

class ChartDataForTotalSale {
  ChartDataForTotalSale(
      {this.month_name,
      this.num_of_sales,
      this.delivery_company_charges,
      this.admin_commission,
      this.sales_profit,
      this.sales_expense});

  final String? month_name;
  final double? num_of_sales;
  final double? delivery_company_charges;
  final dynamic admin_commission;
  final double? sales_profit;
  final double? sales_expense;
}
