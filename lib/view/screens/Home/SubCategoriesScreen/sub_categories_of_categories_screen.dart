import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/home_sub_category/sub_categories_of_categories_model.dart';
import '../../../../utils_services/refresh_controller.dart';
import '../../../../view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_bloc.dart';
import '../../../../view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_events.dart';
import '../../../../view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_state.dart';
import '../../../../view_model/sub_categories_of_categories_bloc/sub_categories_of_categories_repository.dart';
import '../../../global_widgets/products_view_widget.dart';
import '../../Products/product_details.dart';

class subCategoriesOfCategoriesScreen extends StatefulWidget {
  String? CategoryId;
  String? cat_name;
  subCategoriesOfCategoriesScreen({Key? key, this.CategoryId, this.cat_name})
      : super(key: key);

  @override
  State<subCategoriesOfCategoriesScreen> createState() =>
      _subCategoriesOfCategoriesScreenState();
}

class _subCategoriesOfCategoriesScreenState
    extends State<subCategoriesOfCategoriesScreen>
    with categoriesOfSubCategories {
  @override
  void initState() {
    page = 1;
    categoriesOfCategoriesBloc.add(SubCategoriesOfCategoriesEvent(
        CategoryID: widget.CategoryId, page: page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.cat_name}' + 'Products'.tr,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white))
            .translate(),
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Color(0xffffffff)
            : Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.arrow_left,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white)),
      ),
      body: BlocConsumer<SubCategoriesOfCategoriesBloc,
          SubCategoriesOfCategoriesScreenState>(
        bloc: categoriesOfCategoriesBloc,
        listener: (context, state) {
          if (state is SubCategoriesOfCategoriesErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error).translate()));
          }
        },
        builder: (context, state) {
          if (state is SubCategoriesOfCategoriesLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else if (state is SubCategoriesOfCategoriesLoadedState) {
            return ScreenOfSubCategories(
                onLoad: () async {
                  SubCategoriesOfCategoriesModel responce =
                      await getCategoriesProduct(cat_id: widget.CategoryId);
                  state.res.data!.addAll(responce.data!);
                  setState(() {});
                  refreshController.loadComplete();
                },
                onRefresh: () async {
                  page = 1;
                  SubCategoriesOfCategoriesModel responce =
                      await getCategoriesProduct(cat_id: widget.CategoryId);
                  state.res.data = responce.data!;
                  setState(() {});
                  refreshController.refreshCompleted();
                },
                categoriesModel: state.res,
                context: context);
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

  Widget ScreenOfSubCategories(
      {SubCategoriesOfCategoriesModel? categoriesModel,
      Function()? onRefresh,
      Function()? onLoad,
      BuildContext? context}) {
    return RefreshControllerGlobal(
      controller: refreshController,
      onLoad: onLoad,
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 2.h,
            ),
          ),
          SliverGrid(
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
                                    userId: categoriesModel.data![index].id
                                        .toString(),
                                  )))
                          .then((value) {
                        if (value == 'delete') {
                          categoriesOfCategoriesBloc.add(
                              SubCategoriesOfCategoriesEvent(
                                  CategoryID: widget.CategoryId));
                        }
                      });
                    },
                    child: ProductView(
                      imageUrl:
                          '${categoriesModel.data![index].thumbnailImage}',
                      textName: '${categoriesModel.data![index].name}',
                      textPrice: '${categoriesModel.data![index].mainPrice}',
                      ratting: categoriesModel.data![index].rating!.toDouble(),
                      addBy: '${categoriesModel.data![index].addedBy}',
                      stockPrice:
                          '${categoriesModel.data![index].strokedPrice}',
                      priceHighLow:
                          '${categoriesModel.data![index].priceHighLow}',
                      visible: categoriesModel.data![index].hasDiscount == false
                          ? false
                          : true,
                      isActive: categoriesModel.data![index].published == 'Yes'
                          ? true
                          : false,
                      textDiscount:
                          '${categoriesModel.data![index].discount!.toString().replaceAll('-', '').trim()}',
                    ));
              },
              childCount: categoriesModel!.data!.length,
            ),
          )
        ],
      ),
    );
  }
}
