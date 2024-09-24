import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/Loader.dart';
import '../../../extentions/colors_convertor.dart';
import '../../../model/add_to_cart_model/add_to_cart_count_model.dart';
import '../../../model/home_sub_category/ProductSearchModel.dart';
import '../../../model/wishlist_models/wishlist_count_model/wishlist_count.dart';
import '../../../utils_services/colors_util.dart';
import '../../../view_model/get_single_user_products/get_single_model_product_repository.dart';
import '../../../view_model/get_single_user_products/get_single_user_product_bloc.dart';
import '../../../view_model/get_single_user_products/get_single_user_product_event.dart';
import '../../../view_model/get_single_user_products/get_single_user_product_state.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/app_font.dart';
import '../../global_widgets/cupertino_dialog.dart';
import '../../global_widgets/image_view_custom.dart';
import '../../global_widgets/web_view_global.dart';
import '../Home/SubCategoriesScreen/sub_categories_screen.dart';
import '../all_shope_product/shope_products.dart';

class ProductDetailPage extends StatefulWidget {
  final String userId;

  const ProductDetailPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with GetSingleUserProductRepository {
  TextEditingController search_controller = TextEditingController();
  var searchText = ''.obs;
  ProductSearchModel? search_result;
  Future get_search_data(String? value) async {
    ProductSearchModel? result =
        await DataProvider.get_search_product(value: value);
    print('${result!.status}');
    search_result = result;
  }

  bool variations_select = false;
  @override
  void initState() {
    print('product id =${widget.userId}');
    // if (storage.hasData('user_cart')) {
    //   addToCardData = getProductSingleUserModel.ADDToCartObject.fromJson(
    //       storage.read('user_cart'));
    // }
    // subscription = add_cart_stream.stream.listen((event) {
    //   counterBloc = AddToCartCountBloc(AddToCartCountInitialState());
    // });
    debounce(searchText, (value) async {
      print('Search value is =$value');
      if (value.toString().isEmpty) {
        search_result = null;
        setState(() {});
      } else {
        await get_search_data(value);
        setState(() {});
      }
    }, time: Duration(milliseconds: 500));
    get_api_data();
    super.initState();
  }

  get_api_data() async {
    getSingleUserProductBloc.add(SingleUserProductEvent(Id: widget.userId));

    await get_count_and_wishList();
    load_data = true;
    setState(() {});
  }

  var refreshController = RefreshController(initialRefresh: false);

  bool load = false;

  @override
  void deactivate() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.deactivate();
  }

  int selectedIndex = 0;

  CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetSingleUserProductBloc, GetSingleUserProductState>(
      bloc: getSingleUserProductBloc,
      listener: (context, state) {
        if (state is GetSingleUserProductErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        print('state is ......... ${state}');
        if (state is GetSingleUserProductLoadingState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ShimmerProductDetailsUi())),
          );
        } else if (state is GetSingleUserProductLoadedState && load_data) {
          return productDetailsUi(context: context, state: state);
        } else {
          return Scaffold();
        }
      },
    );
  }

  Widget ShimmerProductDetailsUi() {
    return Scaffold(
        backgroundColor: Colors.grey.shade200.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.of(context).pop();
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
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
                      color: Colors.grey.shade200.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    controller: search_controller,
                    textInputAction: TextInputAction.search,

                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.black

                      ),
                      hintText: 'Search for product'.tr,
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color:Colors.black),
                      // isDense: true,

                      contentPadding: EdgeInsets.only(top: 7),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.grey.shade200.withOpacity(0.5),
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                  SizedBox(height: 1.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2.h,
                        width: 30.w,
                        color: Colors.grey.shade300,
                      ),
                      Container(
                        height: 2.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Container(
                    height: 35.h,
                    width: 30.w,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 4.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 3.h,
                        width: 30.w,
                        color: Colors.grey.shade300,
                      ),
                      Container(
                        height: 2.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Divider(thickness: 2,color: Colors.black.withAlpha(150),),
                  SizedBox(height: 3.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 3.h,
                        width: 30.w,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2.h,
                        width: 30.w,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(width: 8.w,),
                      Container(
                        height: 2.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Row(

                    children: [
                      Container(
                        height: 5.h,
                        width: 10.w,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(width: 4.w,),
                      Container(
                        height: 3.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(width: 6.w,),
                      Container(
                        height: 3.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),

                  SizedBox(height: 5.h,),
                  Row(

                    children: [
                      Container(
                        height: 4.h,
                        width: 20.w,
                        color: Colors.grey.shade300,
                      ),

                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Row(
                    children: [
                      Container(
                        height: 4.h,
                        width: 40.w,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Divider(thickness: 2,color: Colors.black.withAlpha(150),),
                  SizedBox(height: 2.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Divider(thickness: 2,color: Colors.black.withAlpha(150),),
                  SizedBox(height: 4.h,),
                  ListTile(
                    leading: Container(
                      height: 5.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                    title: Container(
                      height: 3.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                    trailing: Container(
                      height: 3.h,
                      width: 13.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Divider(thickness: 2,color: Colors.black.withAlpha(150),),
                  SizedBox(height: 2.h,),
                  ListTile(
                    leading: Container(
                      height: 5.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                    title: Container(
                      height: 3.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                    trailing: Container(
                      height: 3.h,
                      width: 13.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Container(
                    height: 3.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: 2.h,)
                ],
              ),
            ),
          ),
          // CustomScrollView(
          //   slivers: [
          //     SliverToBoxAdapter(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(height: 5),
          //           Container(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding:
          //                   const EdgeInsets.only(left: 10.0),
          //                   child: Container(
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Expanded(
          //                           child: Container(
          //                             height: 2.h,
          //                             width: 30.w,
          //                             color: Colors.grey.shade300,
          //                           ),
          //                         ),
          //                         Container(
          //                           height: 2.h,
          //                           width: 20.w,
          //                           color: Colors.grey.shade300,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Container(
          //             height: 25.h,
          //             width: 40.w,
          //             color: Colors.grey.shade300,
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 8, vertical: 5),
          //             child:
          //             Divider(color: Colors.black12, height: 0.5),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Row(
          //             mainAxisAlignment:
          //             MainAxisAlignment.spaceBetween,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 10),
          //                 child: Container(
          //                   height: 3.h,
          //                   width: 20.w,
          //                   color: Colors.grey.shade300,
          //                 ),
          //               ),
          //               Row(
          //                 children: [
          //                   Container(
          //                     height: 3.h,
          //                     width: 30.w,
          //                     color: Colors.grey.shade300,
          //                   ),
          //                   SizedBox(
          //                     width: 30,
          //                   )
          //                 ],
          //               ),
          //             ],
          //             //mainAxisAlignment: MainAxisAlignment.end,
          //           ),
          //           // if (state.response!.hasDiscount! &&
          //           //     !variations_select)
          //             Padding(
          //               padding: const EdgeInsets.only(left: 10),
          //               child: Container(
          //                 height: 2.h,
          //                 width: 30.w,
          //                 color: Colors.grey.shade300,
          //               ),
          //             ),
          //           SizedBox(
          //             height: 2,
          //           ),
          //           Padding(
          //             padding:
          //             const EdgeInsets.symmetric(horizontal: 10),
          //             child: Row(
          //               children: [
          //                 RatingBar.builder(
          //                   initialRating: 0,
          //                   minRating: 0,
          //                   direction: Axis.horizontal,
          //                   allowHalfRating: true,
          //                   itemCount: 5,
          //                   itemSize: 14,
          //                   itemPadding:
          //                   EdgeInsets.symmetric(horizontal: 0.3),
          //                   itemBuilder: (context, _) => Icon(
          //                     Icons.star,
          //                     color: Colors.grey.shade300,
          //                   ),
          //                   onRatingUpdate: (rating) {
          //                     print(rating);
          //                   },
          //                 ),
          //                 Container(
          //                   height: 4.h,
          //                   width: 20.w,
          //                   color: Colors.grey.shade300,
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 8, vertical: 5),
          //             child:
          //             Divider(color: Colors.black12, height: 0.5),
          //           ),
          //           // if (state.response!.choiceOptions!.isNotEmpty ||
          //           //     state.selectedColorsVariant!.isNotEmpty)
          //             Container(
          //               width: 50.h,
          //               padding: EdgeInsets.symmetric(horizontal: 10),
          //               child: Column(
          //                 crossAxisAlignment:
          //                 CrossAxisAlignment.start,
          //                 children: [
          //                   SizedBox(
          //                     height: 1.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       Container(
          //                         height: 4.h,
          //                         width: 30.w,
          //                         color: Colors.grey.shade300,
          //                       ),
          //                       Padding(
          //                         padding:
          //                         const EdgeInsets.all(8.0),
          //                         child: InkWell(
          //                           onTap: () {
          //
          //                           },
          //                           child: Container(
          //                             height: 4.h,
          //                             width: 8.h,
          //                             decoration: BoxDecoration(
          //                               color: Colors.grey.shade300,
          //                               borderRadius:
          //                               BorderRadius.circular(
          //                                   4),
          //                             ),
          //                             child: Center(
          //                                 child: Padding(
          //                                   padding:
          //                                   const EdgeInsets.all(
          //                                       2.0),
          //                                   child: Text(
          //                                     '',
          //                                     style: TextStyle(
          //                                         fontSize: 14,
          //                                         color: Colors.black,
          //                                         fontFamily: AppFonts
          //                                             .segoeui),
          //                                   ),
          //                                 )),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: 1.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       Text('Colors :   '.tr,
          //                           style: TextStyle(
          //                               fontSize: 14)),
          //                       InkWell(
          //                         onTap: () {
          //
          //                         },
          //                         child: Container(
          //                           height: 3.h,
          //                           width: 6.h,
          //                           decoration: BoxDecoration(
          //                               shape:
          //                               BoxShape.circle,
          //                               color:Colors.grey.shade300,
          //                               ),
          //                         ),
          //                       ),
          //
          //                         InkWell(
          //                           onTap: () {
          //
          //                           },
          //                           child: Container(
          //                             padding:
          //                             EdgeInsets.all(5),
          //                             child: Text('',
          //                                 style: TextStyle(
          //                                     color:
          //                                     Colors.black,
          //                                     fontSize: 12)),
          //                             decoration: BoxDecoration(
          //                                 color: grey,
          //                                 borderRadius:
          //                                 BorderRadius
          //                                     .circular(7)),
          //                           ),
          //                         )
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: 3.h,
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 8, vertical: 5),
          //                     child: Divider(
          //                         color: Colors.black12, height: 0.5),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   ''.tr,
          //                   style: TextStyle(
          //                       color: Theme.of(context).brightness ==
          //                           Brightness.light
          //                           ? Colors.black
          //                           : Colors.white,
          //                       fontSize: 18,
          //                       fontFamily: AppFonts.segoeui),
          //                 ),
          //                 SizedBox(
          //                   height: 1.h,
          //                 ),
          //                 InkWell(
          //                   onTap: () {
          //
          //                   },
          //                   child: Row(
          //                     children: [
          //                       SizedBox(
          //                         width: 130,
          //                         child: Text(
          //                           ''.tr,
          //                           style: TextStyle(
          //                               color: Theme.of(context)
          //                                   .brightness ==
          //                                   Brightness.light
          //                                   ? Colors.black
          //                                   : Colors.white,
          //                               fontSize: 14,
          //                               fontFamily:
          //                               AppFonts.segoeui),
          //                         ),
          //                       ),
          //                       Text(
          //                         '',
          //                         style: TextStyle(
          //                             overflow:
          //                             TextOverflow.ellipsis,
          //                             color: Theme.of(context)
          //                                 .brightness ==
          //                                 Brightness.light
          //                                 ? Colors.black
          //                                 : Colors.white,
          //                             fontSize: 14),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 0.5.h,
          //                 ),
          //                 Row(
          //                   children: [
          //                     SizedBox(
          //                       width: 130,
          //                       child: Text(
          //                         ' '.tr,
          //                         style: TextStyle(
          //                             color: Theme.of(context)
          //                                 .brightness ==
          //                                 Brightness.light
          //                                 ? Colors.black
          //                                 : Colors.white,
          //                             fontSize: 14,
          //                             fontFamily:
          //                             AppFonts.segoeui),
          //                       ),
          //                     ),
          //                     RichText(
          //                       text: TextSpan(
          //                           text:
          //                           ''
          //                               .tr,
          //                           style: TextStyle(
          //                               color: Theme.of(context)
          //                                   .brightness ==
          //                                   Brightness.light
          //                                   ? Colors.black
          //                                   : Colors.white,
          //                               fontSize: 14,
          //                               fontFamily:
          //                               AppFonts.segoeui),
          //                           children: <TextSpan>[
          //                             TextSpan(
          //                                 text:
          //                                 ' ',
          //                                 style: TextStyle(
          //                                     fontSize: 10,
          //                                     fontFamily:
          //                                     AppFonts
          //                                         .segoeui),
          //                                 recognizer:
          //                                 TapGestureRecognizer()
          //                                   ..onTap = () {
          //                                     // navigate to desired screen
          //                                   }),
          //                           ]),
          //                     )
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 0.5.h,
          //                 ),
          //                 Row(
          //                   children: [
          //                     SizedBox(
          //                       width: 130,
          //                       child: Text(
          //                         ' '.tr,
          //                         style: TextStyle(
          //                             color: Theme.of(context)
          //                                 .brightness ==
          //                                 Brightness.light
          //                                 ? Colors.black
          //                                 : Colors.white,
          //                             fontSize: 14,
          //                             fontFamily:
          //                             AppFonts.segoeui),
          //                       ),
          //                     ),
          //                     RichText(
          //                       text: TextSpan(
          //                           text:
          //                           ''
          //                               .replaceAll(
          //                               '-', ''),
          //                           style: TextStyle(
          //                               color: Theme.of(context)
          //                                   .brightness ==
          //                                   Brightness.light
          //                                   ? Colors.black
          //                                   : Colors.white,
          //                               fontSize: 14),
          //                           children: <TextSpan>[
          //                             TextSpan(
          //                                 text:
          //                                 '',
          //                                 style: TextStyle(
          //                                     fontSize: 10),
          //                                 recognizer:
          //                                 TapGestureRecognizer()
          //                                   ..onTap = () {
          //                                     // navigate to desired screen
          //                                   }),
          //                             TextSpan(
          //                                 text: '  ',
          //                                 style: TextStyle(
          //                                     fontSize: 14),
          //                                 recognizer:
          //                                 TapGestureRecognizer()
          //                                   ..onTap = () {
          //                                     // navigate to desired screen
          //                                   }),
          //                           ]),
          //                     )
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Builder(builder: (context) {
          //             return Container(
          //               padding: EdgeInsets.symmetric(horizontal: 10),
          //               child: Column(
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 8, vertical: 5),
          //                       child: Divider(
          //                           color: Colors.black12,
          //                           height: 0.5),
          //                     ),
          //                     Text(
          //                       ''.tr,
          //                       style: TextStyle(
          //                           color: Theme.of(context)
          //                               .brightness ==
          //                               Brightness.light
          //                               ? Colors.black
          //                               : Colors.white,
          //                           fontSize: 18,
          //                           fontFamily: AppFonts.segoeui),
          //                     ),
          //                     SizedBox(height: 7),
          //                     Row(
          //                       children: [
          //                         InkWell(
          //                           onTap: () {
          //
          //                           },
          //                           child: Container(
          //                               margin: EdgeInsets.only(
          //                                   right: 10),
          //                               decoration: BoxDecoration(
          //                                   borderRadius:
          //                                   BorderRadius.circular(
          //                                       7),
          //                                   color: Color(0xfff2f2f2)),
          //                               child: Container(
          //                                 padding:
          //                                 const EdgeInsets.all(
          //                                     7.0),
          //                                 child: Text(
          //                                     ''),
          //                               )),
          //                         )
          //                       ],
          //                     ),
          //                     SizedBox(height: 10),
          //                     Padding(
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 8, vertical: 5),
          //                       child: Divider(
          //                           color: Colors.black12,
          //                           height: 0.5),
          //                     ),
          //                   ],
          //                   crossAxisAlignment:
          //                   CrossAxisAlignment.start),
          //             );
          //           }),
          //           Builder(builder: (context) {
          //         return Container(
          //           padding: EdgeInsets.symmetric(
          //               horizontal: 10),
          //           child: Column(
          //               children: [
          //                 Text(
          //                   ''.tr,
          //                   style: TextStyle(
          //                       color: Theme.of(context)
          //                           .brightness ==
          //                           Brightness.light
          //                           ? Colors.black
          //                           : Colors.white,
          //                       fontSize: 18,
          //                       fontFamily:
          //                       AppFonts.segoeui),
          //                 ),
          //                 SizedBox(height: 7),
          //                 Row(
          //                   children: [
          //                     InkWell(
          //                       onTap: () {
          //
          //                       },
          //                       child: Container(
          //                           margin:
          //                           EdgeInsets.only(
          //                               right: 10),
          //                           decoration: BoxDecoration(
          //                               borderRadius:
          //                               BorderRadius
          //                                   .circular(
          //                                   7),
          //                               color: Color(
          //                                   0xfff2f2f2)),
          //                           child: Container(
          //                             padding:
          //                             const EdgeInsets
          //                                 .all(7.0),
          //                             child: Text(
          //                                 ''),
          //                           )),
          //                     )
          //                   ],
          //                 ),
          //                 SizedBox(height: 10),
          //                 Padding(
          //                   padding: const EdgeInsets
          //                       .symmetric(
          //                       horizontal: 8,
          //                       vertical: 5),
          //                   child: Divider(
          //                       color: Colors.black12,
          //                       height: 0.5),
          //                 ),
          //               ],
          //               crossAxisAlignment:
          //               CrossAxisAlignment.start),
          //         );
          //       }),
          //           Container(
          //             height: 40,
          //             // decoration: BoxDecoration(
          //             //     color: Colors.blueAccent.withOpacity(0.1)),
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10, vertical: 3),
          //             child: Row(children: [
          //
          //               SizedBox(
          //                 width: 3.h,
          //               ),
          //               Text(
          //                 ''.tr,
          //                 style: TextStyle(
          //                     color: Theme.of(context).brightness ==
          //                         Brightness.light
          //                         ? Colors.black
          //                         : Colors.white,
          //                     fontSize: 18,
          //                     fontFamily: AppFonts.segoeui),
          //               ),
          //               SizedBox(
          //                 width: 3.h,
          //               ),
          //               InkWell(
          //                 onTap: () {
          //
          //                 },
          //                 child: Text(
          //                   '',
          //                   style: TextStyle(
          //                       color: Theme.of(context).brightness ==
          //                           Brightness.light
          //                           ? Colors.black
          //                           : Colors.white,
          //                       fontSize: 18,
          //                       fontFamily: AppFonts.segoeui),
          //                 ),
          //               ),
          //             ]),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 8, vertical: 5),
          //             child:
          //             Divider(color: Colors.black12, height: 0.5),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10, vertical: 5),
          //             child: Text(
          //               'Description'.tr,
          //               style: TextStyle(
          //                   color: Theme.of(context).brightness ==
          //                       Brightness.light
          //                       ? Colors.black
          //                       : Colors.white,
          //                   fontSize: 18,
          //                   fontFamily: AppFonts.segoeui),
          //             ),
          //           ),
          //           Container(
          //               padding: EdgeInsets.symmetric(horizontal: 5),
          //               child: Html(
          //                 data: """ """,
          //               )),
          //           SizedBox(height: 10),
          //           const Padding(
          //             padding: EdgeInsets.only(left: 10, right: 10),
          //             child: Divider(
          //               thickness: 1,
          //             ),
          //           ),
          //           Container(
          //             height: 90,
          //             width: 100.w,
          //             child: Row(
          //               mainAxisAlignment:
          //               MainAxisAlignment.spaceEvenly,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                   Column(
          //                     mainAxisAlignment:
          //                     MainAxisAlignment.center,
          //                     children: [
          //                       Container(
          //                           child: Icon(Icons.payments_sharp,
          //                               color: Colors.white,
          //                               size: 30),
          //                           padding: EdgeInsets.all(10),
          //                           decoration: BoxDecoration(
          //                               color: blueGrey,
          //                               shape: BoxShape.circle)),
          //                       SizedBox(height: 5),
          //                       Text(
          //                         ''.tr,
          //                         style: TextStyle(
          //                             color: Theme.of(context)
          //                                 .brightness ==
          //                                 Brightness.light
          //                                 ? Colors.black
          //                                 : Colors.white,
          //                             fontSize: 12,
          //                             fontFamily: AppFonts.segoeui),
          //                       ),
          //                       Text(
          //                         ''.tr,
          //                         style: TextStyle(
          //                             color: Theme.of(context)
          //                                 .brightness ==
          //                                 Brightness.light
          //                                 ? Colors.black
          //                                 : Colors.white,
          //                             fontSize: 12,
          //                             fontFamily: AppFonts.segoeui),
          //                       )
          //                     ],
          //                   ),
          //
          //                   // Column(
          //                   //   mainAxisAlignment:
          //                   //   MainAxisAlignment.center,
          //                   //   children: [
          //                   //     Container(
          //                   //         child: Icon(
          //                   //             Icons.access_time_filled,
          //                   //             color: Colors.white,
          //                   //             size: 30),
          //                   //         padding: EdgeInsets.all(10),
          //                   //         decoration: BoxDecoration(
          //                   //             color: blueGrey,
          //                   //             shape: BoxShape.circle)),
          //                   //     SizedBox(height: 5),
          //                   //     Text(
          //                   //       ''
          //                   //           .tr,
          //                   //       style: TextStyle(
          //                   //           color: Theme.of(context)
          //                   //               .brightness ==
          //                   //               Brightness.light
          //                   //               ? Colors.black
          //                   //               : Colors.white,
          //                   //           fontSize: 12,
          //                   //           fontFamily: AppFonts.segoeui),
          //                   //       maxLines: 2,
          //                   //     ),
          //                   //     Text(
          //                   //       ''.tr,
          //                   //       style: TextStyle(
          //                   //           color: Theme.of(context)
          //                   //               .brightness ==
          //                   //               Brightness.light
          //                   //               ? Colors.black
          //                   //               : Colors.white,
          //                   //           fontSize: 12,
          //                   //           fontFamily: AppFonts.segoeui),
          //                   //       maxLines: 2,
          //                   //     )
          //                   //   ],
          //                   // ),
          //                 Column(
          //                   mainAxisAlignment:
          //                   MainAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                         child: Icon(
          //                             Icons.car_crash_outlined,
          //                             color: Colors.white,
          //                             size: 30),
          //                         padding: EdgeInsets.all(10),
          //                         decoration: BoxDecoration(
          //                             color: blueGrey,
          //                             shape: BoxShape.circle)),
          //                     SizedBox(height: 5),
          //                     Text(
          //                       '',
          //                       style: TextStyle(
          //                           color: Theme.of(context)
          //                               .brightness ==
          //                               Brightness.light
          //                               ? Colors.black
          //                               : Colors.white,
          //                           fontSize: 12,
          //                           fontFamily: AppFonts.segoeui),
          //                     ),
          //                     Text(
          //                       '',
          //                       style: TextStyle(
          //                           color: Theme.of(context)
          //                               .brightness ==
          //                               Brightness.light
          //                               ? Colors.black
          //                               : Colors.white,
          //                           fontSize: 12,
          //                           fontFamily: AppFonts.segoeui),
          //                     )
          //                   ],
          //                 ),
          //                 Column(
          //                   mainAxisAlignment:
          //                   MainAxisAlignment.center,
          //                   children: [
          //                     Container(
          //                         child: Icon(
          //                             Icons.fire_truck_outlined,
          //                             color: Colors.white,
          //                             size: 30),
          //                         padding: EdgeInsets.all(10),
          //                         decoration: BoxDecoration(
          //                             color: blueGrey,
          //                             shape: BoxShape.circle)),
          //                     SizedBox(height: 5),
          //                     Text(
          //                       '',
          //                       style: TextStyle(
          //                           color: Theme.of(context)
          //                               .brightness ==
          //                               Brightness.light
          //                               ? Colors.black
          //                               : Colors.white,
          //                           fontSize: 12,
          //                           fontFamily: AppFonts.segoeui),
          //                     ),
          //                     Text(
          //                       '',
          //                       style: TextStyle(
          //                           color: Theme.of(context)
          //                               .brightness ==
          //                               Brightness.light
          //                               ? Colors.black
          //                               : Colors.white,
          //                           fontSize: 12,
          //                           fontFamily: AppFonts.segoeui),
          //                     )
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const Padding(
          //             padding: EdgeInsets.only(left: 10, right: 10),
          //             child: Divider(
          //               thickness: 1,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           // ExpansionTile(
          //           //   leading: Container(
          //           //     height: 6.h,
          //           //     width: 6.h,
          //           //     decoration: BoxDecoration(
          //           //         shape: BoxShape.circle,
          //           //         color: Theme.of(context).brightness ==
          //           //                 Brightness.dark
          //           //             ? Colors.black
          //           //             : theme_color),
          //           //     child: Center(
          //           //         child: SvgPicture.asset(
          //           //       'assets/svgs/snap.svg',
          //           //       color: Theme.of(context).brightness ==
          //           //               Brightness.light
          //           //           ? Colors.black
          //           //           : Colors.white,
          //           //     )),
          //           //   ),
          //           //   title: Text(
          //           //     'Shipping'.tr,
          //           //     style: TextStyle(
          //           //       fontFamily: AppFonts.segoeui,
          //           //       fontSize: 16,
          //           //       color: Theme.of(context).brightness ==
          //           //               Brightness.light
          //           //           ? Colors.black
          //           //           : Colors.white,
          //           //       fontWeight: FontWeight.w500,
          //           //     ),
          //           //   ),
          //           //   trailing: const Icon(
          //           //     Icons.arrow_forward_ios,
          //           //     size: 20,
          //           //   ),
          //           //   children: [
          //           //     Column(
          //           //       crossAxisAlignment: CrossAxisAlignment.start,
          //           //       children: [
          //           //         RichText(
          //           //           text: TextSpan(
          //           //               text: 'Estimate Shipping Time : '.tr,
          //           //               style: const TextStyle(
          //           //                   color: Colors.black,
          //           //                   fontSize: 14),
          //           //               children: <TextSpan>[
          //           //                 TextSpan(
          //           //                     text:
          //           //                         ' ${state.response!.shippingDays.toString()} Days',
          //           //                     style: TextStyle(
          //           //                         color: Theme.of(context)
          //           //                                     .brightness ==
          //           //                                 Brightness.light
          //           //                             ? Colors.black
          //           //                             : Colors.white,
          //           //                         fontSize: 14),
          //           //                     recognizer:
          //           //                         TapGestureRecognizer()
          //           //                           ..onTap = () {
          //           //                             // navigate to desired screen
          //           //                           })
          //           //               ]),
          //           //         ),
          //           //         SizedBox(
          //           //           height: 1.h,
          //           //         ),
          //           //         RichText(
          //           //           text: TextSpan(
          //           //               text: 'Shipping Cost : '.tr,
          //           //               style: const TextStyle(
          //           //                   color: Colors.black,
          //           //                   fontSize: 14),
          //           //               children: <TextSpan>[
          //           //                 TextSpan(
          //           //                     text: state.response!
          //           //                             .shippingCost!.isEmpty
          //           //                         ? '0'
          //           //                         : ' ${state.response!.shippingCost}',
          //           //                     style: TextStyle(
          //           //                         color: Theme.of(context)
          //           //                                     .brightness ==
          //           //                                 Brightness.light
          //           //                             ? Colors.black
          //           //                             : Colors.white,
          //           //                         fontSize: 14),
          //           //                     recognizer:
          //           //                         TapGestureRecognizer()
          //           //                           ..onTap = () {
          //           //                             // navigate to desired screen
          //           //                           })
          //           //               ]),
          //           //         ),
          //           //       ],
          //           //     ),
          //           //     const SizedBox(
          //           //       height: 10,
          //           //     )
          //           //   ],
          //           // ),
          //           // const Padding(
          //           //   padding:
          //           //       EdgeInsets.only(left: 30, right: 30, top: 20),
          //           //   child: Divider(
          //           //     thickness: 2,
          //           //   ),
          //           // ),
          //           ListTile(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => WebViewGlobal(
          //                       url:
          //                       'https://housy.ae/pages/policies/terms-conditions/',
          //                       title: 'Housy',
          //                     ),
          //                   ));
          //             },
          //             leading: Container(
          //               height: 6.h,
          //               width: 6.h,
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: Theme.of(context).brightness ==
          //                       Brightness.dark
          //                       ? Colors.black
          //                       : theme_color),
          //               child: Center(
          //                   child: SvgPicture.asset(
          //                     'assets/svgs/exchange.svg',
          //                     color: Theme.of(context).brightness ==
          //                         Brightness.light
          //                         ? Colors.black
          //                         : Colors.white,
          //                   )),
          //             ),
          //             title: Text(
          //               'Exchange & Returns'.tr,
          //               style: TextStyle(
          //                 fontFamily: AppFonts.segoeui,
          //                 fontSize: 16,
          //                 color: Theme.of(context).brightness ==
          //                     Brightness.light
          //                     ? Colors.black
          //                     : Colors.white,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             trailing: const Icon(
          //               Icons.arrow_forward_ios,
          //               size: 20,
          //             ),
          //           ),
          //           const Padding(
          //             padding: EdgeInsets.only(
          //                 left: 30, right: 30, top: 20),
          //             child: Divider(
          //               thickness: 2,
          //             ),
          //           ),
          //           ListTile(
          //             onTap: () {
          //
          //             },
          //             leading: Container(
          //               height: 6.h,
          //               width: 6.h,
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: Theme.of(context).brightness ==
          //                       Brightness.dark
          //                       ? Colors.black
          //                       : theme_color),
          //               child: Center(
          //                   child: Icon(
          //                     Icons.rule,
          //                     color: Theme.of(context).brightness ==
          //                         Brightness.light
          //                         ? Colors.black
          //                         : Colors.white,
          //                   )),
          //             ),
          //             title: Text(
          //               ''.tr,
          //               style: TextStyle(
          //                 fontFamily: AppFonts.segoeui,
          //                 fontSize: 16,
          //                 color: Theme.of(context).brightness ==
          //                     Brightness.light
          //                     ? Colors.black
          //                     : Colors.white,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //            // trailing: const Icon(
          //             //   Icons.arrow_forward_ios,
          //             //   size: 20,
          //             // ),
          //           ),
          //           SizedBox(
          //             height: 2.h,
          //           ),
          //           ListTile(
          //             title: Text(''.tr),
          //           ),
          //           Container(
          //             height: 22.h,
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10, vertical: 5),
          //             child: ListView.builder(
          //                 itemBuilder: (context, index) => Padding(
          //                   padding: const EdgeInsets.all(6.0),
          //                   child: InkWell(onTap: (){
          //
          //                   },
          //                     child: Container(
          //                       width: 30.w,
          //                       child: ProductView(
          //                         total_price: '',
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 scrollDirection: Axis.horizontal,
          //                 itemCount: 4),
          //           ),
          //           SizedBox(
          //             height: 1.h,
          //           ),
          //           ListTile(
          //             title: Text('',
          //                 style: TextStyle(fontSize: 18)),
          //           ),
          //        ],
          //       ),
          //     ),
          //     (customerReviewModel != null &&
          //         customerReviewModel!.data!.isNotEmpty)
          //         ? SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //             (BuildContext context, int index) {
          //           return Column(
          //             children: [
          //               ListTile(
          //                 leading: CircularProfileAvatar(
          //                   '',
          //                   radius: 20,
          //                 ),
          //                 title: Text(
          //                     ''),
          //                 subtitle: Row(
          //                   children: [
          //                     Text(
          //                         ''),
          //                     SizedBox(width: 10),
          //                     Container(
          //                       //width: 10.w,
          //                         decoration: BoxDecoration(
          //                           borderRadius:
          //                           BorderRadius.circular(
          //                               16),
          //                           color: offBlackAvatr,
          //                         ),
          //                         child: Padding(
          //                           padding:
          //                           const EdgeInsets.all(
          //                               4.0),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                             MainAxisAlignment
          //                                 .spaceEvenly,
          //                             children: [
          //                               Text(
          //                                 '',
          //                                 style: TextStyle(
          //                                     color:
          //                                     Colors.black,
          //                                     fontSize: 12),
          //                               ),
          //                               Icon(Icons.star,
          //                                   size: 12,
          //                                   color:
          //                                   Colors.black),
          //                             ],
          //                           ),
          //                         ))
          //                   ],
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 15),
          //                 child: Text(
          //                     ''),
          //               ),
          //               SizedBox(
          //                 height: 7,
          //               )
          //             ],crossAxisAlignment: CrossAxisAlignment.start,
          //           );
          //         },
          //         childCount: customerReviewModel!.data!.length,
          //       ),
          //     )
          //         : SliverToBoxAdapter(
          //       child: Center(child: Text('')),
          //     ),
          //     SliverToBoxAdapter(
          //       child: SizedBox(height: 10.h),
          //     )
          //   ],
          // ),
        )


    );
  }

  Widget productDetailsUi(
      {BuildContext? context, GetSingleUserProductLoadedState? state}) {
    int? selected_index_of_variants;
    if (state!.selectedColorsVariant!.isNotEmpty) {
      selected_index_of_variants =
          state.response!.variants!.indexWhere((element) =>
              element.variant ==
              '${state.selectedColorsVariant}-'
                      '${state.selectedAllVariant!.join('')}'
                  .trim());
    } else {
      selected_index_of_variants = state.response!.variants!.indexWhere(
          (element) =>
              element.variant == state.selectedAllVariant!.join('').trim());
    }
    if (selected_index_of_variants != -1) {
      print('${selected_index_of_variants}');
      Future.delayed(Duration(milliseconds: 50), () {
        controller.animateToPage(selected_index_of_variants!);
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context!).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.blueGrey
            : Colors.black,
        // leading: IconButton(
        //   icon: Icon(
        //     CupertinoIcons.back,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                CupertinoIcons.back,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Obx(
                  () => TextField(
                    controller: search_controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (search_result != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => SubCategoriesScreen(
                                      Id: '',
                                      CategoryId: '',
                                      name: '${searchText.value}',
                                      search_result: search_result,
                                    )));
                      }
                    },
                    onChanged: (v) {
                      searchText.value = v;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      hintText: 'Search for product'.tr,
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                      isDense: true,
                      suffixIcon: searchText.value.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                search_controller.clear();
                                searchText.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                      contentPadding: EdgeInsets.only(top: 7),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          BlocConsumer<GetSingleUserProductBloc, GetSingleUserProductState>(
            bloc: getSingleUserProductBloc,
            listener: (context, state) {
              if (state is GetSingleUserProductErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error).translate()));
              }
            },
            builder: (context, state) {
              if (state is GetSingleUserProductLoadedState) {
                return PullDownButton(
                  itemBuilder: (context) => [
                    PullDownMenuItem(
                      title: state.response!.published == 0
                          ? 'Publish'.tr
                          : 'unpublished'.tr,
                      onTap: () {
                        show_cupertino_alert(
                            context: context,
                            title: 'You Product will be'.tr +
                                ' ${state.response!.published == '0' ? 'Publish'.tr : 'unpublished'.tr} ' +
                                'on Marketplace.'.tr,
                            ok: () async {
                              String message =
                                  await DataProvider.publish_product_api(
                                      id: 'product/'.tr +
                                          '${widget.userId}' +
                                          '/status/seller'.tr,
                                      object: {
                                    'published'.tr:
                                        state.response!.published == 0
                                            ? '1'
                                            : '0'
                                  });
                              snackBarSuccess('${message}');
                              if (state.response!.published == 1) {
                                state.response!.published = 0;
                              } else {
                                state.response!.published = 1;
                              }
                              setState(() {});
                            });
                      },
                    ),
                    // const PullDownMenuDivider(),
                    // PullDownMenuItem(
                    //   title: 'Edit'.tr,
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => AddProduct(
                    //             model: state.response!,
                    //             isedit: true,
                    //           ),
                    //         ));
                    //   },
                    // ),
                    const PullDownMenuDivider(),
                    PullDownMenuItem(
                      title: 'Delete'.tr,
                      onTap: () {
                        show_cupertino_alert(
                            context: context,
                            title: 'Product will be deleted permanently'.tr,
                            ok: () async {
                              await DataProvider.delete_product_api(
                                  id: state.response!.id.toString());
                              Navigator.of(context).pop('delete');
                            });
                      },
                    ),
                  ],
                  position: PullDownMenuPosition.over,
                  buttonBuilder: (context, showMenu) => CupertinoButton(
                    onPressed: showMenu,
                    padding: EdgeInsets.only(left: 10),
                    child: const Icon(Icons.more_vert_outlined,
                        color: Colors.white),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: searchText.value.isEmpty
          ? Stack(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      child: Text(
                                        '${state.response!.name}',
                                        style: TextStyle(
                                          fontFamily: AppFonts.segoeui,
                                          fontSize: 19,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            selected_index_of_variants == -1
                                ? CarouselSlider.builder(
                                    itemCount: state.response!.photos!.length,
                                    carouselController: controller,
                                    itemBuilder: (context, index, realIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(ImageView(
                                              imageV: state.response!.photos!,
                                              slectedIndex: index,
                                            ));
                                          },
                                          child: Container(
                                            width: 80.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${state.response!.photos![index]}",
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.white,
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://staging.housy.ae/public/assets/img/placeholder.jpg'),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 25.0.h,
                                    ))
                                : CarouselSlider.builder(
                                    itemCount: state.response!.variants!.length,
                                    carouselController: controller,
                                    itemBuilder: (context, index, realIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            List<String> images = [];
                                            state.response!.variants!
                                                .forEach((element) {
                                              images.add(element.path!);
                                            });
                                            Get.to(ImageView(
                                              imageV: images,
                                              slectedIndex: index,
                                            ));
                                          },
                                          child: Container(
                                            width: 80.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${state.response!.variants![index].path}",
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.white,
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://staging.housy.ae/public/assets/img/placeholder.jpg'),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 25.0.h,
                                    )),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child:
                                  Divider(color: Colors.black12, height: 0.5),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RichText(
                                    text: TextSpan(
                                        text: !variations_select
                                            ? 'AED' +
                                                double.parse(
                                                        '${state.response!.calculablePrice}')
                                                    .round()
                                                    .toString()
                                            : selected_index_of_variants == -1
                                                ? '${state.response!.currencySymbol}${state.response!.calculablePrice!.round()}'
                                                : '${state.response!.currencySymbol}${state.response!.variants![selected_index_of_variants].price}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 25,
                                            fontFamily: AppFonts.segoeui),
                                        children: <TextSpan>[]),
                                  ),
                                ),
                              ],
                              //mainAxisAlignment: MainAxisAlignment.end,
                            ),
                            if (state.response!.hasDiscount! &&
                                !variations_select)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: RichText(
                                  text: TextSpan(
                                      text: '${state.response!.strokedPrice}',
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black38
                                              : Colors.white,
                                          fontSize: 18,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontFamily: AppFonts.segoeui),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '  ${state.response!.discount} Off'
                                                  .replaceAll('-', '')
                                                ..replaceAll('%', ''),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.green,
                                              decoration: TextDecoration.none,
                                              fontFamily: AppFonts.segoeui),
                                        ),
                                      ]),
                                ),
                              ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child:
                                  Divider(color: Colors.black12, height: 0.5),
                            ),
                            if (state.response!.choiceOptions!.isNotEmpty ||
                                state.selectedColorsVariant!.isNotEmpty)
                              Container(
                                width: 50.h,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    ...state.response!.choiceOptions!.map((e1) {
                                      int index = state.response!.choiceOptions!
                                          .indexOf(e1);
                                      return Row(
                                        children: [
                                          Text(
                                            '${e1.title!.name} : ',
                                            style: TextStyle(
                                                fontFamily: AppFonts.segoeui,
                                                fontSize: 14),
                                          ),
                                          ...e1.options!.map((e2) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (state.selectedAllVariant!
                                                      .isNotEmpty) {
                                                    state.selectedAllVariant![
                                                        index] = e2;
                                                    variations_select = true;
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  height: 4.h,
                                                  width: 8.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        state.selectedAllVariant!
                                                                    .contains(
                                                                        e2) &&
                                                                variations_select
                                                            ? Color(0xfff2f2f2)
                                                            : Colors
                                                                .transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      '${e2}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              AppFonts.segoeui),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      );
                                    }).toList(),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    state.selectedColorsVariant!.isEmpty
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text('Colors :   '.tr,
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              ...state.response!.colors!
                                                  .map((e) {
                                                String? value =
                                                    state.selectedColorsVariant;
                                                GetSingleUserProductLoadedState
                                                    s = state;
                                                return InkWell(
                                                  onTap: () {
                                                    s.selectedColorsVariant =
                                                        e.name;
                                                    variations_select = true;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    height: 3.h,
                                                    width: 6.h,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: HexColor.fromHex(
                                                            e.code!),
                                                        border: Border.all(
                                                            color: e.name ==
                                                                        value &&
                                                                    variations_select
                                                                ? blueGrey
                                                                : Colors
                                                                    .transparent,
                                                            width: 1)),
                                                  ),
                                                );
                                              }).toList(),
                                              if (variations_select)
                                                InkWell(
                                                  onTap: () {
                                                    variations_select = false;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text('Clear',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12)),
                                                    decoration: BoxDecoration(
                                                        color: offBlackAvatr,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                  ),
                                                )
                                            ],
                                          ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Divider(
                                          color: Colors.black12, height: 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Details'.tr,
                                    style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 18,
                                        fontFamily: AppFonts.segoeui),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  state.response!.brand!.name!.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        SingleShopProducts(
                                                          shopId: state
                                                              .response!
                                                              .brand!
                                                              .id
                                                              .toString(),
                                                          shopName: state
                                                              .response!
                                                              .brand!
                                                              .name,
                                                          is_brand: true,
                                                        )));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 130,
                                                child: Text(
                                                  'Brand'.tr,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          AppFonts.segoeui),
                                                ),
                                              ),
                                              Text(
                                                '${state.response!.brand!.name}',
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          'Rating'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 14,
                                              fontFamily: AppFonts.segoeui),
                                        ),
                                      ),
                                      Text(
                                        '${state.response!.rating!.toDouble()}',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  selected_index_of_variants != -1
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                'Price Range'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppFonts.segoeui),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      '${state.response!.priceHighLow} - ${state.response!.strokedPrice} ',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          AppFonts.segoeui),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            '/${state.response!.unit}',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontFamily: AppFonts
                                                                .segoeui),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                // navigate to desired screen
                                                              }),
                                                  ]),
                                            )
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                'Price Range'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppFonts.segoeui),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      '${state.response!.strokedPrice}'
                                                          .tr,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          AppFonts.segoeui),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            ' / ${state.response!.unit}',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: AppFonts
                                                                .segoeui),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                // navigate to desired screen
                                                              }),
                                                  ]),
                                            )
                                          ],
                                        ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  state.response!.hasDiscount == true
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                'Discount Price'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppFonts.segoeui),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      'AED${state.response!.calculablePrice} - ${state.response!.mainPrice}'
                                                          .tr,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 14),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            '/${state.response!.unit}',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                // navigate to desired screen
                                                              }),
                                                  ]),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Builder(builder: (context) {
                              List data = state.response!.stages!;
                              if (data.isEmpty) {
                                return SizedBox();
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        child: Divider(
                                            color: Colors.black12, height: 0.5),
                                      ),
                                      Text(
                                        'Stages'.tr,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 18,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        children: data.map((e) {

                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (c) =>
                                                          SingleShopProducts(
                                                            shopId:
                                                                '${e['value']}',
                                                            shopName:
                                                                '${e['value']}',
                                                            is_brand: false,
                                                            is_stages: true,
                                                          )));
                                            },
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xfff2f2f2)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child:
                                                      Text('${e['value']}'),
                                                )),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        child: Divider(
                                            color: Colors.black12, height: 0.5),
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start),
                              );
                            }),
                            Builder(builder: (context) {
                              List data = state.response!.tags!;
                              print('tags = ${data}');
                              if (data.isEmpty || data[0] is String) {
                                return SizedBox();
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                    children: [
                                      Text(
                                        'Tags'.tr,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 18,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        children: data.map((e) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (c) =>
                                                          SingleShopProducts(
                                                            shopId:
                                                                '${e['value']}',
                                                            shopName:
                                                                '${e['value']}',
                                                            is_brand: false,
                                                            is_stages: true,
                                                          )));
                                            },
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: Color(0xfff2f2f2)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child:
                                                      Text('${e['value']}'),
                                                )),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        child: Divider(
                                            color: Colors.black12, height: 0.5),
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start),
                              );
                            }),
                            // Container(
                            //   height: 40,
                            //   // decoration: BoxDecoration(
                            //   //     color: Colors.blueAccent.withOpacity(0.1)),
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 3),
                            //   child: Row(children: [
                            //     Image.asset('assets/image/shop.png'),
                            //     SizedBox(
                            //       width: 3.h,
                            //     ),
                            //     Text(
                            //       'Sold by  '.tr,
                            //       style: TextStyle(
                            //           color: Theme.of(context).brightness ==
                            //                   Brightness.light
                            //               ? Colors.black
                            //               : Colors.white,
                            //           fontSize: 18,
                            //           fontFamily: AppFonts.segoeui),
                            //     ),
                            //     SizedBox(
                            //       width: 3.h,
                            //     ),
                            //     InkWell(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (c) => SingleShopProducts(
                            //                       shopId: state.response!.shopId
                            //                           .toString(),
                            //                       shopName:
                            //                           state.response!.shopName,
                            //                     )));
                            //       },
                            //       child: Text(
                            //         '${state.response!.shopName}',
                            //         style: TextStyle(
                            //             color: Theme.of(context).brightness ==
                            //                     Brightness.light
                            //                 ? Colors.black
                            //                 : Colors.white,
                            //             fontSize: 18,
                            //             fontFamily: AppFonts.segoeui),
                            //       ),
                            //     ),
                            //   ]),
                            // ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8, vertical: 5),
                            //   child:
                            //       Divider(color: Colors.black12, height: 0.5),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Description'.tr,
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18,
                                    fontFamily: AppFonts.segoeui),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Html(
                                  data: """${state.response!.description}""",
                                )),
                            SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Container(
                              height: 90,
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (state.response!.cashOnDelivery == 'Yes')
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(Icons.payments_sharp,
                                                color: Colors.white, size: 30),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: blueGrey,
                                                shape: BoxShape.circle)),
                                        SizedBox(height: 5),
                                        Text(
                                          'Cash on'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 12,
                                              fontFamily: AppFonts.segoeui),
                                        ),
                                        Text(
                                          'delivery'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 12,
                                              fontFamily: AppFonts.segoeui),
                                        )
                                      ],
                                    ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Icon(Icons.access_time_filled,
                                              color: Colors.white, size: 30),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: blueGrey,
                                              shape: BoxShape.circle)),
                                      SizedBox(height: 5),
                                      Text(
                                        '${state.response!.shippingDays.toString()} days'
                                            .tr,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        'delivery'.tr,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Icon(Icons.car_crash_outlined,
                                              color: Colors.white, size: 30),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: blueGrey,
                                              shape: BoxShape.circle)),
                                      SizedBox(height: 5),
                                      Text(
                                        state.response!.shippingType == 'free'
                                            ? 'Free Delivery'.tr
                                            : 'AED${state.response!.shippingCost} Shipping',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      Text(
                                        state.response!.shippingType == 'free'
                                            ? ''.tr
                                            : 'charges',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Icon(Icons.fire_truck_outlined,
                                              color: Colors.white, size: 30),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: blueGrey,
                                              shape: BoxShape.circle)),
                                      SizedBox(height: 5),
                                      Text(
                                        'Fulfilled by',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                      ),
                                      Text(
                                        'Seller',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 12,
                                            fontFamily: AppFonts.segoeui),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ExpansionTile(
                            //   leading: Container(
                            //     height: 6.h,
                            //     width: 6.h,
                            //     decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Theme.of(context).brightness ==
                            //                 Brightness.dark
                            //             ? Colors.black
                            //             : Colors.grey.shade200),
                            //     child: Center(
                            //         child: SvgPicture.asset(
                            //       'assets/svgs/snap.svg',
                            //       color: Theme.of(context).brightness ==
                            //               Brightness.light
                            //           ? Colors.black
                            //           : Colors.white,
                            //     )),
                            //   ),
                            //   title: Text(
                            //     'Shipping'.tr,
                            //     style: TextStyle(
                            //       fontFamily: AppFonts.segoeui,
                            //       fontSize: 16,
                            //       color: Theme.of(context).brightness ==
                            //               Brightness.light
                            //           ? Colors.black
                            //           : Colors.white,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            //   trailing: const Icon(
                            //     Icons.arrow_forward_ios,
                            //     size: 20,
                            //   ),
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         RichText(
                            //           text: TextSpan(
                            //               text: 'Estimate Shipping Time : '.tr,
                            //               style: const TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 14),
                            //               children: <TextSpan>[
                            //                 TextSpan(
                            //                     text:
                            //                         ' ${state.response!.shippingDays.toString()} Days',
                            //                     style: TextStyle(
                            //                         color: Theme.of(context)
                            //                                     .brightness ==
                            //                                 Brightness.light
                            //                             ? Colors.black
                            //                             : Colors.white,
                            //                         fontSize: 14),
                            //                     recognizer:
                            //                         TapGestureRecognizer()
                            //                           ..onTap = () {
                            //                             // navigate to desired screen
                            //                           })
                            //               ]),
                            //         ),
                            //         SizedBox(
                            //           height: 1.h,
                            //         ),
                            //         RichText(
                            //           text: TextSpan(
                            //               text: 'Shipping Cost : '.tr,
                            //               style: const TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 14),
                            //               children: <TextSpan>[
                            //                 TextSpan(
                            //                     text: state.response!
                            //                             .shippingCost!.isEmpty
                            //                         ? '0'
                            //                         : ' ${state.response!.shippingCost}',
                            //                     style: TextStyle(
                            //                         color: Theme.of(context)
                            //                                     .brightness ==
                            //                                 Brightness.light
                            //                             ? Colors.black
                            //                             : Colors.white,
                            //                         fontSize: 14),
                            //                     recognizer:
                            //                         TapGestureRecognizer()
                            //                           ..onTap = () {
                            //                             // navigate to desired screen
                            //                           })
                            //               ]),
                            //         ),
                            //       ],
                            //     ),
                            //     const SizedBox(
                            //       height: 10,
                            //     )
                            //   ],
                            // ),
                            // const Padding(
                            //   padding:
                            //       EdgeInsets.only(left: 30, right: 30, top: 20),
                            //   child: Divider(
                            //     thickness: 2,
                            //   ),
                            // ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewGlobal(
                                        url:
                                            'https://housy.ae/pages/policies/terms-conditions/',
                                        title: 'Housy',
                                      ),
                                    ));
                              },
                              leading: Container(
                                height: 6.h,
                                width: 6.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.grey.shade200),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/svgs/exchange.svg',
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                )),
                              ),
                              title: Text(
                                'Exchange & Returns'.tr,
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 16,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 30, right: 30, top: 20),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewGlobal(
                                        url:
                                            'https://housy.ae/pages/policies/terms-conditions/',
                                        title: 'Housy',
                                      ),
                                    ));
                              },
                              leading: Container(
                                height: 6.h,
                                width: 6.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.grey.shade200),
                                child: Center(
                                    child: Icon(
                                  Icons.rule,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                )),
                              ),
                              title: Text(
                                'Terms & Condition'.tr,
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 16,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // ListTile(
                            //   title: Text('Related Products'.tr),
                            // ),
                            // Container(
                            //   height: 18.h,
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 5),
                            //   child: ListView.builder(
                            //       itemBuilder: (context, index) => Padding(
                            //             padding: const EdgeInsets.all(6.0),
                            //             child: Container(
                            //               width: 30.w,
                            //               child: ProductView(
                            //                 imageUrl:
                            //                     '${state.response!.thumbnailImg}',
                            //                 textName: '${state.response!.name}',
                            //                 textPrice:
                            //                     '${state.response!.mainPrice}',
                            //                 ratting: state.response!.rating!
                            //                     .toDouble(),
                            //                 visible:
                            //                     state.response!.hasDiscount ==
                            //                             false
                            //                         ? false
                            //                         : true,
                            //                 textDiscount:
                            //                     '${state.response!.discount!.toString().replaceAll('-', '').trim()}',
                            //                 isActive:
                            //                     state.response!.published ==
                            //                             'Yes'
                            //                         ? true
                            //                         : false,
                            //               ),
                            //             ),
                            //           ),
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: products!.data!.length),
                            // ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //     bottom: 0,
                //     child: Container(
                //       height: 45,
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(children: [
                //         Container(
                //           height: 4.h,
                //           width: 13.h,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             // color: Color(0xffE8E9F6),
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               InkWell(
                //                 onTap: () {
                //                   print(
                //                       'click abc = ${state.count!} ${state.response!.minQty!}');
                //                   if (state.count! > state.response!.minQty!) {
                //                     setState(() {
                //                       state.count = state.count! - 1;
                //                     });
                //                   }
                //                 },
                //                 child: Container(
                //                   height: 3.5.h,
                //                   width: 3.5.h,
                //                   decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: Theme.of(context).brightness ==
                //                             Brightness.dark
                //                         ? Colors.blueGrey
                //                         : Colors.grey.shade200,
                //                   ),
                //                   child: const Icon(
                //                     CupertinoIcons.minus,
                //                     size: 16,
                //                   ),
                //                 ),
                //               ),
                //               Text('${state.count}'),
                //               InkWell(
                //                 onTap: () {
                //                   setState(() {
                //                     state.count = state.count! + 1;
                //                   });
                //                 },
                //                 child: Container(
                //                   height: 3.5.h,
                //                   width: 3.5.h,
                //                   decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: Theme.of(context).brightness ==
                //                             Brightness.dark
                //                         ? Colors.blueGrey
                //                         : Colors.grey.shade200,
                //                   ),
                //                   child: const Icon(
                //                     CupertinoIcons.add,
                //                     size: 16,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         )
                //       ]),
                //       decoration: BoxDecoration(
                //           color: Theme.of(context).brightness == Brightness.dark
                //               ? Colors.black
                //               : Colors.white,
                //           boxShadow: [
                //             BoxShadow(
                //                 color: Colors.black12,
                //                 offset: Offset(0, -1),
                //                 blurRadius: 5)
                //           ]),
                //     )),
                if (load)
                  Center(
                    child: screenLoader(use_opacity: true),
                  )
              ],
            )
          : search_result == null
              ? SizedBox()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: SizedBox(
                      height: 10,
                    )),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ProductDetailPage(
                                        userId: search_result!.data![index]!.id
                                            .toString(),
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${search_result!.data![index]!.thumbnailImg}',
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.white,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                                  'https://staging.housy.ae/public/assets/img/placeholder.jpg'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                            '${search_result!.data![index]!.name}',
                                            style: TextStyle(
                                                fontFamily: AppFonts.segoeui)),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: search_result!.data!.length,
                      ),
                    )
                  ],
                ),
    );
  }
  

  Widget textView({AddCartCountModel? countModel}) {
    return Text(
      countModel == null ? '' : '${countModel.count}',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget wishlistCounting({WishlistCountModel? wishlistCounting}) {
    return Text(
      wishlistCounting == null ? '' : '${wishlistCounting.count}',
      style: TextStyle(color: Colors.white),
    );
  }

  void ButttomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: 40.h,
            child: Column(
              children: [
                Container(
                  height: 8.h,
                  color: const Color(0xffF76631),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Confirmation',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.segoeui,
                            )),
                        const Icon(
                          CupertinoIcons.clear,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 22.h,
                  // color: Colors.grey,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 8.h,
                              width: 7.5.h,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jacket With Pockets',
                                  style: TextStyle(
                                      //color: const Color(0xff524EB7),
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Zara',
                                  style: TextStyle(
                                      //color: const Color(0xff524EB7),
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 3.h,
                                      width: 7.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xffE8E9F6),
                                      ),
                                      child: Row(
                                        children: const [
                                          Text(
                                            '  Size:',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            'M',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 3.h,
                                      width: 7.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: const Color(0xffE8E9F6)),
                                      child: Row(
                                        children: [
                                          const Text(
                                            ' Color:',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Container(
                                            height: 1.5.h,
                                            width: 2.h,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 3.h,
                                      width: 7.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xffE8E9F6),
                                      ),
                                      child: Row(
                                        children: const [
                                          Text(
                                            ' QTY:',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            '01',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              '\$50.0',
                              style: TextStyle(
                                  color: const Color(0xff524EB7),
                                  fontFamily: AppFonts.segoeui,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 5.h,
                  width: 26.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff524EB7)),
                  child: Center(
                    child: Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
