import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';

import '../../api_repo/basepath.dart';
import '../../model/add_to_cart_model/add_to_cart_list.dart';
import '../../model/add_to_cart_model/add_to_cart_summary_model.dart';
import '../../view_model/add_to_cart/add_to_cart _list_bloc/add_to_cart_lists_bloc.dart';
import '../../view_model/add_to_cart/add_to_cart _list_bloc/add_to_cart_lists_events.dart';
import '../../view_model/add_to_cart/add_to_cart _list_bloc/add_to_cart_lists_states.dart';
import '../global_widgets/app_font.dart';
import 'checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AddToCartListBloc listBloc = AddToCartListBloc(AddToCartListInitialState());

  @override
  void initState() {
    listBloc.add(AddToCartListEvent());
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOut(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<AddToCartListBloc, AddToCartListStates>(
        bloc: listBloc,
        listener: (context, state) {
          if (state is AddToCartListErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is AddToCartListLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else if (state is AddToCartListLoadedState) {
            return cartScreen(
                cartList: state.response,
                context: context,
                addSummary: state.res);
          } else {
            return Text('data'.tr);
          }
        },
      ),
      // bottomNavigationBar: Container(
      //   height: 8.h,
      //   color: Colors.white,
      //   child: Padding(
      //     padding:  EdgeInsets.symmetric(horizontal: 12.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Container(
      //           height: 6.h,
      //           width: 14.h,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text('\$50.00',style: TextStyle(
      //                 // color: const Color(0xff192129),
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w700,
      //                 fontFamily: AppFonts.segoeui,
      //               )),
      //               SizedBox(height: 3,),
      //               Text('Price'),
      //             ],
      //           ),
      //         ),
      //         Container(
      //           height: 6.h,
      //           width: 18.h,
      //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff524EB7)),
      //           child: Center(child: Text('Track Order', style: TextStyle(
      //               fontSize: 12.sp,
      //               color: Colors.white,
      //               fontFamily: AppFonts.segoeui,
      //               fontWeight: FontWeight.w400
      //           ),),),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget cartScreen(
      {required AddToCartList cartList,
      required BuildContext context,
      required AddToCartSummaryModel addSummary}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          ListTile(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.arrow_left, color: Colors.black)),
            title: Text(
              'Cart'.tr,
              style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: SvgPicture.asset(
              'assets/svgs/musicc.svg',
            ),
          ),
          ListTile(
            title: Text(
              ' items'.tr,
              style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              'Checkout All'.tr,
              style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: 46.h,
            //color: Colors.grey,
            child: ListView.builder(
              itemCount: cartList.cartItems!.length,
              padding: EdgeInsets.only(top: 12),
              itemBuilder: (context, index) {
                int? count = cartList.cartItems![index].quantity;
                dynamic subTotalPrice =
                    (cartList.cartItems![index].price!.contains('.') == true
                            ? double.parse(cartList.cartItems![index].price!)
                            : int.parse(cartList.cartItems![index].price!)) +
                        (cartList.cartItems![index].tax!.contains('.') == true
                            ? double.parse(cartList.cartItems![index].tax!)
                            : int.parse(cartList.cartItems![index].tax!));
                dynamic subTotalGrand =
                    subTotalPrice * cartList.cartItems![index].quantity!;

                return Padding(
                  padding: EdgeInsets.only(left: 14, right: 14, top: 8),
                  child: Container(
                    height: 15.h,
                    // color: Colors.green,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 9.h,
                            width: 9.h,
                            //decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(8)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${cartList.cartItems![index].productThumbnailImage}",
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Container(
                                color: Colors.blue,
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                      '${imageUrl}assets/img/placeholder.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cartList.cartItems![index].productName}',
                              style: TextStyle(
                                  //color: const Color(0xff524EB7),
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w600),
                            ).translate(),

                            Text(
                              '${cartList.cartItems![index].variation}',
                              style: TextStyle(
                                  //color: const Color(0xff524EB7),
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w400),
                            ).translate(),
                            Text(
                              'Text:'.tr +
                                  '   ${cartList.cartItems![index].tax}',
                              style: TextStyle(
                                  //color: const Color(0xff524EB7),
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Price:'.tr +
                                  '   ${cartList.cartItems![index].price}',
                              style: TextStyle(
                                  //color: const Color(0xff524EB7),
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            // Row(
                            //   children: [
                            //     Container(
                            //       height: 3.h,
                            //       width: 7.h,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         color: const Color(0xffE8E9F6),
                            //       ),
                            //       child: Row(
                            //         children: const [
                            //           Text('  Size:',style: TextStyle(fontSize: 12),),
                            //           Text('M',style: TextStyle(fontSize: 12),),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(width: 5,),
                            //     Container(
                            //       height: 3.h,
                            //       width: 7.h,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         color: const Color(0xffE8E9F6),
                            //       ),
                            //       child: Row(
                            //         children: [
                            //           Text(' Color:',style: TextStyle(fontSize: 12),),
                            //           Container(
                            //             height: 1.5.h,
                            //             width: 2.h,
                            //             decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(width: 5,),
                            //     Container(
                            //       height: 3.h,
                            //       width: 7.h,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10.0),
                            //         color: const Color(0xffE8E9F6),
                            //       ),
                            //       child: Row(
                            //         children: const [
                            //           Text(' QTY:',style: TextStyle(fontSize: 12),),
                            //           Text('01',style: TextStyle(fontSize: 12),),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 4.h,
                                  width: 11.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            count! - 1;
                                          });
                                        },
                                        child: Container(
                                          height: 3.5.h,
                                          width: 3.5.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffE8E9F6),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Text('$count'),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            count! + 1;
                                          });
                                        },
                                        child: Container(
                                          height: 3.5.h,
                                          width: 3.5.h,
                                          child: Icon(
                                            CupertinoIcons.add,
                                            size: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffE8E9F6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 6.h,
                                ),
                                Text(
                                  '${cartList.cartItems![index].currencySymbol}${subTotalGrand.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      //color: const Color(0xff524EB7),
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.w400),
                                ).translate(),
                              ],
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 4.h,
                            width: 4.h,
                            child: Center(
                                child: Icon(
                              CupertinoIcons.delete,
                              color: Colors.red,
                              size: 20,
                            )),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffFDE7E7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 27.h,
            color: Color(0xffE8E9F6),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${addSummary.subTotal}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ).translate(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Value Added Tax (VAT)'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${addSummary.tax}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ).translate(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charges'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${addSummary.discount}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ).translate(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${addSummary.grandTotal}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontFamily: AppFonts.segoeui,
                            fontWeight: FontWeight.w500),
                      ).translate(),
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
        ],
      ),
    );
  }
}
