import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../global_widgets/AppSize.dart';

class CashOnDelivery extends StatefulWidget {
  const CashOnDelivery({Key? key}) : super(key: key);

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
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
                  child: Text('Cash on Delivery'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: productController.cash_on_delivery,
                        onChanged: (v) {
                          productController.cash_on_delivery = v!;
                          productController.updateUI();
                        }),
                    Text('Cash on delivery'.tr,
                        style: TextStyle(fontFamily: AppFonts.segoeui)),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
