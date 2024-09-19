import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';
import '../../../../global_widgets/AppSize.dart';

class ProductPriceStock extends StatefulWidget {
  const ProductPriceStock({Key? key}) : super(key: key);

  @override
  State<ProductPriceStock> createState() => _ProductPriceStockState();
}

class _ProductPriceStockState extends State<ProductPriceStock> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return ExpansionTile(
      title: Text('Product Price + Stock'.tr,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontFamily: AppFonts.segoeui)),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context!).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.unit_price_controller,
                      labelText: '0',
                      title: 'Unit Price'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.discount_controller,
                      labelText: '0',
                      title: 'Discount'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Discount Type'.tr,
                            style: TextStyle(
                                color: Theme.of(context!).brightness ==
                                        Brightness.dark
                                    ? Colors.grey
                                    : Colors.black,
                                fontFamily: AppFonts.segoeui),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
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
                              productController.list_discount_type.map((value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text('${value}'),
                            );
                          }).toList(),
                          hint: Text(
                                  '${productController.selected_discount_type}',
                                  style: TextStyle(fontSize: 12))
                              .translate(),
                          onChanged: (data) {
                            productController.selected_discount_type = data;
                            productController.updateUI();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.quantity_controller,
                      labelText: '0',
                      title: 'Quantity'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldsDecorated(
                      controller: productController.sku_controller,
                      labelText: '',
                      title: 'SKU'.tr,
                      maxline: 3,
                    ),
                    SizedBox(height: 10),
                    // CustomTextFieldsDecorated(
                    //   controller: productController.internal_link_controller,
                    //   labelText: 'http/',
                    //   title: 'Internal Link',
                    //   maxline: 3,
                    // ),
                    // SizedBox(height: 10),
                    // CustomTextFieldsDecorated(
                    //   controller:
                    //       productController.internal_link_button_text_controller,
                    //   labelText:
                    //       'Leave it blank if you do not use external site link',
                    //   title: 'Internal Link Button Text',
                    //   maxline: 3,
                    // ),
                    // SizedBox(height: 20),
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
