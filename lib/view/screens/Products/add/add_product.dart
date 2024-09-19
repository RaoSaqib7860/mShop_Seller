import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../model/home_sub_category/get_product_single_user_model.dart'
    as get_product_single_user_model;
import '../../../../providers/add_product_provider.dart';
import '../../../../utils_services/Loader.dart';
import '../../../../utils_services/app_font.dart';
import 'component/add_product_button.dart';
import 'component/cash_on_delivery.dart';
import 'component/estimated_shipping_time.dart';
import 'component/low_stock_quantity_warning.dart';
import 'component/product_description.dart';
import 'component/product_images.dart';
import 'component/product_information.dart';
import 'component/product_price_stock.dart';
import 'component/product_variation.dart';
import 'component/shipping_config.dart';
import 'component/stock_visibiility_state.dart';
import 'component/vat_and_tax.dart';

class AddProduct extends StatefulWidget {
  final model;
  final bool? isedit;
  const AddProduct({Key? key, this.model, this.isedit = false})
      : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late get_product_single_user_model.getProductSingleUserModel model;
  @override
  void initState() {
    var productController =
        Provider.of<AddProductProvider>(context, listen: false);
    if (widget.isedit!) {
      model = widget.model
          as get_product_single_user_model.getProductSingleUserModel;
      print('id is = ${model.brand!.name}');
      productController.name_controller.text = model.name!;
      productController.getCategories().then((value) {
        int index = productController.productCategories.data!
            .indexWhere((element) => element.name == model.category!.name!);
        if (!index.isNegative) {
          productController.selected_Cat =
              productController.productCategories.data![index];
        } else {
          productController.productCategories.data!.forEach((element) async {
            if (element.subCategory!.isNotEmpty) {
              int index = element.subCategory!.indexWhere(
                  (element) => element.name == model.category!.name!);
              if (!index.isNegative) {
                productController.selected_Cat = element;
                productController.selected_child_Cat =
                    element.subCategory![index];
                await productController.getProductAttr(
                    productController.selected_Cat!.id.toString());
                await productController.getBrandsCategory(
                    productController.selected_Cat!.id.toString());
                int brandIndex = productController.brandsCategories!.data!
                    .indexWhere((element) => element.name == model.brand!.name);
                if (!brandIndex.isNegative) {
                  print('has brand');
                  productController.selected_brand =
                      productController.brandsCategories!.data![brandIndex];
                }
              }
            }
          });
        }
        productController.select_cat = true;
        setState(() {});
      });
    }
    productController.getCategories();
    productController.getProductMedia();
    productController.getProductColors();
    productController.getConstructionStages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context!).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black),
          ),
          title: Text('Add Your Product'.tr,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                  fontFamily: AppFonts.segoeui,
                  fontWeight: FontWeight.w600)),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: SingleChildScrollView(
                child: Column(children: [
                  ProductInformation(),
                  ProductImages(),
                  ProductPriceStock(),
                  ProductVariation(),
                  ProductDescription(),
                  ShippingConfiguration(),
                  LowStockQuantityWarning(),
                  StockVisibilityState(),
                  CashOnDelivery(),
                  EstimatedShippingTime(),
                  VatAndText(),
                  AddProductButton()
                ]),
              ),
            ),
            productController.upload_data
                ? Center(
                    child: screenLoader(onTap: () {
                      productController.upload_data = false;
                      productController.updateUI();
                    }),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
