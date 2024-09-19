import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/colors_util.dart';

class AddProductButton extends StatefulWidget {
  const AddProductButton({Key? key}) : super(key: key);

  @override
  State<AddProductButton> createState() => _AddProductButtonState();
}

class _AddProductButtonState extends State<AddProductButton> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return Column(
      children: [
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            productController.addProduct(context);
          },
          child: Container(
            width: width,
            height: height * 0.060,
            child: Center(
              child: Text(
                'Add +'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppFonts.segoeui,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                color: blueGrey, borderRadius: BorderRadius.circular(7)),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
