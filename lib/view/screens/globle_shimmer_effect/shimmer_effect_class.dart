import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../extentions/app_colors.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../global_widgets/AppSize.dart';

// class ShimmerEffect extends StatelessWidget {
//   const ShimmerEffect({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       child: Column(
//         children: [
//           Expanded(
//             child: RefreshControllerGlobal(
//
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//
//                   return Column(
//                     children: [
//                       SizedBox(height: 1.0.h),
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 15),
//                         // height: 34.h,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         decoration: BoxDecoration(
//                             color:  AppColors.blackColor,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: blueGrey.withOpacity(0.1),
//                                   offset: Offset(3, 3),
//                                   blurRadius: 7,
//                                   spreadRadius: 3),
//                               BoxShadow(
//                                   color: blueGrey.withOpacity(0.1),
//                                   offset: Offset(-1, -1))
//                             ],
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text.rich(
//                                         TextSpan(
//                                           style: TextStyle(
//                                             fontFamily: AppFonts.segoeui,
//                                             fontSize: 12,
//                                           ),
//                                           children: [
//                                             TextSpan(
//                                                 text: 'Order ID  ',
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight:
//                                                     FontWeight.bold)),
//                                             TextSpan(
//                                               recognizer:
//                                               new TapGestureRecognizer(),
//                                               text:
//                                               'jhhj',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight:
//                                                   FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       Container(
//                                         height: 3.h,
//                                         width: 10.h,
//                                         child: Center(
//                                           child: Text(
//                                             'Cancelled ',
//                                             style: TextStyle(
//                                               fontFamily: AppFonts.segoeui,
//                                               fontSize: 12,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                             BorderRadius.circular(7),
//                                             color:  Colors.red),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text.rich(
//                                     TextSpan(
//                                       style: TextStyle(
//                                         fontFamily: AppFonts.segoeui,
//                                         fontSize: 14,
//                                         //color: const Color(0xff000000),
//                                       ),
//                                       children: [
//                                         TextSpan(
//                                           text: 'Order Code:  '.tr,
//                                           style: TextStyle(
//                                               fontFamily: AppFonts.segoeui,
//                                               fontSize: 14),
//                                         ),
//                                         TextSpan(
//                                           recognizer:
//                                           new TapGestureRecognizer(),
//                                           // ..onTap = () {
//                                           //   widget.onSignUp!;
//                                           //},
//                                           text:
//                                           'hjhkikiyykj',
//                                           style: TextStyle(
//                                               fontFamily: AppFonts.segoeui,
//                                               fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Row(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text('Payment Status: '),
//                                       Text(
//                                          'Unpaid',
//                                         style: TextStyle(
//                                             fontFamily: AppFonts.segoeui,
//                                             fontSize: 14),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 'Order Date :'.tr +
//                                     ' dghjgh',
//                                 style: TextStyle(
//                                     fontFamily: AppFonts.segoeui,
//                                     fontSize: 14),
//                               ),
//                             ),
//                             Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(horizontal: 8),
//                                 child: Text(
//                                   'Payment Method :' +
//                                       '  ',
//                                   style: TextStyle(
//                                       fontFamily: AppFonts.segoeui,
//                                       fontSize: 14),
//                                 )),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                               ),
//                               child: Text(
//                                 'Delivery Status : ' +
//                                     '',
//                                 style: TextStyle(
//                                     fontFamily: AppFonts.segoeui,
//                                     fontSize: 14),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                               ),
//                               child: Text(
//                                 'Delivered by : ' +
//                                     '',
//                                 style: TextStyle(
//                                     fontFamily: AppFonts.segoeui,
//                                     fontSize: 14),
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             const Padding(
//                               padding: EdgeInsets.only(left: 18, right: 18),
//                               child: Divider(),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceAround,
//                                 children: [
//                                   ClipRRect(
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           height: 8.h,
//                                           width: 7.2.h,
//                                           child: CachedNetworkImage(
//                                             imageUrl:
//                                             "",
//                                             placeholder: (context, url) =>
//                                                 Container(
//                                                   color: Colors.blue,
//                                                 ),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                 Icon(Icons.error),
//                                             fit: BoxFit.contain,
//                                           ),
//                                         ),
//                                         Visibility(
//                                           child: Positioned(
//                                             bottom: 5,
//                                             right: 5,
//                                             child: CircularProfileAvatar(
//                                               '',
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white
//                                                         .withOpacity(0.3)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     ' dhgrhrdd',
//                                                     style: TextStyle(
//                                                         fontSize: 12),
//                                                   ),
//                                                 ),
//                                               ),
//                                               radius: 12,
//                                             ),
//                                           ),
//
//                                         ),
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: 23.h,
//                                         child: Text(
//                                           "dsjfrij",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               overflow: TextOverflow.ellipsis,
//                                               //color: const Color(0xff524EB7),
//                                               fontFamily: AppFonts.segoeui,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 4,
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     'kfjhgiue',
//                                     style: TextStyle(
//                                         color: const Color(0xff524EB7),
//                                         fontFamily: AppFonts.segoeui,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 2.h,
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 3.h,
//                       )
//                     ],
//                   );
//                 },
//                 itemCount: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

Widget ShimmerOrders() {
  return Expanded(
      child: ListView.builder(
        //padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,),
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200.withOpacity(0.5),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.shade400.withOpacity(0.5),
                  //     offset: Offset(0, 3),
                  //     blurRadius: 6,
                  //   ),
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 2.5.h,
                              width: 60.w,
                              color: Colors.grey.shade300
                          ),
                          Container(
                            height: 3.h,
                            width: 10.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        height: 2.h,
                        width: 40.w,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child:  Container(
                          height: 2.h,
                          width: 45.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18, right: 18),
                      child: Divider(color: Colors.grey.shade300,thickness: 2,),
                    ),
                    SizedBox(height: 0.5.h,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 7.2.h,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            Container(
                              width: 23.h,
                              height: 2.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                                height: 2.h,
                                width: 20.w,
                                color: Colors.grey.shade300
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          );
        },));
}

Widget ShimmerSales() {
  return Expanded(
      child: ListView.builder(
        //padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,),
                height: 33.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200.withOpacity(0.5),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.shade400.withOpacity(0.5),
                  //     offset: Offset(0, 3),
                  //     blurRadius: 6,
                  //   ),
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 2.5.h,
                              width: 60.w,
                              color: Colors.grey.shade300
                          ),
                          Container(
                            height: 3.h,
                            width: 10.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                color: Colors.grey.shade300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        height: 2.h,
                        width: 40.w,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child:  Container(
                          height: 2.h,
                          width: 45.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          );
        },));
}

Widget ShimmerWarehouse() {
  return Expanded(
      child: ListView.builder(
        //padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,),
                //height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 2.5.h,
                              width: 40.w,
                              color: Colors.grey.shade300
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        height: 2.h,
                        width: 40.w,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child:  Container(
                          height: 2.h,
                          width: 45.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.grey.shade300
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          );
        },));
}
