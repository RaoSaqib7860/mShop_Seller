import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';
import '../../../../global_widgets/AppSize.dart';

class LowStockQuantityWarning extends StatefulWidget {
  const LowStockQuantityWarning({Key? key}) : super(key: key);

  @override
  State<LowStockQuantityWarning> createState() =>
      _LowStockQuantityWarningState();
}

class _LowStockQuantityWarningState extends State<LowStockQuantityWarning> {
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
                  child: Text('Low Stock Quantity Warning'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: CustomTextFieldsDecorated(
                      controller: productController.low_stock_quantity_warning_controller,
                      labelText: '0',
                      title: 'Low Stock Quantity Warning'.tr,
                      maxline: 3,
                      textInputType: TextInputType.number,
                    ),
                  )
                ]),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
