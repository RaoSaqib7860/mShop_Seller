import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';

class ShippingConfiguration extends StatefulWidget {
  const ShippingConfiguration({Key? key}) : super(key: key);

  @override
  State<ShippingConfiguration> createState() => _ShippingConfigurationState();
}

class _ShippingConfigurationState extends State<ShippingConfiguration> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Theme.of(context!).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text('Shipping Configuration'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: productController.shiping == 'Free Shipping'.tr,
                        onChanged: (v) {
                          productController.shiping = 'Free Shipping'.tr;
                          productController.updateUI();
                        }),
                    Text('Free Shipping'.tr,
                        style: TextStyle(fontFamily: AppFonts.segoeui)),
                    Checkbox(
                        value: productController.shiping == 'Flat Rate'.tr,
                        onChanged: (v) {
                          productController.shiping = 'Flat Rate'.tr;
                          productController.updateUI();
                        }),
                    Text('Flat Rate'.tr,
                        style: TextStyle(fontFamily: AppFonts.segoeui)),
                  ],
                ),
                if (productController.shiping != 'Free Shipping'.tr)
                  Column(children: [
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: CustomTextFieldsDecorated(
                          controller: productController
                              .shipping_cofigration_charges_controller,
                          labelText: '0',
                          title: 'Shipping charges'.tr,
                          maxline: 3,
                          textInputType: TextInputType.number,
                        ),
                      )
                    ]),
                  ]),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
