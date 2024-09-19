import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';

import '../../../api_repo/basepath.dart';
import '../../../model/wishlist_models/add_wishlist_view_model/add_wishlist_view.dart';
import '../../../view_model/wishlist_bloc/wishlist_views_bloc/wishlist_view_bloc.dart';
import '../../../view_model/wishlist_bloc/wishlist_views_bloc/wishlist_views_event.dart';
import '../../../view_model/wishlist_bloc/wishlist_views_bloc/wishlist_views_state.dart';
import '../../global_widgets/app_font.dart';

class WishlistViewScreen extends StatefulWidget {
  const WishlistViewScreen({Key? key}) : super(key: key);

  @override
  State<WishlistViewScreen> createState() => _WishlistViewScreenState();
}

class _WishlistViewScreenState extends State<WishlistViewScreen> {
  WishlistViewBloc wishlistViewBloc =
      WishlistViewBloc(WishlistViewInitialState());

  @override
  void initState() {
    wishlistViewBloc.add(WishlistViewEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WishlistViewBloc, WishlistViewStates>(
        bloc: wishlistViewBloc,
        listener: (context, state) {
          if (state is WishlistViewErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is WishlistViewLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else if (state is WishlistViewLoadedState) {
            return wishListScreen(context: context, viewModel: state.response);
          } else {
            return Text('data'.tr);
          }
        },
      ),
    );
  }

  Widget wishListScreen(
      {required BuildContext context,
      required AddWishlistViewModel viewModel}) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              ListTile(
                title: Text('Wishlist'.tr,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 0,
              childAspectRatio: 0.9),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(0.5),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () async {
                              wishlistViewBloc.add(WishlistViewEvent(
                                  productIdRemove: viewModel
                                      .data![index].product!.id
                                      .toString()));
                            },
                            child:
                                Icon(CupertinoIcons.delete, color: Colors.red)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 10.h,
                                padding: EdgeInsets.only(left: 16),
                                child:
                                    //Image.network('${getAllProductOfCategoriess.data![index].thumbnailImage}'),
                                    CachedNetworkImage(
                                  imageUrl:
                                      "${viewModel.data![index].product!.thumbnailImage}",
                                  placeholder: (context, url) => Container(
                                    color: Colors.blue,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          '${imageUrl}assets/img/placeholder.jpg'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${viewModel.data![index].product!.name}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppFonts.segoeui,
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ).translate(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${viewModel.data![index].product!.basePrice}',
                                  // widget.products!.data![index].minMaxPrice!.specialPrice != 0
                                  //     ? 'AED ${widget.products!.data![index].minMaxPrice!.specialPrice}'
                                  //     : 'AED ${widget.products!.data![index].minMaxPrice!.maxPrice}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.segoeui,
                                    fontSize: 9,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ).translate(),
                                SizedBox(
                                  width: 5,
                                ),
                                // Visibility(
                                //   visible: widget.products!.data![index].minMaxPrice!.specialPrice != 0,
                                //   child: Text(
                                //     '${widget.products!.data![index].minMaxPrice!.maxPrice}',
                                //     style: TextStyle(
                                //       decoration: TextDecoration.lineThrough,
                                //       fontFamily: AppFonts.segoeui,
                                //       fontSize: 9,
                                //       color: Colors.black.withOpacity(0.2),
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            RatingBarIndicator(
                              rating: viewModel.data![index].product!.rating!
                                  .toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 14.0,
                              direction: Axis.horizontal,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: viewModel.data!.length,
          ),
        )
      ],
    );
  }
}
