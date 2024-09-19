import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/view/screens/payment_screen.dart';

import '../global_widgets/app_font.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  int STEPS = 5;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(),));
      },child: Icon(Icons.arrow_forward_ios),),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            ListTile(leading: Icon(Icons.arrow_back),
              title: Text('Checkout'.tr,style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
              trailing: SvgPicture.asset('assets/svgs/musicc.svg',),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            FullLinearStepIndicator(
              steps: 5,
              lineHeight: 2.5,
              activeNodeColor: Colors.brown,
              inActiveNodeColor: const Color(0xffd1d5d8),
              activeLineColor: Colors.brown,
              inActiveLineColor: const Color(0xffd1d5d8),
              controller: pageController,
              labels: List<String>.generate(STEPS, (index) => "Step".tr+" ${index + 1}"),
              complete: () {
                //typically, you'd want to put logic that returns true when all the steps
                //are completed here
                return Future.value(true);
              },
            ),

            SizedBox(
              height: 2.0.h,
            ),
            ListTile(
              title: Text('Shipping Method'.tr,style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w500
              ),),
            ),
            Container(
              height: 55.h,
             // color: Colors.blue,
              child: ListView.builder(padding: EdgeInsets.only(top: 0),itemCount: 3,itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18,top:14),
                  child: Container(
                    height: 14.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xffE8E9F6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          //color: const Color(0x290bab0d),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Standard'.tr,style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w500
                              ),),
                              SizedBox(height: 1.h,),
                              Text('Free up to 10kg'.tr,style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w500
                              ),),
                              SizedBox(height: 1.h,),
                              Text('Arrives in 5-7 business days'.tr,style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 4.h,
                              width: 4.h,
                              child: Center(child: Container(
                                height: 1.5.h,
                                width: 1.5.h,
                                decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                              ),),
                              decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },),
            ),

            SizedBox(
              height: 3.0.h,
            ),
            Container(
              height: 5.h,
              width: 35.h,
              child: Center(child: Text('Continue'.tr, style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w400
              ),),),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff524EB7)),
            ),
          ],
        ),
      ) ,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

}
