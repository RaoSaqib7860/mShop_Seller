import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../api_repo/basepath.dart';
import '../../../../model/home_sub_category/ProductSearchModel.dart';
import '../../../../model/home_sub_category/get_all_product_categories_model.dart';
import '../../../../utils_services/Loader.dart';
import '../../../../utils_services/app_font.dart';
import '../../../../utils_services/colors_util.dart';
import '../../../../view_model/sub_categories_blocs/sub_categories_bloc.dart';
import '../../../../view_model/sub_categories_blocs/sub_categories_event.dart';
import '../../../../view_model/sub_categories_blocs/sub_categories_repository.dart';
import '../../../../view_model/sub_categories_blocs/sub_categories_state.dart';
import '../../Products/product_details.dart';
import '../components/home_grid_list_view.dart';

class SubCategoriesScreen extends StatefulWidget {
  String? Id;
  String? CategoryId;
  String? name;
  final ProductSearchModel? search_result;
  final bool? has_sub_cat;
  SubCategoriesScreen(
      {Key? key,
      this.Id = '',
      this.CategoryId,
      this.name,
      this.search_result,
      this.has_sub_cat = false})
      : super(key: key);

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen>
    with SubCateGorybloc {
  @override
  void initState() {
    page = 1;
    if (widget.search_result == null) {
      subCategoriesBloc.add(SubCategoriesEvent(
          ID: widget.Id,
          catId: widget.Id,
          page: page,
          has_sub_cat: widget.has_sub_cat));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text('${widget.name}',
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.segoeui))
            .translate(),
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              size: 5.w,
            )),
        actions: [
          InkWell(
            onTap: () {
              if (cross_count == 2) {
                cross_count = 3;
              } else {
                cross_count = 2;
              }
              style = 'grid';
              setState(() {});
            },
            child: SvgPicture.asset(
              'assets/svgs/c.svg',
              height: 2.h,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          InkWell(
            onTap: () {
              if (style == 'grid') {
                style = 'list';
              } else {
                style = 'grid';
              }
              setState(() {});
            },
            child: SvgPicture.asset(
              'assets/svgs/d.svg',
              height: 2.0.h,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
        ],
      ),
      body: widget.Id!.isEmpty
          ? search_grid()
          : BlocConsumer<SubCategoriesBloc, SubCategoriesScreenState>(
              bloc: subCategoriesBloc,
              listener: (context, state) {
                if (state is SubCategoriesErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is SubCategoriesLoadingState) {
                  return Center(child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: grid_view_products()));
                } else if (state is SubCategoriesLoadedState) {
                  return grid_view_product(
                      context: context,
                      refreshController: refreshController,
                      onLoad: () async {
                        GetAllProductOfCategories responce =
                            await getallProduct(cat_id: widget.CategoryId);
                        state.res.data!.addAll(responce.data!);
                        setState(() {});
                        refreshController.loadComplete();
                      },
                      onRefresh: () async {
                        page = 1;
                        if (widget.search_result == null) {
                          subCategoriesBloc.add(SubCategoriesEvent(
                              ID: widget.Id,
                              catId: widget.Id,
                              page: page,
                              has_sub_cat: widget.has_sub_cat));
                        }
                        refreshController.refreshCompleted();
                      },
                      count: (v) {
                        cross_count = v;
                        style = 'grid';
                        setState(() {});
                      },
                      onChangeStyle: (v) {
                        style = v;
                        setState(() {});
                      },
                      update: () {
                        subCategoriesBloc.add(SubCategoriesEvent(
                            catId: widget.Id,
                            ID: widget.Id,
                            has_sub_cat: widget.has_sub_cat));
                      },
                      getAllProductOfCategoriess: state.res,
                      style: style,
                      show_sub_cat: widget.Id == '-1' ? false : true,
                      subCategoriesModels: state.response,
                      cross_cout: cross_count);
                } else {
                  return Text('data'.tr);
                }
              },
            ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
  }

  Widget search_grid() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: CustomScrollView(slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.9),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => ProductDetailPage(
                              userId: widget.search_result!.data![index]!.id
                                  .toString(),
                            )));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xffffffff)
                                  : Colors.black,
                          //const Color(0xffffffff),
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
                        ),
                        margin: EdgeInsets.only(top: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${widget.search_result!.data![index]!.thumbnailImg}",
                                    placeholder: (context, url) => Container(
                                      color: Colors.blue,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            '${imageUrl}assets/img/placeholder.jpg'),
                                  ),
                                  padding: EdgeInsets.all(15),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${widget.search_result!.data![index]!.name}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).translate(),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${widget.search_result!.data![index]!.strokedPrice}',
                                    style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 8.sp,
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).translate(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              RatingBarIndicator(
                                rating: widget
                                    .search_result!.data![index]!.rating!
                                    .toDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.search_result!.data![index]!.hasDiscount ==
                                    false
                                ? false
                                : true,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 2.h,
                            width: 5.h,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Off'.tr,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 2.h,
                                  width: 2.5.h,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade700,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      '${widget.search_result!.data![index]!.discount!.replaceAll('-', '').trim()}',
                                      style: const TextStyle(
                                          fontSize: 8, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            childCount: widget.search_result!.data!.length,
          ),
        )
      ]),
    );
  }

  Widget search_gridS() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: CustomScrollView(slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.9),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (c) => ProductDetailPage(
                    //           userId: widget.search_result!.data![index]!.id
                    //               .toString(),
                    //         )));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xffffffff)
                                  : Colors.black,
                          //const Color(0xffffffff),
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
                        ),
                        margin: EdgeInsets.only(top: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "",
                                    placeholder: (context, url) => Container(
                                      color: Colors.blue,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            '${imageUrl}assets/img/placeholder.jpg'),
                                  ),
                                  padding: EdgeInsets.all(15),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 2.h,
                                width: 6.w,
                                color: Colors.black,

                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 2.h,
                                    width: 6.w,
                                    color: Colors.black,

                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
            childCount:20,
          ),
        )
      ]),
    );
  }
}
