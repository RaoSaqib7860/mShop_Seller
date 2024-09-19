import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';

import '../../../../api_repo/basepath.dart';
import '../../../../extentions/app_colors.dart';
import '../../../../model/home_sub_category/get_all_product_categories_model.dart';
import '../../../../model/home_sub_category/sub_categories_model.dart';
import '../../../../utils_services/refresh_controller.dart';
import '../../../global_widgets/app_font.dart';
import '../../../global_widgets/products_view_widget.dart';
import '../../Products/product_details.dart';
import '../SubCategoriesScreen/sub_categories_of_categories_screen.dart';
import '../SubCategoriesScreen/sub_categories_screen.dart';

Widget grid_view_product(
    {BuildContext? context,
    SubCategoriesModel? subCategoriesModels,
    GetAllProductOfCategories? getAllProductOfCategoriess,
    int? cross_cout,
    Function(int)? count,
    Function(String)? onChangeStyle,
    Function()? onRefresh,
    Function()? onLoad,
    Function()? update,
    required RefreshController? refreshController,
    bool? show_sub_cat = true,
    String? style}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: RefreshControllerGlobal(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: CustomScrollView(
        slivers: [
          !show_sub_cat!
              ? SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                    ],
                  ),
                )
              : SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subCategoriesModels!.data!.isNotEmpty)
                        SizedBox(
                          height: 0.5.h,
                        ),
                      if (subCategoriesModels.data!.isNotEmpty)
                        Container(
                          height: 12.h,
                          child: ListView.builder(
                            itemCount: subCategoriesModels.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubCategoriesScreen(
                                          Id: '${subCategoriesModels.data![index].id}',
                                          CategoryId:
                                              '${subCategoriesModels.data![index].id}',
                                          name:
                                              '${subCategoriesModels.data![index].name}',
                                          has_sub_cat: false,
                                        ),
                                      ));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           subCategoriesOfCategoriesScreen(
                                  //             CategoryId:
                                  //             subCategoriesModels
                                  //                 .data![index].id
                                  //                 .toString(),
                                  //             cat_name: subCategoriesModels
                                  //                 .data![index].name,
                                  //           ),
                                  //     ));
                                },
                                child: Container(
                                  height: 12.h,
                                  width: 20.w,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration:
                                      BoxDecoration(color: Color(0xfff3f4f1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 46,
                                          decoration: BoxDecoration(
                                              color: Color(0xffdcdbdd)),
                                          child: Center(
                                            child: Image.network(
                                                '${subCategoriesModels.data![index].icon}'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        '${subCategoriesModels.data![index].name}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (subCategoriesModels.data!.isNotEmpty)
                        SizedBox(
                          height: 10,
                        )
                    ],
                  ),
                ),
          getAllProductOfCategoriess!.data!.isEmpty
              ? SliverToBoxAdapter(
                  child: SizedBox(
                      child: Center(child: Text('No Products'.tr)),
                      height: 600,
                      width: 100.w),
                )
              : style == 'grid'
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 0.7),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (c) => ProductDetailPage(
                                              userId: getAllProductOfCategoriess
                                                  .data![index].id
                                                  .toString(),
                                            )))
                                    .then((value) {
                                  if (value == 'delete') {
                                    update!.call();
                                  }
                                });
                              },
                              child: ProductView(
                                imageUrl:
                                    '${getAllProductOfCategoriess.data![index].thumbnailImg}',
                                textName:
                                    '${getAllProductOfCategoriess.data![index].name}',
                                textPrice:
                                    '${getAllProductOfCategoriess.data![index].mainPrice}',
                                ratting: getAllProductOfCategoriess
                                    .data![index].rating!
                                    .toDouble(),
                                isActive: getAllProductOfCategoriess
                                            .data![index].published ==
                                        'Yes'
                                    ? true
                                    : false,
                                addBy:
                                    '${getAllProductOfCategoriess.data![index].addedBy}',
                                stockPrice:
                                    '${getAllProductOfCategoriess.data![index].strokedPrice}',
                                priceHighLow:
                                    '${getAllProductOfCategoriess.data![index].priceHighLow}',
                                visible: getAllProductOfCategoriess
                                            .data![index].hasDiscount ==
                                        false
                                    ? false
                                    : true,
                                textDiscount:
                                    '${getAllProductOfCategoriess.data![index].discount!.toString().replaceAll('-', '').trim()}',
                              ));
                        },
                        childCount: getAllProductOfCategoriess!.data!.length,
                      ),
                    )
                  : list_view_product(getAllProductOfCategoriess, update!)
        ],
      ),
    ),
  );
}

