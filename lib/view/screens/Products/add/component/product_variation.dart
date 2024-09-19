import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:trotter/trotter.dart';
import 'package:mShop_Seller/model/add_product/attribute.dart' as attr;
import 'package:mShop_Seller/model/add_product/colors_class.dart' as color;
import 'package:mShop_Seller/model/add_product/selected_attribute_and_their_value.dart';
import 'package:mShop_Seller/model/media/product_media.dart' as mediaModel;
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../../../api_repo/basepath.dart';
import '../../../../../extentions/colors_convertor.dart';
import '../../../../../model/add_product/attribute_value_variations.dart';
import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/ShimmerEffect.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';

class ProductVariation extends StatefulWidget {
  const ProductVariation({Key? key}) : super(key: key);

  @override
  State<ProductVariation> createState() => _ProductVariationState();
}

class _ProductVariationState extends State<ProductVariation> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    if (!productController.has_attribute) {
      return SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Row(
              children: [
                Text('Product Variation + Attribute'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.segoeui)),
                // Visibility(
                //   visible:
                //       productController.list_of_attribute_variations.length > 1,
                //   child: Row(
                //     children: [
                //       SizedBox(width: 3),
                //       Text('Variation'),
                //       Checkbox(
                //           value: productController.has_variation,
                //           onChanged: (v) {
                //             productController.has_variation =
                //                 !productController.has_variation;
                //             productController.updateUI();
                //           },
                //           visualDensity: VisualDensity.adaptivePlatformDensity),
                //     ],
                //   ),
                // )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          SizedBox(height: 7),
          if (productController.colors.data != null)
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Select Your Attribute'.tr,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: AppFonts.segoeui),
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26, width: 0.7))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          items:
                              productController.attribute!.data!.map((value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text('${value.name}').translate(),
                            );
                          }).toList(),
                          hint: Text(
                                  productController.selected_attr == null
                                      ? 'Attribute'.tr
                                      : '${productController.selected_attr!.name}',
                                  style: TextStyle(fontSize: 12))
                              .translate(),
                          onChanged: (data) {
                            attr.Data v = data;
                            productController.selected_attr = v;
                            productController.list_of_selected_attr.add(
                                SelectedAttributeAndTheirValues(
                                    list_selected_attr_values: [],
                                    selected_attr: v,
                                    variation: false));
                            productController.updateUI();
                          },
                        ),
                      ),
                    ),
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 3.0,
                        children:
                            productController.list_of_selected_attr.map((e) {
                          int index = productController.list_of_selected_attr
                              .indexOf(e);
                          return Chip(
                            label: Text(
                              '${e.selected_attr!.name}',
                              style: TextStyle(fontSize: 12),
                            ).translate(),
                            onDeleted: () {
                              productController.list_of_selected_attr
                                  .removeAt(index);
                              productController.updateUI();
                            },
                          );
                        }).toList()),
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Select Your Colors'.tr,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: AppFonts.segoeui),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 0.7))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                                items:
                                    productController.colors.data!.map((value) {
                                  return DropdownMenuItem<dynamic>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        Text('${value.name}').translate(),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 17,
                                          width: 17,
                                          decoration: BoxDecoration(
                                              color:
                                                  HexColor.fromHex(value.code!),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                        productController.selected_colors ==
                                                null
                                            ? 'Color'.tr
                                            : '${productController.selected_colors!.name}',
                                        style: TextStyle(fontSize: 12))
                                    .translate(),
                                onChanged: (data) {
                                  color.Data v = data;
                                  productController.selected_colors = v;
                                  productController.list_of_selected_colors
                                      .add(v);
                                  productController.list_of_attribute_variations
                                      .add(AttributeValuesVariations(
                                          name: '${v.name}',
                                          photos:
                                              productController
                                                          .thumbnailImage ==
                                                      null
                                                  ? []
                                                  : [
                                                      productController
                                                          .thumbnailImage!.id
                                                          .toString()
                                                    ],
                                          quantity:
                                              productController.quantity_controller
                                                  .text,
                                          price: productController
                                              .unit_price_controller.text,
                                          sku: productController
                                              .sku_controller.text));
                                  check_for_variation(
                                      productController: productController,
                                      context: context);
                                  productController.updateUI();
                                },
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(width: 3),
                        //     Text('Variation'),
                        //     Checkbox(
                        //         value: productController.color_variation,
                        //         onChanged: (v) {
                        //           productController.color_variation =
                        //               !productController.color_variation;
                        //         },
                        //         visualDensity:
                        //             VisualDensity.adaptivePlatformDensity),
                        //   ],
                        // )
                      ],
                    ),
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 3.0,
                        children:
                            productController.list_of_selected_colors.map((e) {
                          int index = productController.list_of_selected_colors
                              .indexOf(e);
                          return Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${e.name}',
                                  style: TextStyle(fontSize: 12),
                                ).translate(),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex(e.code!),
                                      borderRadius: BorderRadius.circular(5)),
                                )
                              ],
                            ),
                            onDeleted: () {
                              productController.list_of_selected_colors
                                  .removeAt(index);
                              productController.list_of_attribute_variations
                                  .removeWhere(
                                      (element) => element.name == e.name);
                              productController.updateUI();
                            },
                          );
                        }).toList()),
                    SizedBox(height: 12),
                    Visibility(
                      visible:
                          productController.list_of_selected_attr.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text('Attribute Values'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.segoeui)),
                      ),
                    ),
                    ...productController.list_of_selected_attr.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 7),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(
                              '${e.selected_attr!.name}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontFamily: AppFonts.segoeui),
                            ).translate(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: width,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26,
                                              width: 0.7))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<dynamic>(
                                      items:
                                          e.selected_attr!.values!.map((value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text('${value.value}'),
                                        );
                                      }).toList(),
                                      hint: Text(
                                              e.list_selected_attr_values!
                                                      .isEmpty
                                                  ? 'select'.tr +
                                                      ' ${e.selected_attr!.name}'
                                                  : '${e.selected_attr_value!.value}',
                                              style: TextStyle(fontSize: 12))
                                          .translate(),
                                      onChanged: (data) {
                                        attr.Values v = data;
                                        e.selected_attr_value = v;
                                        e.list_selected_attr_values!.add(v);
                                        productController.list_of_attribute_variations
                                            .add(AttributeValuesVariations(
                                                name: '${v.value}',
                                                photos:
                                                    productController
                                                                .thumbnailImage ==
                                                            null
                                                        ? []
                                                        : [
                                                            productController
                                                                .thumbnailImage!
                                                                .id
                                                                .toString()
                                                          ],
                                                quantity:
                                                    productController
                                                        .quantity_controller.text,
                                                price: productController
                                                    .unit_price_controller.text,
                                                sku: productController
                                                    .sku_controller.text));
                                        check_for_variation(
                                            productController:
                                                productController,
                                            context: context);
                                        productController.updateUI();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     SizedBox(width: 3),
                              //     Text('Variation'),
                              //     Checkbox(
                              //         value: e.variation,
                              //         onChanged: (v) {
                              //           e.variation = v;
                              //           setState(() {});
                              //         },
                              //         visualDensity:
                              //             VisualDensity.adaptivePlatformDensity),
                              //   ],
                              // )
                            ],
                          ),
                          Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 3.0,
                              children:
                                  e.list_selected_attr_values!.map((value) {
                                int index =
                                    e.list_selected_attr_values!.indexOf(value);
                                return Chip(
                                  label: Text(
                                    '${value.value}',
                                    style: TextStyle(fontSize: 12),
                                  ).translate(),
                                  onDeleted: () {
                                    e.list_selected_attr_values!
                                        .removeAt(index);
                                    productController
                                        .list_of_attribute_variations
                                        .removeWhere((element) =>
                                            element.name == value.value);
                                    productController.updateUI();
                                  },
                                );
                              }).toList()),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 12),
                    Visibility(
                      visible: productController
                          .list_of_attribute_variations.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text('Variation Pricing'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.segoeui)),
                      ),
                    ),
                    SizedBox(height: 12),
                    if (productController.has_variation)
                      ...productController
                          .list_of_attribute_variations_combination
                          .map((e) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ExpansionTile(
                                    title: Text('${e.name}').translate(),
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      CustomTextFieldsDecorated(
                                                    labelText: 'Price'.tr,
                                                    title: '',
                                                    maxline: 1,
                                                    textInputType:
                                                        TextInputType.number,
                                                    initial_text: e.price ?? '',
                                                    show_title: false,
                                                    onchange: (v) {
                                                      e.price = v;
                                                      productController
                                                          .updateUI();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      CustomTextFieldsDecorated(
                                                    labelText: 'SKU'.tr,
                                                    maxline: 1,
                                                    textInputType:
                                                        TextInputType.text,
                                                    initial_text: e.sku ?? '',
                                                    title: '',
                                                    onchange: (v) {
                                                      e.sku = v;
                                                      productController
                                                          .updateUI();
                                                    },
                                                    show_title: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            CustomTextFieldsDecorated(
                                              labelText: 'Quantity'.tr,
                                              maxline: 1,
                                              textInputType:
                                                  TextInputType.number,
                                              initial_text: e.quantity ?? '',
                                              title: '',
                                              onchange: (v) {
                                                e.quantity = v;
                                                productController.updateUI();
                                              },
                                              show_title: false,
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text('Select Images'.tr),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0)),
                                                            insetPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15),
                                                            child: StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                height: height -
                                                                    100,
                                                                width: width,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child:
                                                                                SizedBox()),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Add Product'.tr,
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              InkWell(
                                                                                child: Text('Done'.tr, style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Text(
                                                                            'Image'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        Text(
                                                                            'name'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        Text(
                                                                            'Size'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Expanded(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: productController
                                                                            .productMedia
                                                                            .data!
                                                                            .map((value) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Checkbox(
                                                                                    value: e.photos!.contains(value.id.toString()),
                                                                                    onChanged: (v) {
                                                                                      if (v!) {
                                                                                        e.photos = [
                                                                                          value.id.toString()
                                                                                        ];
                                                                                      } else {
                                                                                        e.photos!.remove(e.toString());
                                                                                      }
                                                                                      setState(() {});
                                                                                    }),
                                                                                SizedBox(
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: "${imageUrl}${value.fileName}",
                                                                                    placeholder: (context, url) => ShimerEffect(
                                                                                      child: Container(
                                                                                        color: Colors.blue,
                                                                                      ),
                                                                                    ),
                                                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                  ),
                                                                                  height: 100,
                                                                                  width: 90,
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Expanded(
                                                                                  child: SizedBox(child: Text('${value.fileName}', style: TextStyle(fontSize: 12)).translate(), width: 150),
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Text('${value.fileSize}', style: TextStyle(fontSize: 12)),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    ))
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        }).then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      color: Colors.blue,
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    await productController
                                                        .getOtherFilesImage();
                                                    productController
                                                        .updateUI();
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.image,
                                                      color: Colors.blue,
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            e.photos!.isEmpty
                                                ? SizedBox()
                                                : SizedBox(
                                                    width: width,
                                                    child: Wrap(
                                                        alignment:
                                                            WrapAlignment.start,
                                                        spacing: 2.0,
                                                        children:
                                                            e.photos!.map((e3) {
                                                          return Stack(
                                                            children: [
                                                              ClipRRect(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.080,
                                                                  width: width *
                                                                      0.180,
                                                                  child: Builder(
                                                                      builder:
                                                                          (context) {
                                                                    mediaModel.Data data = productController
                                                                        .productMedia
                                                                        .data!
                                                                        .firstWhere((element) =>
                                                                            element.id.toString() ==
                                                                            e3);
                                                                    return Image.network(
                                                                        '${imageUrl}${data.fileName}',
                                                                        fit: BoxFit
                                                                            .cover);
                                                                  }),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .blueGrey[
                                                                          50],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              Positioned(
                                                                child: InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .cancel),
                                                                    onTap: () {
                                                                      e.photos!
                                                                          .remove(
                                                                              e3);
                                                                      productController
                                                                          .updateUI();
                                                                    }),
                                                                right: 1,
                                                                top: 1,
                                                              )
                                                            ],
                                                          );
                                                        }).toList()),
                                                  ),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Icon(Icons.cancel,
                                        size: 20,
                                        color: Colors.red.withOpacity(0.7)),
                                  ),
                                  onTap: () {
                                    productController
                                        .list_of_attribute_variations_combination
                                        .remove(e);
                                    check_for_variation(
                                        productController: productController,
                                        context: context);
                                    setState(() {});
                                  },
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        );
                      }),
                    if (!productController.has_variation)
                      ...productController.list_of_attribute_variations
                          .map((e) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ExpansionTile(
                                    title: Text('${e.name}').translate(),
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      CustomTextFieldsDecorated(
                                                    labelText: 'Price'.tr,
                                                    title: '',
                                                    maxline: 1,
                                                    textInputType:
                                                        TextInputType.number,
                                                    initial_text: e.price ?? '',
                                                    show_title: false,
                                                    onchange: (v) {
                                                      e.price = v;
                                                      productController
                                                          .updateUI();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      CustomTextFieldsDecorated(
                                                    labelText: 'SKU'.tr,
                                                    maxline: 1,
                                                    textInputType:
                                                        TextInputType.text,
                                                    initial_text: e.sku ?? '',
                                                    title: '',
                                                    onchange: (v) {
                                                      e.sku = v;
                                                      productController
                                                          .updateUI();
                                                    },
                                                    show_title: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            CustomTextFieldsDecorated(
                                              labelText: 'Quantity'.tr,
                                              maxline: 1,
                                              textInputType:
                                                  TextInputType.number,
                                              initial_text: e.quantity ?? '',
                                              title: '',
                                              onchange: (v) {
                                                e.quantity = v;
                                                productController.updateUI();
                                              },
                                              show_title: false,
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text('Select Images'.tr),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0)),
                                                            insetPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15),
                                                            child: StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                height: height -
                                                                    100,
                                                                width: width,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child:
                                                                                SizedBox()),
                                                                        Expanded(
                                                                          child: Text(
                                                                              'Add Product'.tr,
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              InkWell(
                                                                                child: Text('Done'.tr, style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)),
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Text(
                                                                            'Image'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        Text(
                                                                            'name'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                        Text(
                                                                            'Size'
                                                                                .tr,
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Expanded(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: productController
                                                                            .productMedia
                                                                            .data!
                                                                            .map((value) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Checkbox(
                                                                                    value: e.photos!.contains(value.id.toString()),
                                                                                    onChanged: (v) {
                                                                                      if (v!) {
                                                                                        e.photos = [
                                                                                          value.id.toString()
                                                                                        ];
                                                                                      } else {
                                                                                        e.photos!.remove(e.toString());
                                                                                      }
                                                                                      setState(() {});
                                                                                    }),
                                                                                SizedBox(
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: "${imageUrl}${value.fileName}",
                                                                                    placeholder: (context, url) => ShimerEffect(
                                                                                      child: Container(
                                                                                        color: Colors.blue,
                                                                                      ),
                                                                                    ),
                                                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                                                  ),
                                                                                  height: 100,
                                                                                  width: 90,
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Expanded(
                                                                                  child: SizedBox(child: Text('${value.fileName}', style: TextStyle(fontSize: 12)).translate(), width: 150),
                                                                                ),
                                                                                SizedBox(width: 5),
                                                                                Text('${value.fileSize}', style: TextStyle(fontSize: 12)).translate(),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                    ))
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        }).then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      color: Colors.blue,
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    await productController
                                                        .getOtherFilesImage();
                                                    productController
                                                        .updateUI();
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.image,
                                                      color: Colors.blue,
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            e.photos!.isEmpty
                                                ? SizedBox()
                                                : SizedBox(
                                                    width: width,
                                                    child: Wrap(
                                                        alignment:
                                                            WrapAlignment.start,
                                                        spacing: 2.0,
                                                        children:
                                                            e.photos!.map((e3) {
                                                          return Stack(
                                                            children: [
                                                              ClipRRect(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.080,
                                                                  width: width *
                                                                      0.180,
                                                                  child: Builder(
                                                                      builder:
                                                                          (context) {
                                                                    mediaModel.Data data = productController
                                                                        .productMedia
                                                                        .data!
                                                                        .firstWhere((element) =>
                                                                            element.id.toString() ==
                                                                            e3);
                                                                    return Image.network(
                                                                        '${imageUrl}${data.fileName}',
                                                                        fit: BoxFit
                                                                            .cover);
                                                                  }),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .blueGrey[
                                                                          50],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              Positioned(
                                                                child: InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .cancel),
                                                                    onTap: () {
                                                                      e.photos!
                                                                          .remove(
                                                                              e3);
                                                                      productController
                                                                          .updateUI();
                                                                    }),
                                                                right: 1,
                                                                top: 1,
                                                              )
                                                            ],
                                                          );
                                                        }).toList()),
                                                  ),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Icon(Icons.cancel,
                                        size: 20,
                                        color: Colors.red.withOpacity(0.7)),
                                  ),
                                  onTap: () {
                                    productController
                                        .list_of_attribute_variations
                                        .remove(e);
                                    setState(() {});
                                  },
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ),
        ],
      );
    }
  }

  check_for_variation(
      {required AddProductProvider productController,
      required BuildContext context}) {
    if (productController.list_of_selected_attr.length <= 1 &&
        productController.list_of_selected_colors.isEmpty) {
      productController.has_variation = false;
    } else {
      if (productController.list_of_attribute_variations.length > 1) {
        productController.list_of_attribute_variations_combination.clear();
        List<String> list_of_value = [];
        productController.list_of_attribute_variations.forEach((element) {
          list_of_value.add(element.name!);
        });
        List list_of_varaiton_value = [];
        final bagOfItems = list_of_value, combos = Combinations(2, bagOfItems);
        for (final combo in combos()) {
          print('${combo}');
          list_of_varaiton_value.add(combo.join('-'));
        }
        productController.list_of_selected_attr.forEach((element) {
          if (element.list_selected_attr_values!.length > 1) {
            List listOfName = [];
            List list_of_varaiton_value_ener = [];
            element.list_selected_attr_values!.forEach((e1) {
              listOfName.add(e1.value);
            });
            print('step 1');
            final bagOfItems_ener = listOfName,
                comboss = Combinations(2, bagOfItems_ener);
            print('step 2');
            for (final combo in comboss()) {
              list_of_varaiton_value_ener.add(combo.join('-'));
            }
            print('step 3');
            list_of_varaiton_value_ener.forEach((e2) {
              print('e2 = ${e2}');
              if (list_of_varaiton_value.contains(e2)) {
                list_of_varaiton_value.remove(e2);
              }
            });
          }
        });
        list_of_varaiton_value.forEach((element) {
          productController.list_of_attribute_variations_combination.add(
              AttributeValuesVariations(
                  name: element,
                  photos: productController.thumbnailImage == null
                      ? []
                      : [productController.thumbnailImage!.id.toString()],
                  sku: productController.sku_controller.text,
                  price: productController.unit_price_controller.text,
                  quantity: productController.quantity_controller.text));
        });
        productController.has_variation = true;
      }
    }
  }
}
