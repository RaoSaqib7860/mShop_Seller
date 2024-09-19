import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mShop_Seller/view/screens/shiping.dart';
import '../global_widgets/app_font.dart';

import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int STEPS = 5;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingScreen(),));
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
              title: Text('Select Address'.tr,style: TextStyle(
                  fontSize: 18,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w500
              ),),
              trailing: Wrap(
                children: [
                  Icon(CupertinoIcons.add,color: Colors.red,),
                  Text('Add New Address'.tr,style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: AppFonts.segoeui,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
            ),
            Container(
              height: 20.h,
              width: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xffE9E8F6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    //color: const Color(0x290bab0d),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 6.h,
                          width: 23.h,
                          //color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 4.h,
                                width: 4.h,
                                child: Center(child: Icon(CupertinoIcons.home,size: 18,color: Colors.grey.shade700,)),
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                              ),
                              Text('Home'.tr,style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),),
                              Container(
                                height: 2.5.h,
                                width: 1.5,
                                color: Colors.grey,
                              ),
                              Container(
                                height: 3.h,
                                width: 8.h,
                                child: Center(
                                  child: Text(
                                    'Primary'.tr,
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
                              )
                            ],
                          ),
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
                  ListTile(
                    title: Text('Jacob Jones'.tr,style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),),
                    subtitle: Row(children: [
                      Icon(Icons.call,size: 14,color: Colors.grey,),
                      Text('84993850'),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Unit:B - Ground Floor - Room 24 - 4517 Washington Ave. Manchester, Kentucky 39495'.tr,style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Container(
              height: 20.h,
              width: 40.h,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 6.h,
                          width: 19.h,
                          //color: Colors.blue,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 4.h,
                                  width: 4.h,
                                  child: Center(child: Icon(CupertinoIcons.uiwindow_split_2x1,size: 18,color: Colors.grey.shade700,)),
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                ),
                              ),
                              Text('Office'.tr,style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Jacob Jones'.tr,style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),),
                    subtitle: Row(children: [
                      Icon(Icons.call,size: 14,color: Colors.grey,),
                      Text('84993850'),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Unit:B - Ground Floor - Room 24 - 4517 Washington Ave. Manchester, Kentucky 39495'.tr,style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 8.0.h,
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
