import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';
import '../../../../global_widgets/AppSize.dart';

class VatAndText extends StatefulWidget {
  const VatAndText({Key? key}) : super(key: key);

  @override
  State<VatAndText> createState() => _VatAndTextState();
}

class _VatAndTextState extends State<VatAndText> {
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
                SizedBox(height: 10,width: width),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text('5% VAT is included'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
