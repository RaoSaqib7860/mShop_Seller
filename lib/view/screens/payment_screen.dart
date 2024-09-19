import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_translator/google_translator.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../global_widgets/app_font.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int STEPS = 5;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlaced(),));
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
              ),).translate(),
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
              title: Text('Recommended Method'.tr,style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w500
              ),).translate(),
            ),
        ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffE8E9F6),
              radius: 25,
              child: SvgPicture.asset('assets/svgs/cary.svg'),
            ),
            title: Text('Cash On Delivery'.tr,style: TextStyle(
              fontFamily: AppFonts.segoeui,
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),).translate(),
        ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(color: Colors.grey,),
            ),
            SizedBox(height: 2.h,),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xffE8E9F6),
                radius: 25,
                child: SvgPicture.asset('assets/svgs/iphone.svg'),
              ),
              title: Text('Debit or Credit Card'.tr,style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),).translate(),
            ),
            SizedBox(height: 2.h,),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xffE8E9F6),
                radius: 25,
                child: SvgPicture.asset('assets/svgs/iphone.svg'),
              ),
              title: Text('Apple Pay'.tr,style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),).translate(),
            ),
            SizedBox(height: 1.h,),
            ListTile(
              title: Text('Order Summary'.tr,style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),).translate(),
            ),
            Container(
              height: 25.h,
              //color: Colors.grey.shade300,
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),).translate(),
                        Text('AED 300'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),).translate(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0),
                    child: Divider(),
                  ),
                  SizedBox(height: 1.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Value Added Tax (VAT)'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),).translate(),
                        Text('AED 300'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),).translate(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.0),
                    child: Divider(),
                  ),
                  SizedBox(height: 2.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Charges'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),),
                        Text('AED 300'.tr,style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Total'.tr,style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),),
                        Text('AED 300'.tr,style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                  ),
                  //   ListTile(
                  //     title: Text('Subtotal',style: TextStyle(
                  //       fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //     trailing: Text('300',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //   ),
                  //   Padding(
                  //     padding:  EdgeInsets.symmetric(horizontal: 30.0),
                  //     child: Divider(),
                  //   ),
                  //   ListTile(
                  //     title: Text('Subtotal',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //     trailing: Text('300',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //   ),
                  //   Padding(
                  //     padding:  EdgeInsets.symmetric(horizontal: 30.0),
                  //     child: Divider(),
                  //   ),
                  //   ListTile(
                  //     title: Text('Subtotal',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //     trailing: Text('300',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //   ),
                  //   ListTile(
                  //     title: Text('Subtotal',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //     trailing: Text('300',style: TextStyle(
                  //         fontSize: 18,
                  //         fontFamily: AppFonts.segoeui,
                  //         fontWeight: FontWeight.w500
                  //     ),),
                  //   ),
                ],
              ),
            ),
            Container(
              height: 5.h,
              width: 35.h,
              child: Center(child: Text('Place Order'.tr, style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w400
              ),),),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff524EB7)),
            ),

          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
