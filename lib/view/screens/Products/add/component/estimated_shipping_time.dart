import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../../utils_services/text_field_decorated.dart';
import '../../../../global_widgets/AppSize.dart';

class EstimatedShippingTime extends StatefulWidget {
  const EstimatedShippingTime({Key? key}) : super(key: key);

  @override
  State<EstimatedShippingTime> createState() => _EstimatedShippingTimeState();
}

class _EstimatedShippingTimeState extends State<EstimatedShippingTime> {
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
                  child: Text('Estimate Shipping Time'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFieldsDecorated(
                        controller:
                            productController.estimated_shiping_time_controller,
                        labelText: '0',
                        title: 'Estimate Shipping Time'.tr,
                        maxline: 3,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('In Days'.tr),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text('Warranty Period'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.segoeui)),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextFieldsDecorated(
                        controller: productController.warenty_controller,
                        labelText: '0',
                        title: 'Warranty'.tr,
                        maxline: 3,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: height * 0.060,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26, width: 0.7))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          items:
                              productController.list_warenty_type.map((value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text('${value}'),
                            );
                          }).toList(),
                          isExpanded: true,
                          hint: Text(
                                  '${productController.selected_warenty_type}',
                                  style: TextStyle(fontSize: 12))
                              .translate(),
                          onChanged: (data) {
                            productController.selected_warenty_type = data;
                            productController.updateUI();
                          },
                        ),
                      ),
                    ),
                  ],
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