Widget grid_view_products(
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: CustomScrollView(
      slivers: [
         SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 10),
            ],
          ),
        ),
             SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

                SizedBox(
                  height: 0.5.h,
                ),

                Container(
                  height: 12.h,
                  child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 12.h,
                        width: 20.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration:
                        BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                    color: Color(0xffdcdbdd)),
                                child: Center(
                                  child: Image.network(
                                      ''),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Container(
                              height: 2.h,
                              width: 6.w,
                              color: Colors.grey.shade900,

                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                )
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 0,
              childAspectRatio: 0.9),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  decoration:BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Container(
                                height: 15.h,
                                width: 25.w,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 1.w),
                          child: Container(
                            height: 2.h,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 1.w),
                              child: Container(
                                height: 2.h,
                                width: 10.w,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 1.w),
                              child: Container(
                                height: 2.h,
                                width: 8.h,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: 6,
          ),
        )

        //       SliverGrid(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       mainAxisSpacing: 10,
        //       crossAxisSpacing: 0,
        //       childAspectRatio: 0.7),
        //   delegate: SliverChildBuilderDelegate(
        //         (context, index) {
        //       return Container(
        //         height: 8.h,
        //         width: 40.w,
        //         color: Colors.black,
        //       );
        //     },
        //     childCount: 20,
        //   ),
        // )

      ],
    ),
  );
}

Widget list_view_product(
  GetAllProductOfCategories getAllProductOfCategoriess,
  Function() update,
) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (c) => ProductDetailPage(
                            userId: getAllProductOfCategoriess.data![index].id
                                .toString(),
                          )))
                  .then((value) {
                if (value == 'delete') {
                  update.call();
                }
              });
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: AppColors.theme_color,
              ),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 60,
                    padding: EdgeInsets.only(left: 8),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${getAllProductOfCategoriess.data![index].thumbnailImg}",
                      placeholder: (context, url) => Container(
                        color: Colors.blue,
                      ),
                      errorWidget: (context, url, error) => Image.network(
                          '${imageUrl}assets/img/placeholder.jpg'),
                    ),
                    //Image.network('${getAllProductOfCategoriess.data![index].thumbnailImage}'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${getAllProductOfCategoriess.data![index].name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 14,
                            color:
                                Theme.of(context!).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ).translate(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 65.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getAllProductOfCategoriess.data![index].mainPrice}',
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Visibility(
                              visible: getAllProductOfCategoriess
                                          .data![index].hasDiscount ==
                                      false
                                  ? false
                                  : true,
                              child: Text(
                                ' ${getAllProductOfCategoriess.data![index].discount}% OFF',
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                                color: getAllProductOfCategoriess
                                            .data![index].published ==
                                        'Yes'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 2),
                                child: Text(
                                  getAllProductOfCategoriess
                                              .data![index].published ==
                                          'Yes'
                                      ? 'Publish'
                                      : 'Unpublished',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              //width: 10.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: offBlackAvatr,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${getAllProductOfCategoriess.data![index].rating}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Icon(Icons.star,
                                        size: 12, color: Colors.black),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      childCount: getAllProductOfCategoriess.data!.length,
    ),
  );
}
