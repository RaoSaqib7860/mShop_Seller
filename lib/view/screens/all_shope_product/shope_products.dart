import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';
import '../../../model/soled_by_shop/single_shop_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/refresh_controller.dart';
import '../../../view_model/sold_by_shops/sold_by_shop_repository.dart';
import '../../../view_model/sold_by_shops/sold_by_shops_bloc.dart';
import '../../../view_model/sold_by_shops/sold_by_shops_events.dart';
import '../../../view_model/sold_by_shops/sold_by_shops_state.dart';
import '../../global_widgets/app_font.dart';
import '../../global_widgets/products_view_widget.dart';
import '../Products/product_details.dart';

class SingleShopProducts extends StatefulWidget {
  final String? shopId;
  final String? shopName;
  final bool? is_brand;
  final bool? is_stages;
  SingleShopProducts(
      {Key? key,
      this.shopId,
      this.shopName,
      this.is_brand = false,
      this.is_stages = false})
      : super(key: key);

  @override
  State<SingleShopProducts> createState() => _SingleShopProductsState();
}

class _SingleShopProductsState extends State<SingleShopProducts>
    with SoldByShopRepository {
  @override
  void initState() {
    shopProductBloc.add(ShopProductEvent(
        Id: widget.shopId,
        is_brand: widget.is_brand!,
        is_stages: widget.is_stages));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text('${widget.shopName} Products',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: AppFonts.segoeui,
                    fontWeight: FontWeight.bold))
            .translate(),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              if (style == 'grid') {
                print('clkds');
                if (count == '2') {
                  count = '3';
                  print('1');
                } else {
                  count = '2';
                  print('2');
                }
              } else {
                print('3');
                style = 'grid';
                setState(() {});
              }
              setState(() {});
            },
            child: SvgPicture.asset(
              'assets/svgs/c.svg',
              height: 2.h,
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          InkWell(
            onTap: () {
              if (style == 'grid') {
                style = 'list';
                setState(() {});
              } else {
                style = 'grid';
                setState(() {});
              }
            },
            child: SvgPicture.asset(
              'assets/svgs/d.svg',
              height: 2.0.h,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back, color: Colors.black)),
      ),
      body: BlocConsumer<ShopProductBloc, ShopProductStates>(
        bloc: shopProductBloc,
        listener: (context, state) {
          if (state is ShopProductErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is ShopProductLoadingState) {
            return Center(child: screenLoader(use_opacity: false));
          } else if (state is ShopProductLoadedState) {
            return ScreenOfShopProduct(state: state, context: context);
          } else {
            return Text('data').translate();
          }
        },
      ),
    );
  }

  Widget ScreenOfShopProduct(
      {required ShopProductLoadedState state,
      Function()? onRefresh,
      Function()? onLoad,
      required BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: RefreshControllerGlobal(
        controller: refreshController,
        onLoad: () async {
          GetAllProductsByShop data = await getLoadMoreData(widget.shopId);
          state.response.data!.addAll(data.data!);
          setState(() {});
          refreshController.loadComplete();
        },
        onRefresh: () async {
          page = 0;
          shopProductBloc.add(ShopProductEvent(
              Id: widget.shopId,
              is_brand: widget.is_brand,
              is_stages: widget.is_stages));
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            style == 'grid'
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: count == '2' ? 2 : 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 0.9),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => ProductDetailPage(
                                                userId: state
                                                    .response.data![index].id
                                                    .toString(),
                                              )));
                                },
                                child: ProductView(
                                  imageUrl:
                                      '${state.response.data![index].thumbnailImg}',
                                  textName:
                                      '${state.response.data![index].name}',
                                  textPrice:
                                      '${state.response.data![index].mainPrice}',
                                  ratting: state.response.data![index].rating!
                                      .toDouble(),
                                  visible:
                                      state.response.data![index].hasDiscount ==
                                              false
                                          ? false
                                          : true,
                                  textDiscount:
                                      '${state.response.data![index].discount!.toString().replaceAll('-', '').trim()}',
                                  isActive:
                                      state.response.data![index].published ==
                                              'Yes'
                                          ? true
                                          : false,
                                )),
                          );
                        },
                        childCount: state.response.data!.length,
                      ),
                    ),
                  )
                : list_view_product(state.response),
          ],
        ),
      ),
    );
  }

  Widget list_view_product(GetAllProductsByShop? shopProducts) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => ProductDetailPage(
                              userId: shopProducts.data![index].id.toString(),
                            )));
              },
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff),
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
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 60,
                      padding: EdgeInsets.only(left: 8),
                      child: CachedNetworkImage(
                        imageUrl: "${shopProducts.data![index].thumbnailImg}",
                        placeholder: (context, url) => Container(
                          color: Colors.blue,
                        ),
                        errorWidget: (context, url, error) => Image.network(
                            'https://staging.housy.ae/public/assets/img/placeholder.jpg'),
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
                            '${shopProducts.data![index].name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppFonts.segoeui,
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ).translate(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${shopProducts.data![index].mainPrice}',
                          style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ).translate(),
                        SizedBox(
                          height: 5,
                        ),
                        RatingBarIndicator(
                          rating: shopProducts.data![index].rating!.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        childCount: shopProducts!.data!.length,
      ),
    );
  }
}
