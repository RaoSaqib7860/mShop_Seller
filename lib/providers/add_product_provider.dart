import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mShop_Seller/model/add_product/Construction_stages.dart';
import 'package:mShop_Seller/model/add_product/Construction_stages.dart'
    as stages;
import 'package:mShop_Seller/model/add_product/attribute.dart';
import 'package:mShop_Seller/model/add_product/attribute.dart' as attr;
import 'package:mShop_Seller/model/add_product/attribute_value_variations.dart';

import '../api_repo/api_utils.dart';
import '../model/add_product/AddProductResponceModel.dart';
import '../model/add_product/brands.dart';
import '../model/add_product/brands.dart' as brand;
import '../model/add_product/colors_class.dart';
import '../model/add_product/colors_class.dart' as color;
import '../model/add_product/product_category.dart' as catModel;
import '../model/add_product/product_category.dart';
import '../model/add_product/selected_attribute_and_their_value.dart';
import '../model/media/product_media.dart';
import '../model/media/product_media.dart' as mediaModel;
import '../view/screens/Products/product_details.dart';

class AddProductProvider extends ChangeNotifier {
  /// all controller
  TextEditingController name_controller = TextEditingController();
  TextEditingController low_stock_quantity_warning_controller =
      TextEditingController();
  TextEditingController shipping_cofigration_charges_controller =
      TextEditingController();
  TextEditingController unit_controller = TextEditingController();
  TextEditingController unit_price_controller = TextEditingController();
  TextEditingController discount_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  TextEditingController minimum_purchase_controller = TextEditingController();
  TextEditingController quantity_controller = TextEditingController();
  TextEditingController estimated_shiping_time_controller =
      TextEditingController();
  TextEditingController tag_controller = TextEditingController();
  TextEditingController sku_controller = TextEditingController();
  TextEditingController total_stock_controller = TextEditingController();
  TextEditingController internal_link_controller = TextEditingController();
  TextEditingController internal_link_button_text_controller =
      TextEditingController();
  TextEditingController tex_controller = TextEditingController();
  TextEditingController tex_type_controller = TextEditingController();
  TextEditingController warenty_controller = TextEditingController();

  ProductMedia _productMedia = ProductMedia();
  ProductMedia get productMedia => _productMedia;
  List<mediaModel.Data> list_of_selected_media = [];
  mediaModel.Data? thumbnailImage;
  getProductMedia() async {
    _productMedia = await DataProvider.product_media_api();
  }

  bool color_variation = false;
  bool load_sub_cat = true;
  Colors _colors = Colors();
  Colors get colors => _colors;
  List<color.Data> list_of_selected_colors = [];
  color.Data? selected_colors;
  getProductColors() async {
    _colors = await DataProvider.product_color_api();
  }

