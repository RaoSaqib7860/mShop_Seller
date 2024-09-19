import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/view/screens/Products/add/add_product.dart';

import '../../../../api_repo/basepath.dart';
import '../../../../extentions/app_colors.dart';
import '../../../../model/home/home_screen_model.dart';
import '../../../../model/product/top_seller/top_seller_model.dart';
import '../../../../utils_services/Loader.dart';
import '../../../../utils_services/colors_util.dart';
import '../../../../utils_services/refresh_controller.dart';
import '../../../../view_model/home_screen_blocs/home_screen_bloc.dart';
import '../../../../view_model/home_screen_blocs/home_screen_event.dart';
import '../../../../view_model/home_screen_blocs/home_screen_repository.dart';
import '../../../../view_model/home_screen_blocs/home_screen_state.dart';
import '../../../conectivity/connectivity.dart';
import '../../../global_widgets/app_font.dart';
import '../../Products/product_details.dart';
import '../SubCategoriesScreen/sub_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with HomeScreenRepository, TickerProviderStateMixin {
  HomeScreenBloc homeScreenBloc = HomeScreenBloc(HomesScreenInitialState());
  var refreshController = RefreshController(initialRefresh: false);
  StreamSubscription? subscription;
  @override
  void initState() {
    debounce(searchText, (value) async {
      print('Search value is =$value');
      if (value.toString().isEmpty) {
        search_result = null;
        setState(() {});
      } else {
        await get_search_data(value);
        setState(() {});
      }
    }, time: Duration(milliseconds: 300));
    homeScreenBloc.add(HomeModelsHome());
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            debounce(searchText, (value) async {
              print('Search value is =$value');
              if (value.toString().isEmpty) {
                search_result = null;
                setState(() {});
              } else {
                await get_search_data(value);
                setState(() {});
              }
            }, time: Duration(milliseconds: 300));
            homeScreenBloc.add(HomeModelsHome());
          } else {
            print('stop api');
          }
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.blueGrey.shade50
                            : AppColors.blackColor,
                        boxShadow: [
                          BoxShadow(
                              color: blueGrey.withOpacity(0.1),
                              offset: Offset(3, 3),
                              blurRadius: 1,
                              spreadRadius: 1),
                          BoxShadow(
                              color: blueGrey.withOpacity(0.1),
                              offset: Offset(-1, -1))
                        ],
                      ),
                      child: TextField(
                        controller: search_controller,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (search_result != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubCategoriesScreen(
                                    Id: '',
                                    CategoryId: '',
                                    name: '${searchText.value}',
                                    search_result: search_result,
                                  ),
                                ));
                          }
                        },
                        onChanged: (v) {
                          searchText.value = v;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            size: 5.w,
                          ),
                          hintText: 'Search for product'.tr,
                          hintStyle: TextStyle(
                            fontSize: 11.sp,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.textColor
                                    : AppColors.textColor,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 7),
                          border: InputBorder.none,
                          //fillColor:  Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () {
                        if (searchText.value.isEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProduct(),
                              ));
                        } else {
                          search_controller.clear();
                          searchText.value = '';
                        }
                      },
                      icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              RotationTransition(
                                turns: child.key == ValueKey('icon1')
                                    ? Tween<double>(begin: 1, end: 0.75)
                                        .animate(anim)
                                    : Tween<double>(begin: 0.75, end: 1)
                                        .animate(anim),
                                child:
                                    FadeTransition(opacity: anim, child: child),
                              ),
                          child: searchText.value.isNotEmpty
                              ? Icon(Icons.cancel,
                                  color: Colors.black,
                                  key: const ValueKey('icon1'))
                              : Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 5.w,
                                  // color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor,
                                  key: const ValueKey('icon2'),
                                )),
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<HomeScreenBloc, HomesState>(
              bloc: homeScreenBloc,
              listener: (context, state) {
                if (state is HomesScreenErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error).translate()));
                }
              },
              builder: (context, state) {
                if (state is HomesScreenLoadingState) {
                  return Center(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: uiHomeS( )));
                } else if (state is HomesScreenLoadedState) {
                  return uiHome(
                      context, state.response, state.bestSellingProduct);
                } else {
                  return Text('data'.tr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
    search_controller.dispose();
  }

  Widget uiHome(BuildContext context, HomeScreenModel homeScreenModels,
      TopBestSellingProduct topBestSellingProduct) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: RefreshControllerGlobal(
        controller: refreshController,
        onLoad: () {
          refreshController.loadComplete();
        },
        onRefresh: () async {
          homeScreenBloc.add(HomeModelsHome());
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            Obx(
              () => searchText.value.isEmpty
                  ? SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return FlipInX(
                              duration: Duration(seconds: 2),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubCategoriesScreen(
                                          Id: '${homeScreenModels.data![index].id}',
                                          CategoryId:
                                              '${homeScreenModels.data![index].id}',
                                          name:
                                              '${homeScreenModels.data![index].name}',
                                        ),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5),
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
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : AppColors.blackColor,
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: ElasticIn(
                                        child: Container(
                                          child: homeScreenModels
                                                      .data![index].id ==
                                                  -1
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Image.asset(
                                                      '${homeScreenModels.data![index].icon}'),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      "${homeScreenModels.data![index].icon}",
                                                  placeholder: (context, url) =>
                                                      Container(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.network(
                                                          '${imageUrl}assets/img/placeholder.jpg'),
                                                ),
                                          padding: EdgeInsets.all(12),
                                        ),
                                        delay: Duration(seconds: 1),
                                        duration: Duration(seconds: 4),
                                      )),
                                      Text('${homeScreenModels.data![index].name}',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: AppFonts.segoeui))
                                          .translate(),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: homeScreenModels.data!.length,
                        ),
                      ),
                    )
                  : search_result == null
                      ? SliverToBoxAdapter()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (c) => ProductDetailPage(
                                                userId: search_result!
                                                    .data![index]!.id
                                                    .toString(),
                                              )))
                                      .then((value) {
                                    if (value == 'delete') {
                                      homeScreenBloc.add(HomeModelsHome());
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      '${imageUrl}assets/img/placeholder.jpg'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                                    '${search_result!.data![index]!.name}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.segoeui))
                                                .translate(),
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
                        ),
            ),
          ],
        ),
      ),
    );
  }


  Widget uiHomeS() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: CustomScrollView(
        slivers: [
          Obx(
            () => searchText.value.isEmpty
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return FlipInX(
                            duration: Duration(seconds: 2),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           SubCategoriesScreen(
                                //         Id: '${homeScreenModels.data![index].id}',
                                //         CategoryId:
                                //             '${homeScreenModels.data![index].id}',
                                //         name:
                                //             '${homeScreenModels.data![index].name}',
                                //       ),
                                //     ));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 5),
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
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : AppColors.blackColor,
                                    borderRadius: BorderRadius.circular(9)),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ElasticIn(
                                      child: Container(
                                        child: CachedNetworkImage(
                                                imageUrl:
                                                    "",
                                                placeholder: (context, url) =>
                                                    Container(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.network(
                                                        '${imageUrl}assets/img/placeholder.jpg'),
                                              ),
                                        padding: EdgeInsets.all(12),
                                      ),
                                      delay: Duration(seconds: 1),
                                      duration: Duration(seconds: 4),
                                    )),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        height: 2.h,
                                        width: 6.w,
                                        color: Colors.grey.shade500,

                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                  )
                : search_result == null
                    ? SliverToBoxAdapter()
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (c) => ProductDetailPage(
                                              userId: search_result!
                                                  .data![index]!.id
                                                  .toString(),
                                            )))
                                    .then((value) {
                                  if (value == 'delete') {
                                    homeScreenBloc.add(HomeModelsHome());
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
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
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(
                                                    '${imageUrl}assets/img/placeholder.jpg'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                                  '${search_result!.data![index]!.name}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.segoeui))
                                              .translate(),
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
                      ),
          ),
        ],
      ),
    );
  }
}
