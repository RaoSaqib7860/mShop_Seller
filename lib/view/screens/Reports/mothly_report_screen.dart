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
import '../../../model/reports/mothly_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/custom_dropdown.dart';
import 'monthly_graph.dart';

class MonthlyReportsScreen extends StatefulWidget {
  const MonthlyReportsScreen({Key? key}) : super(key: key);

  @override
  State<MonthlyReportsScreen> createState() => _MonthlyReportsScreenState();
}

class _MonthlyReportsScreenState extends State<MonthlyReportsScreen> {
  MonthlySaleModel? monthlySaleModel;
  Future apiCall() async {
    monthlySaleModel =
        await DataProvider().get_sale_report_month(year: '2023', month: '4');
    chartData = [];
    getListData();
    setState(() {});
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  List<ChartDataForMonth> chartData = [];
  String selected_duration = 'Year'.tr;
  String selected_month = 'Month'.tr;
  List list_of_year = ['2022'.tr, '2023'.tr];
  List list_of_month = [
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

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return monthlySaleModel == null
        ? Center(child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ShimmerScreen()))
        : SingleChildScrollView(
            child: Container(
              // height: 100.h,
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
                                  url: '${monthlySaleModel!.reportUrl}',
                                  filename: 'Monthly Sales Report.pdf');
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        'NO. OF SALES.  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.segoeui,
                                            fontSize: 18),
                                      ).translate(),
                                      SizedBox(width: 10),
                                      Text(
                                        ' ${monthlySaleModel!.data!.numOfSales}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 18,
                                          color: Color(0xff524EB7),
                                        ),
                                      ).translate()
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DELIVERY COMPANY CHARGES.  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${monthlySaleModel!.data!.deliveryCompanyCharges}',
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
                                    'Mate COMMISSION.  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${monthlySaleModel!.data!.adminCommission}',
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
                                    'SELLER EARNINGS.  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 12),
                                  ).translate(),
                                  Text(
                                    ' ${monthlySaleModel!.data!.salesProfit}',
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
                                  Text('REVENUE.  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 12))
                                      .translate(),
                                  Text(
                                    ' ${monthlySaleModel!.data!.salesExpense}',
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
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 120,
                              //padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : AppColors.blackColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.5),
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
                                  dropdownWidth: 30.w,
                                  // buttonWidth: 100.w,

                                  hint: selected_duration,
                                  dropdownItems: list_of_year.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text('$value').translate(),
                                    );
                                  }).toList(),

                                  // value: selectedValue,
                                  onChanged: (data) async {
                                    print('neeeeeee ${data}');
                                    selected_duration = data!;
                                    setState(() {});
                                  },
                                ),
                              ),
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton<String>(
                              //     items: list_of_year.map((value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text('$value').translate(),
                              //       );
                              //     }).toList(),
                              //     hint: Text('${selected_duration}',
                              //         style: TextStyle(fontSize: 14))
                              //         .translate(),
                              //     onChanged: (data) {
                              //       selected_duration = data!;
                              //       setState(() {});
                              //     },
                              //     isExpanded: true,
                              //   ),
                              // ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Container(
                              width: 120,
                              //padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : AppColors.blackColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.5),
                                    offset: Offset(0, 3),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomDropdownButton2(
                                  buttonDecoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  //buttonPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 0),
                                  dropdownWidth: 30.w,
                                  buttonWidth: 100.w,
                                  hint: selected_month,
                                  dropdownItems: list_of_month.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text('$value').translate(),
                                    );
                                  }).toList(),

                                  // value: selectedValue,
                                  onChanged: (data) async {
                                    selected_month = data!;
                                    setState(() {});
                                  },
                                ),
                              ),
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton<String>(
                              //     items: list_of_month.map((value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text('$value').translate(),
                              //       );
                              //     }).toList(),
                              //     hint: Text('${selected_month}',
                              //         style: TextStyle(fontSize: 14))
                              //         .translate(),
                              //     onChanged: (data) {
                              //       selected_month = data!;
                              //       setState(() {});
                              //     },
                              //     isExpanded: true,
                              //   ),
                              // ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  visible = true;
                                  setState(() {});
                                  chartData = [];
                                  monthlySaleModel = await DataProvider()
                                      .get_sale_report_month(
                                          year: selected_duration,
                                          month:
                                              '${list_of_month.indexOf(selected_month) + 1}');
                                  getListData();
                                  visible = false;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 5.h,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300
                                            .withOpacity(0.5),
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Get',
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      AspectRatio(
                        aspectRatio: 1.23,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16, left: 6),
                                child: ReportMonthlyGraph(list_of_total_sale: chartData),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          height: 100.h,
                          width: 100.w,
                          color: Colors.white.withOpacity(0.5),
                          child: screenLoader(use_opacity: false)))
                ],
              ),
            ),
          );
  }
  Widget ShimmerScreen(){
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
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
    print('total month = ${monthlySaleModel!.data!.dateWiseSales!.length}');
    for (var i in monthlySaleModel!.data!.dateWiseSales!) {
      Apr062023 data = i.months_data!;
      chartData.add(ChartDataForMonth(
          month_name: '${i.name}',
          admin_commission:
              data.adminCommission == null ? 0.0 : data.adminCommission,
          delivery_company_charges: data.deliveryCompanyCharges == null
              ? 0.0
              : data.deliveryCompanyCharges!.toDouble(),
          num_of_sales:
              data.numOfSales == null ? 0.0 : data.numOfSales!.toDouble(),
          sales_expense:
              data.salesExpense == null ? 0.0 : data.salesExpense!.toDouble(),
          sales_profit:
              data.salesProfit == null ? 0.0 : data.salesProfit!.toDouble()));
    }
    // print('step 2 ${chartData.length}');
    // for(var i in chartData){
    //   list_of_series.add( StackedLineSeries<ChartDataForYear, String>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartDataForYear data, _) =>
    //       i.month_name,
    //       yValueMapper: (ChartDataForYear data, _) =>
    //       i.delivery_company_charges,
    //       name: i.month_name,
    //       markerSettings: MarkerSettings(isVisible: true)));
    //   list_of_series.add( StackedLineSeries<ChartDataForYear, String>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartDataForYear data, _) =>
    //       i.month_name,
    //       yValueMapper: (ChartDataForYear data, _) =>
    //       i.sales_profit,
    //       name: i.month_name,
    //       markerSettings: MarkerSettings(isVisible: true)));
    //   list_of_series.add( StackedLineSeries<ChartDataForYear, String>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartDataForYear data, _) =>
    //       i.month_name,
    //       yValueMapper: (ChartDataForYear data, _) =>
    //       i.num_of_sales,
    //       name: i.month_name,
    //       markerSettings: MarkerSettings(isVisible: true)));
    //   list_of_series.add( StackedLineSeries<ChartDataForYear, String>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartDataForYear data, _) =>
    //       i.month_name,
    //       yValueMapper: (ChartDataForYear data, _) =>
    //       i.admin_commission,
    //       name: i.month_name,
    //       markerSettings: MarkerSettings(isVisible: true)));
    //   list_of_series.add( StackedLineSeries<ChartDataForYear, String>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartDataForYear data, _) =>
    //       i.month_name,
    //       yValueMapper: (ChartDataForYear data, _) =>
    //       i.sales_expense,
    //       name: i.month_name,
    //       markerSettings: MarkerSettings(isVisible: true)));
    // }
    print('step 3');
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

class ChartDataForMonth {
  ChartDataForMonth(
      {this.month_name,
      this.num_of_sales,
      this.delivery_company_charges,
      this.admin_commission,
      this.sales_profit,
      this.sales_expense});

  final String? month_name;
  final double? num_of_sales;
  final double? delivery_company_charges;
  final dynamic? admin_commission;
  final double? sales_profit;
  final double? sales_expense;
}
