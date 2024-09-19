import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/text_field_decorated.dart';
import '../../../../global_widgets/drop_down_2_custom.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({Key? key}) : super(key: key);

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return ExpansionTile(
      title: Text('Product Information'.tr,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontFamily: AppFonts.segoeui)),
      backgroundColor: Colors.transparent,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Card(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.name_controller,
                      labelText: 'Product Name'.tr,
                      title: 'Name'.tr,
                      maxline: 3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        if (productController.loadCat)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.7))),
                              child: Builder(builder: (context) {
                                List<String>? items = [];
                                productController.productCategories.data!
                                    .forEach((element) {
                                  items.add(element.name!);
                                });
                                return CustomDropDown2(
                                  initial_value:
                                      productController.selected_Cat == null
                                          ? ''
                                          : productController
                                                  .selected_Cat!.name ??
                                              '',
                                  list_items: items,
                                  selected_index: (selected_index) async {
                                    productController.load_sub_cat = false;
                                    productController.updateUI();
                                    productController.selected_Cat = null;
                                    productController.selected_Cat =
                                        productController.productCategories
                                            .data![selected_index];
                                    if (productController.selected_Cat!
                                        .subCategory!.isNotEmpty) {
                                      productController.selected_child_Cat =
                                          null;
                                    }
                                    productController.select_cat = true;
                                    productController.getProductAttr(
                                        productController.selected_Cat!.id
                                            .toString());
                                    productController.getBrandsCategoryByID(
                                        productController.selected_Cat!.id
                                            .toString());
                                    Future.delayed(Duration(milliseconds: 300),
                                        () {
                                      productController.load_sub_cat = true;
                                      productController.updateUI();
                                    });
                                  },
                                  hint: 'Select Category',
                                );
                              }),
                            ),
                          ),
                        SizedBox(width: 5),
                        if (productController.select_cat &&
                            productController
                                .selected_Cat!.subCategory!.isNotEmpty &&
                            productController.load_sub_cat)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.7))),
                              child: Builder(builder: (context) {
                                List<String>? items = [];
                                productController.selected_Cat!.subCategory!
                                    .forEach((element) {
                                  items.add(element.name!);
                                });
                                print(
                                    '${productController.selected_Cat!.subCategory!.length}');
                                return CustomDropDown2(
                                  initial_value: productController
                                              .selected_child_Cat ==
                                          null
                                      ? ''
                                      : '${productController.selected_child_Cat!.name}',
                                  list_items: items,
                                  selected_index: (selected_index) {
                                    productController.selected_child_Cat = null;
                                    productController.updateUI();
                                    productController.selected_child_Cat =
                                        productController.selected_Cat!
                                            .subCategory![selected_index];
                                    productController.getProductAttr(
                                        productController.selected_child_Cat!.id
                                            .toString());
                                    productController.getBrandsCategoryByID(
                                        productController.selected_child_Cat!.id
                                            .toString());
                                    productController.updateUI();
                                  },
                                  hint: 'Sub Category',
                                );
                              }),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26, width: 0.7))),
                      child: Builder(builder: (context) {
                        List<String>? items = [];
                        if (productController.brandsCategories != null) {
                          productController.brandsCategories!.data!
                              .forEach((element) {
                            items.add(element.name!);
                          });
                        }
                        return CustomDropDown2(
                          initial_value:
                              productController.selected_brand == null
                                  ? ''.tr
                                  : '${productController.selected_brand!.name}',
                          list_items: items,
                          selected_index: (selected_index) {
                            productController.selected_brand = productController
                                .brandsCategories!.data![selected_index];
                            productController.updateUI();
                          },
                          hint: 'Select Brand',
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    if (productController.constructionStages != null)
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26, width: 0.7))),
                        child: Builder(builder: (context) {
                          List<String>? items = [];
                          productController.constructionStages!.data!
                              .forEach((element) {
                            items.add(element.label!);
                          });
                          return CustomDropDown2(
                            initial_value: productController
                                        .selected_construction_stages ==
                                    null
                                ? ''.tr
                                : '${productController.selected_construction_stages!.label}',
                            list_items: items,
                            selected_index: (selected_index) {
                              productController.selected_construction_stages =
                                  productController.constructionStages!
                                      .data![selected_index];
                              if (!productController
                                  .list_of_selected_construction_stages
                                  .contains(productController
                                      .selected_construction_stages)) {
                                productController
                                    .list_of_selected_construction_stages
                                    .add(productController
                                        .selected_construction_stages!);
                              }
                              productController.updateUI();
                            },
                            hint: 'Construction Stages',
                          );
                        }),
                      ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 3.0,
                            children: productController
                                .list_of_selected_construction_stages
                                .map((e) {
                              int index = productController
                                  .list_of_selected_construction_stages
                                  .indexOf(e);
                              return Chip(
                                label: Text(
                                  '${e.label}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                onDeleted: () {
                                  productController
                                      .list_of_selected_construction_stages
                                      .removeAt(index);
                                  productController.updateUI();
                                },
                              );
                            }).toList()),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.unit_controller,
                      labelText: 'Unit (e.g. KG,PC etc)'.tr,
                      title: 'Unit'.tr,
                      maxline: 3,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.weight_controller,
                      labelText: '0.00',
                      title: 'Weight (In KG)'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.minimum_purchase_controller,
                      labelText: '0',
                      title: 'Minimum Purchase Quantity'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CustomTextFieldsDecorated(
                              controller: productController.tag_controller,
                              labelText: 'Type and click on add button'.tr,
                              maxline: 1,
                              title:
                                  'Tags ( These tags help you in search result )'
                                      .tr,
                            ),
                          ),
                          Center(
                              child: IconButton(
                                  onPressed: () async {
                                    if (productController.tag_controller.text
                                        .trim()
                                        .isNotEmpty) {
                                      productController.listofTags.add(
                                          productController.tag_controller.text
                                              .trim());
                                    }
                                    productController.tag_controller.clear();
                                    productController.updateUI();
                                  },
                                  icon: Icon(Icons.add_circle))),
                        ],
                      ),
                    ),
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 3.0,
                        children: productController.listofTags.map((e) {
                          int index = productController.listofTags.indexOf(e);
                          return Chip(
                            label: Text(
                              '$e',
                              style: TextStyle(fontSize: 12),
                            ).translate(),
                            onDeleted: () {
                              productController.listofTags.removeAt(index);
                              productController.updateUI();
                            },
                          );
                        }).toList()),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
