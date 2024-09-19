import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/app_font.dart';
import '../../../../global_widgets/AppSize.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Text('Product Images'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: AppFonts.segoeui)),
        ),
        SizedBox(height: 7, width: width),
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
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Product Description'.tr,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: AppFonts.segoeui),
                  ),
                ),
                SizedBox(height: 5),
                HtmlEditor(
                  controller: productController.htmlEditorController,
                  htmlEditorOptions: HtmlEditorOptions(
                      shouldEnsureVisible: true,
                      initialText: productController.html_initial_text,
                      hint: "Product Complete Description".tr),
                  htmlToolbarOptions:
                      const HtmlToolbarOptions(defaultToolbarButtons: [
                    // StyleButtons(),
                    // FontSettingButtons(fontSizeUnit: false),
                    FontButtons(clearAll: false),
                    ColorButtons(),
                    ListButtons(listStyles: false),
                    ParagraphButtons(
                        textDirection: false,
                        lineHeight: false,
                        caseConverter: false),
                    InsertButtons(
                        video: false,
                        audio: false,
                        table: false,
                        hr: false,
                        otherFile: false)
                  ]),
                  otherOptions: OtherOptions(
                    height: 250,
                  ),
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
