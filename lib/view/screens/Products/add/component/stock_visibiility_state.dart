import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../global_widgets/AppSize.dart';

class StockVisibilityState extends StatefulWidget {
  const StockVisibilityState({Key? key}) : super(key: key);

  @override
  State<StockVisibilityState> createState() =>
      _StockVisibilityStateState();
}

class _StockVisibilityStateState extends State<StockVisibilityState> {
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
                  child: Text('Stock Visibility State'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: productController.low_stock_warning ==
                            'Show Stock Quantity'.tr,
                        onChanged: (v) {
                          productController.low_stock_warning =
                          'Show Stock Quantity'.tr;
                          productController.updateUI();
                        }),
                    Text('Show Stock Quantity'.tr,
                        style: TextStyle(fontFamily: AppFonts.segoeui)),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: productController.low_stock_warning ==
                            'Show Stock With Text Only'.tr,
                        onChanged: (v) {
                          productController.low_stock_warning =
                          'Show Stock With Text Only'.tr;
                          productController.updateUI();
                        }),
                    Text('Show Stock With Text Only'.tr,
                        style: TextStyle(fontFamily: AppFonts.segoeui)),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: productController.low_stock_warning ==
                            'Hide Stock'.tr,
                        onChanged: (v) {
                          productController.low_stock_warning =
                          'Hide Stock'.tr;
                          productController.updateUI();
                        }),
                    Text('Hide Stock'.tr,
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
