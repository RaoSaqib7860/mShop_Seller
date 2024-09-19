import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';

import '../../../extentions/app_colors.dart';
import '../../../utils_services/app_font.dart';
import '../../conectivity/connectivity.dart';
import 'mothly_report_screen.dart';
import 'total_sale_report_screen.dart';
import 'yearly_reports_screen.dart';

class ReportsMainScreen extends StatefulWidget {
  const ReportsMainScreen({Key? key}) : super(key: key);

  @override
  State<ReportsMainScreen> createState() => _ReportsMainScreenState();
}

class _ReportsMainScreenState extends State<ReportsMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  StreamSubscription? subscription;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            _tabController = new TabController(vsync: this, length: 3);
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
        title: Text(
          'REPORTS',
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              //height: 6.h,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey.shade50
                  : AppColors.blackColor,
            ),
            Container(
              //height: 8.h,
              // color: Theme.of(context).brightness == Brightness.light
              //     ? Colors.blueGrey.shade50
              //     : AppColors.blackColor,
              child: TabBar(
                labelColor: Theme.of(context).brightness == Brightness.light
                    ? blueGrey
                    : AppColors.whiteColor,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                // indicatorColor: Color(0xffF37D70),
                // indicatorWeight: 2,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: blueGrey),
                    insets: EdgeInsets.symmetric(horizontal: 24.0)),
                tabs: [
                  Tab(
                    height: 39,
                    child: Text(
                      'TOTAL SALE',
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Text(
                      'MONTHLY SALE',
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Text(
                      'YEARLY SALE',
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                (TotalSaleReportScreen()),
                (MonthlyReportsScreen()),
                (ReportsScreen()),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