  Attribute _attribute = Attribute();
  Attribute get attribute => _attribute;
  List<SelectedAttributeAndTheirValues> list_of_selected_attr = [];
  attr.Data? selected_attr;
  bool has_attribute = false;
  Future getProductAttr(String? id) async {
    _attribute = await DataProvider.product_attribute_api(id!);
    has_attribute = true;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? listOfOtherFiles = [];
  Future getOtherFilesImage() async {
    List<XFile>? files = await _picker.pickMultiImage();
    listOfOtherFiles!.addAll(files);
    files.forEach((element) async {
      dio.FormData data = dio.FormData.fromMap({
        'aiz_file': await dio.MultipartFile.fromFile(
          element.path,
          filename: '${element.name}',
        ),
      });
      await DataProvider.uploadMedia_api(uploadMedia: data);
    });
  }

  Future getThumbnailImages() async {
    XFile? thumbbnail_image;
    thumbbnail_image = await _picker.pickImage(source: ImageSource.gallery);
    dio.FormData data = dio.FormData.fromMap({
      'aiz_file': await dio.MultipartFile.fromFile(
        thumbbnail_image!.path,
        filename: '${thumbbnail_image.name}',
      ),
    });
    await DataProvider.uploadMedia_api(uploadMedia: data);
  }

  String selected_type_of_product = 'Simple Product';
  List type_of_product_list = ['Simple Product', 'Variable Product'];

  String selected_cancelable = 'Received';
  List list_of_cancelable = ['Received', 'Processed', 'Shipped'];

  String selected_stock_status = 'In Stock';
  List list_of_stock_status = ['In Stock', 'Out of Stock'];

  HtmlEditorController controller = HtmlEditorController();

  List _list_ofTags = [];
  List get listofTags => _list_ofTags;
  updateUI() {
    notifyListeners();
  }

  ///Brands by cat
  brand.Data? selected_brand;
  Brands? _brandsCategories;
  Brands? get brandsCategories => _brandsCategories;
  Future getBrandsCategoryByID(String id) async {
    _brandsCategories = await DataProvider.brandsCategoriesById_api(id);
    notifyListeners();
  }

  Future getBrandsCategory(String id) async {
    _brandsCategories = await DataProvider.brandsCategories_api();
    notifyListeners();
  }

  ///Construction Stages
  stages.Data? selected_construction_stages;
  List<stages.Data> list_of_selected_construction_stages = [];
  ConstructionStages? _constructionStages;
  ConstructionStages? get constructionStages => _constructionStages;
  getConstructionStages() async {
    _constructionStages = await DataProvider.costruction_stages_api();
    notifyListeners();
  }

  /// product categories
  catModel.Data? selected_Cat;
  catModel.SubCategory? selected_child_Cat;
  ProductCategories _productCategories = ProductCategories();
  ProductCategories get productCategories => _productCategories;
  bool loadCat = false;
  bool select_cat = false;
  Future getCategories() async {
    _productCategories = await DataProvider.productCategories_api();
    loadCat = true;
    notifyListeners();
  }

  ///html editor controller
  String html_initial_text = '';
  HtmlEditorController htmlEditorController = HtmlEditorController();

  /// ListOfAttributeVariations
  List<AttributeValuesVariations> list_of_attribute_variations = [];
  List<AttributeValuesVariations> list_of_attribute_variations_combination = [];

  String selected_discount_type = 'Flat';
  List list_discount_type = ['Flat', 'Percent'];
  String selected_warenty_type = 'Days';
  List list_warenty_type = ['Days', 'Months', 'Year'];
  String shiping = 'Free Shipping';
  String low_stock_warning = 'Show Stock Quantity';
  bool cash_on_delivery = false;
  bool has_variation = false;
  bool upload_data = false;

  addProduct(BuildContext context) async {
    print('step 1');
    List<String> selected_media_id = [];
    list_of_selected_media.forEach((element) {
      selected_media_id.add(element.id.toString());
    });
    print('step 2');
    List<String> selected_attr_id = [];
    List<String> selected_attr_name = [];
    list_of_selected_attr.forEach((element) {
      selected_attr_id.add(element.selected_attr!.id.toString());
      selected_attr_name.add(element.selected_attr!.name.toString());
    });
    print('step 3');
    List<String> selected_colors_id = [];
    list_of_selected_colors.forEach((element) {
      selected_colors_id.add(element.code!);
    });
    print('step 4');
    Map<String, dynamic> map_of_variants = {};
    if (!has_variation) {
      list_of_attribute_variations.forEach((element) {
        Map<String, dynamic> map = {
          'price_${element.name}': '${element.price}',
          'qty_${element.name}': '${element.quantity}',
          'sku_${element.name}': '${element.sku}',
          'img_${element.name}': '${element.photos!.join(',')}',
        };
        map_of_variants.addAll(map);
      });
    } else {
      list_of_attribute_variations_combination.forEach((element) {
        Map<String, dynamic> map = {
          'price_${element.name}': '${element.price}',
          'qty_${element.name}': '${element.quantity}',
          'sku_${element.name}': '${element.sku}',
          'img_${element.name}': element.photos!.isEmpty
              ? thumbnailImage!.id.toString()
              : '${element.photos!.join(',')}',
        };
        map_of_variants.addAll(map);
      });
    }
    print('map_of_variants=$map_of_variants');
    print('step 5');
    Map<String, dynamic> choice_option = {};
    list_of_selected_attr.forEach((element) {
      List values_name = [];
      element.list_selected_attr_values!.forEach((e) {
        values_name.add(e.value);
      });
      choice_option.addAll(
          {'choice_options_${element.selected_attr!.id}[]': values_name});
    });
    print('step 6');
    List<Map<String, dynamic>> stages = [];
    list_of_selected_construction_stages.forEach((e) {
      stages.add({"value": "${e.label}"});
    });
    List<Map<String, dynamic>> list_of_tag_selected = [];
    listofTags.forEach((element) {
      list_of_tag_selected.add({"value": "$element"});
    });
    print('step 7');
    Map<String, dynamic> object = {
      'name': '${name_controller.text}',
      'added_by': 'seller',
      'category_id': selected_child_Cat == null
          ? '${selected_Cat!.id}'
          : '${selected_child_Cat!.id}',
      'brand_id': selected_brand == null ? '' : '${selected_brand!.id}',
      'photos': selected_media_id.join(','),
      'thumbnail_img': '${thumbnailImage!.id}',
      'tags': jsonEncode(list_of_tag_selected),
      'video_provider': 'youtube',
      'video_link': '',
      'description': await htmlEditorController.getText(),
      'unit_price': '${unit_price_controller.text}',
      'purchase_price': '${minimum_purchase_controller.text}',
      'variant_product': list_of_attribute_variations.isNotEmpty ? '1' : '0',
      'choice_attributes[]': selected_attr_id,
      'choice_no[]': selected_attr_id,
      'choice[]': selected_attr_name,
      'colors[]': selected_colors_id,
      'colors_active': list_of_selected_colors.isEmpty ? '0' : '1',
      'published': '0',
      'stock_visibility_state': low_stock_warning == 'Show Stock Quantity'
          ? 'quantity'
          : low_stock_warning == 'Show Stock With Text Only'
              ? 'text'
              : 'hide',
      'cash_on_delivery': cash_on_delivery ? '1' : '0',
      'current_stock': '${quantity_controller.text}',
      'unit': '${unit_controller.text}',
      'weight': '${weight_controller.text}',
      'min_qty': '${minimum_purchase_controller.text}',
      'low_stock_quantity': '${low_stock_quantity_warning_controller.text}',
      'discount': '${discount_controller.text}',
      'discount_type': selected_discount_type == 'Flat' ? 'flat' : 'percent',
      'shipping_type': shiping == 'Free Shipping' ? 'free' : 'flat_rate',
      'flat_shipping_cost': shipping_cofigration_charges_controller.text,
      'est_shipping_days': estimated_shiping_time_controller.text.isEmpty
          ? '0'
          : '${estimated_shiping_time_controller.text}',
      'tax[]': ['3'],
      'stages': jsonEncode(stages),
      'date_range': '',
      'external_link': '${internal_link_controller.text}',
      'external_link_btn': '${internal_link_button_text_controller.text}',
      'tax_id[]': '3',
      'tax_type[]': '[percent]',
      'warranty': '${warenty_controller.text}'
    };
    print('step 8 ');
    object.addAll(map_of_variants);
    print('step 9');
    object.addAll(choice_option);
    print('step 10');
    log('object = $object');
    upload_data = true;
    notifyListeners();
    AddProductResponceModel? v =
        await DataProvider.add_product_api(mapObject: object);
    upload_data = false;
    notifyListeners();
    if (v != null && v.success!) {
      Navigator.of(context)
          .push(material.MaterialPageRoute(
              builder: (c) => ProductDetailPage(
                    userId: v.productId.toString(),
                  )))
          .then((value) {
        Navigator.of(context).pop();
      });
    }
  }
}
