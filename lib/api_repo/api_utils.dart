import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mShop_Seller/model/App%20Check%20Virsion/app_check_version.dart';
import 'package:mShop_Seller/model/add_product/Construction_stages.dart';
import 'package:mShop_Seller/model/add_product/attribute.dart';
import 'package:mShop_Seller/model/add_product/brands.dart';
import 'package:mShop_Seller/model/commision/commision_model.dart';
import 'package:mShop_Seller/model/dashboard/dashboard_model.dart';
import 'package:mShop_Seller/model/order/ware_house_model.dart';
import 'package:mShop_Seller/model/verification_page/issue_authority.dart';
import 'package:mShop_Seller/view/screens/LoginPages/login_screen.dart';

import '../model/All Products/all_products_model.dart';
import '../model/Compaigns/all_product_model_compain.dart';
import '../model/Compaigns/campaing_search_model.dart';
import '../model/Compaigns/compaign_model.dart';
import '../model/Downloade/downloade_model.dart';
import '../model/Invoice/invoice_model.dart';
import '../model/Notification/in_app_notification.dart';
import '../model/add_product/AddProductResponceModel.dart';
import '../model/add_product/colors_class.dart' as color;
import '../model/add_product/product_attribute.dart';
import '../model/add_product/product_category.dart';
import '../model/add_to_cart_model/add_to_cart_count_model.dart';
import '../model/add_to_cart_model/add_to_cart_list.dart';
import '../model/add_to_cart_model/add_to_cart_summary_model.dart';
import '../model/all_ware_house/all_ware_house_model.dart';
import '../model/commission_history/commission_history_model.dart';
import '../model/delivery_model/delivery_model_list.dart';
import '../model/home/home_screen_model.dart';
import '../model/home_sub_category/ProductSearchModel.dart';
import '../model/home_sub_category/get_all_product_categories_model.dart';
import '../model/home_sub_category/get_product_single_user_model.dart';
import '../model/home_sub_category/sub_categories_model.dart';
import '../model/home_sub_category/sub_categories_of_categories_model.dart';
import '../model/login/login_model.dart';
import '../model/media/product_media.dart';
import '../model/order/company_type.dart';
import '../model/order/my_order_model.dart';
import '../model/order/order_detail_model.dart';
import '../model/password_reset/confirm_reset.dart';
import '../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';
import '../model/product/top_seller/top_seller_model.dart';
import '../model/reports/mothly_model.dart';
import '../model/reports/total_sale_model.dart';
import '../model/reports/year_model.dart';
import '../model/soled_by_shop/single_shop_model.dart';
import '../model/verification_page/city.dart';
import '../model/verification_page/shop_details.dart';
import '../model/verification_page/states.dart';
import '../model/wearhouse/wearhouse_model.dart';
import '../model/wishlist_models/add_wishlist_view_model/add_wishlist_view.dart';
import '../model/wishlist_models/wishlist_count_model/wishlist_count.dart';
import '../utils_services/global_variable.dart';
import '../utils_services/storage_util.dart';
import '../view/global_widgets/Sackbars.dart';
import '../view_model/login_bloc_function/Forgot Password Blocs/Reset Password Confirmed/reset_password_confirmed_bloc.dart';
import 'basepath.dart';

const categories = 'categories';
const subCategories = 'sub-categories/';
const product = 'products/seller';
const osnotifications = 'osnotifications';
const products = 'products/';
const seller = 'seller';
const search_product = 'products/search';
const topSeller = 'best-seller';
const allProductsShop = 'products/seller';
const allProductsByBrand = 'products/user/brand';
const allProductsByStages = 'products/user/stage';
const productIdBy = 'products/seller/category/';
const orders = 'seller/orders';
const paymentToAdminUrl = 'payments/sent_to_admin';
const slectedHouse = 'delivery/find_delivery_company';
const addToCartsLists = 'carts';
const addToCartSummary = 'cart-summary';
const userLogin = 'auth/login';
const userSignUp = 'auth/register/seller';
const userAddToCart = 'carts/add';
const userAddToWishlist = 'wishlists';
const userRemoveToWishlist = 'wishlists-remove-product?product_id';
const userAddToCartCounting = 'cart-count';
const userInvoiceUrl = 'seller/inovices';
const wishlistCounting = 'wishlists-count';
const wishlistView = 'wishlists';
const process_bulk_upload = 'product-bulk-upload/store';
const get_media = 'media/get_uploaded_files';
const add_delivery = 'add_delivery_boy';
const upload_media = 'media/upload';
const cities = 'cities';
const deleteWareHouse = 'warehouse/delete';
const campaignUrl = 'seller/campaigns/';
const addWareHouse = 'warehouse/add';
const updateWareHouse = 'warehouse/edit';
const assign = 'deliveries/assign';
const states = 'states';
const issue_authority = 'issue_authorities';
const update_user = 'verify_store';
const product_categories = 'categories-drop-down';
const get_attributes = 'attribute-by-category';
const brand_categories_id = 'brand-by-category';
const brand_categories = 'brands-drop-down';
const get_colors = 'colors-drop-down';
const add_products = 'products/add';
const construction_stages = 'construction/stages';
const order_detail = 'order';
const delivery_company_type = 'seller/list_delivery_company_type';
const brandUrl = 'brands';
const received_payment = 'payments/upload_payment_receipt';
const CommissionUrl = 'commission-history';
const ware_house = 'seller_warehouse_list';
const ware_house_all = 'seller_warehouse_list';
const update_delivery_status = 'orders/update-delivery-status';
const update_payment_status = 'orders/update-payment-status';
const update_delivarable_by = 'update_delivered_by';
const resend_code = 'auth/resend_code';
const resend_code_phone = 'auth/password/resend_code';
const confirm_reset = 'auth/password/reset_password';
const delete_product = 'product/delete';
const shop_details = 'get_shop_details';
const boylist = 'delivery_boy/list';
const deleteboy = 'delivery_boy/delete';
const updateBoy = 'update_delivery_boy';
const upload_contract = 'seller/upload_contract';
const get_image_path = 'media/get-image-path';
const dashboard_seller = 'dashboard-seller';
const wearHouseUrl = 'seller_warehouse_list';
const commission_history = 'commission-history';
const verify_otp = 'auth/confirm_code_phone';
const confirm_otp_reset = 'auth/password/confirm_reset';
const forget_request = 'auth/password/forget_request';
const product_search = 'products/search/shop?name=';
const cities_by_state = 'cities-by-state';
const delete_media = 'media/destroy';
const seller_campaigns = 'seller/campaigns';
const download_url = 'seller/download_contract';
const add_new_campaign_url = 'seller/campaigns/add';
const update_new_campaign_url = 'seller/campaigns/update';
const all_product_url = 'products/seller';
const search_campaign_url = 'seller/campaigns/product';
const sale_report_year_url = 'seller/seller_sale_report_by_year';
const sale_report_mothly_url = 'seller/seller_sale_report_by_month';
const sale_report_total_url = 'seller/seller_sale_report';
const logout = 'auth/logout';
const verify_app_url = 'get_seller_app_settings';

class DataProvider {
  static Future<ProductSearchModel?> get_search_product({String? value}) async {
    final response =
        await http.get(Uri.parse('$baseURL$product_search$value'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('get_search_product is ${data}');
    if (data['status'] == 200) {
      ProductSearchModel dashBoard = ProductSearchModel.fromJson(data);
      return dashBoard;
    } else {
      return null;
    }
  }

  Future get_search_product_campaign({String? text}) async {
    final response =
        await http.post(Uri.parse('$baseURL$search_campaign_url'), body: {
      'product_name': '${text}',
    }, headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('get_search_product is ${data}');
    if (data['status'] == 200) {
      CampaignSearchModel campaignSearchModel =
          CampaignSearchModel.fromJson(data);
      return campaignSearchModel;
    } else {
      return null;
    }
  }
  static Future verify_app_selles_version() async {
    AppVersionCheckModel? appVersionCheckModel;
    final response =
    await http.get(Uri.parse('$baseURL$verify_app_url'));
    var data = jsonDecode(response.body);
    print('verify_Otp is ${data}');
    if (data['result'] == true) {
      appVersionCheckModel = AppVersionCheckModel.fromJson(data);
      return appVersionCheckModel;
    }
  }

  Future<DownloadModel?> get_download_product() async {
    print('get_download_product is');
    final response =
        await http.get(Uri.parse('$baseURL$download_url'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('get_download_product is ${response.body}');
    var data = jsonDecode(response.body);
    print('get_download_product is ${data}');
    if (data['result'] == true) {
      DownloadModel downloadModel = DownloadModel.fromJson(data);
      return downloadModel;
    } else {
      return null;
    }
  }

  Future<SaleReportYearModel?> get_sale_report_year({String? year}) async {
    final response =
        await http.post(Uri.parse('$baseURL$sale_report_year_url'), body: {
      'year': year,
    }, headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('sale report is ${response.body}');
    var data = jsonDecode(response.body);
    print('sale report is ${data}');
    if (data['result'] == true) {
      SaleReportYearModel yearModel = SaleReportYearModel.fromJson(data);
      return yearModel;
    } else {
      return null;
    }
  }

  Future<SaleReportYearModel?> logout_api({String? year}) async {
    final response = await http.post(Uri.parse('$baseURL$logout'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('logout resonce is = ${response.body}');
  }

  Future<MonthlySaleModel?> get_sale_report_month(
      {String? year, String? month}) async {
    print({
      'year': '${year}',
      'month': '${month}',
    });
    final response =
        await http.post(Uri.parse('$baseURL$sale_report_mothly_url'), body: {
      'year': '${year}',
      'month': '${month}',
    }, headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('sale report monthly ${response.body}');
    var data = jsonDecode(response.body);
    if (data['result'] == true) {
      MonthlySaleModel monthlySaleModel = MonthlySaleModel.fromJson(data);
      // print('sale report monthly data ${monthlySaleModel!.data!.dateWiseSales}');
      return monthlySaleModel;
    } else {
      return null;
    }
  }

  Future<TotalSaleModel?> get_total_sale_report() async {
    final response =
        await http.get(Uri.parse('$baseURL$sale_report_total_url'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('sale report monthly ${response.body}');
    var data = jsonDecode(response.body);
    print('sale report monthly data ${data}');
    if (data['result'] == true) {
      TotalSaleModel totalSaleModel = TotalSaleModel.fromJson(data);
      return totalSaleModel;
    } else {
      return null;
    }
  }

  Future get_all_product_Functions() async {
    final response = await http
        .post(Uri.parse('$baseURL$all_product_url?page=1&count=200'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    log('get_all_product is = ${response.body}');
    var data = jsonDecode(response.body);
    //print('get_all_product is ${data}');
    if (data['status'] == 200) {
      GetAllProductModelsCompain? getAllProduct = GetAllProductModelsCompain.fromJson(data);
      return getAllProduct;
    } else {
      return null;
    }
  }

  Future allProductsByShopFunction(
      {String? Id, String? page = '1', String? count}) async {
    GetAllProductsByShop shopProducts;
    print('${{'page': '${page}', 'count': '${count}'}}');
    final response = await http.post(Uri.parse('$baseURL$allProductsShop/$Id'),
        body: {'page': '${page}', 'count': '${count}'});
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data['success'] == true) {
      log("status code is ${response.statusCode}");
      shopProducts = GetAllProductsByShop.fromJson(data);
      print('Data is type ${shopProducts}');
      return shopProducts;
    }
  }

  Future allProductsByStagesFunction(
      {String? Id, String? page = '1', String? count}) async {
    GetAllProductsByShop shopProducts;
    final response = await http.get(
        Uri.parse('$baseURL$allProductsByStages/$Id?count=$count&page=$page'));
    print('Data is ${response.body}');
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data['success'] == true) {
      log("status code is ${response.statusCode}");
      shopProducts = GetAllProductsByShop.fromJson(data);
      print('Data is type ${shopProducts}');
      return shopProducts;
    }
  }

  Future allProductsByBrandFunction(
      {String? Id, String? page = '1', String? count}) async {
    GetAllProductsByShop shopProducts;
    final response = await http.get(
        Uri.parse('$baseURL$allProductsByBrand/$Id?count=$count&page=$page'));
    print('Data is ${response.body}');
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data['success'] == true) {
      log("status code is ${response.statusCode}");
      shopProducts = GetAllProductsByShop.fromJson(data);
      print('Data is type ${shopProducts}');
      return shopProducts;
    }
  }

  Future get_compaign_function({int? page, int? count}) async {
    final response = await http.get(
        Uri.parse('$baseURL$seller_campaigns?count=$count&page=$page'),
        headers: {
          'authtoken': '${user_model.accessToken}',
        });
    print('get_compaigns is ${response.body}');
    var data = jsonDecode(response.body);
    print('get_compaigns is ${data}');
    if (data['result'] == true) {
      CompaignModel compaignModel = CompaignModel.fromJson(data);
      return compaignModel;
    } else {
      return null;
    }
  }

  static Future<CommissionModel> get_commission_history_api() async {
    final response =
        await http.get(Uri.parse('$baseURL$commission_history'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('get_dashboard_api is ${data}');
    CommissionModel dashBoard = CommissionModel.fromJson(data);
    return dashBoard;
  }

  Future<bool> forget_request_api({String? phone}) async {
    print('phone ${phone}');
    final response = await http
        .post(Uri.parse('$baseURL$forget_request'), body: {"phone": phone});
    var data = jsonDecode(response.body);
    print('get_dashboard_api is ${data}');
    if (response.statusCode == 201) {
      forgot_user_id = data['user_id'].toString();
      //snackBarSuccess('${data['message']}');
      return true;
    } else {
      //snackBarSuccess('${data['message']}');
      return false;
    }
  }

  static Future<DashBoard> get_dashboard_api() async {
    final response =
        await http.get(Uri.parse('$baseURL$dashboard_seller'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('get_dashboard_api is ${data}');
    DashBoard dashBoard = DashBoard.fromJson(data);
    return dashBoard;
  }

  static Future<String> get_image_path_api({String? id}) async {
    final response = await http.get(Uri.parse('$baseURL$get_image_path/$id'));
    var data = jsonDecode(response.body);
    print('get_image_path_api is ${data}');
    return data['path'];
  }

  static Future<String> publish_product_api(
      {String? id, Map<String, dynamic>? object}) async {
    print('${'$baseURL$id'}');
    final response =
        await http.post(Uri.parse('$baseURL$id'), body: object, headers: {
      'Authorization': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('publish_product_api is ${data}');
    return data['message'];
  }

  static Future delete_product_api({String? id}) async {
    final response =
        await http.get(Uri.parse('$baseURL$delete_product/$id'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('delete_product_api is ${data}');
    if (data['result'] == true) {
      return true;
    } else {
      snackBarSuccess('${data['message']}');
      return false;
    }
  }

  static Future auth_resend_code(Map<String, dynamic> object) async {
    final response =
        await http.post(Uri.parse('$baseURL$resend_code'), body: object);
    // var data = jsonDecode(response.body);
    //print('auth_resend_code is ${data}');
  }

  static Future auth_resend_phone_code(Map<String, dynamic> object) async {
    final response =
        await http.post(Uri.parse('$baseURL$resend_code_phone'), body: object);
    var data = jsonDecode(response.body);
    print('auth_resend_code is ${data}');
  }

  Future confirm_reset_password(
      {String? userId, String? password, String? confirmedPassword}) async {
    final response =
        await http.post(Uri.parse('$baseURL$confirm_reset'), body: {
      "user_id": userId,
      "password": password,
      "confirm_password": confirmedPassword,
    });
    print('confirm_reset_password is ${response.body}');
    var data = jsonDecode(response.body);
    if (data['result'] == true) {
      snackBarSuccess('${data['message']}');
      return true;
    } else {
      snackBarSuccess('${data['message']}');
      return false;
    }
  }

  Future<ConfirmReset> confirm_Otp_rest({String? sendOtp}) async {
    final response = await http.post(Uri.parse('$baseURL$confirm_otp_reset'),
        body: {"password_reset_code": sendOtp});
    var data = jsonDecode(response.body);
    print('confirm_otp_reset is ${data}');
    if (data['result'] == true) {
      snackBarSuccess('${data['message']}');
      return ConfirmReset(user_id: data['user_id'].toString(), result: true);
    } else {
      snackBarSuccess('${data['message']}');
      return ConfirmReset(result: false);
    }
  }

  static Future<bool> verify_Otp(Map<String, dynamic> object) async {
    final response =
        await http.post(Uri.parse('$baseURL$verify_otp'), body: object);
    var data = jsonDecode(response.body);
    print('verify_Otp is ${data}');
    if (data['result'] == true) {
      // snackBarSuccess('${data['message']}');
      return true;
    } else {
      snackBarSuccess('${data['message']}');
      return false;
    }
  }

  Future add_new_campaign({Map<String, dynamic>? object}) async {
    final response = await http.post(Uri.parse('$baseURL$add_new_campaign_url'),
        body: object,
        headers: {
          'authtoken': '${user_model.accessToken}',
        });
    var data = jsonDecode(response.body);
    print('data is======= ${data}');
    print('object is======= ${object}');
    if (data['result'] == true) {
      snackBarSuccess('${data['message']}');
      return true;
    } else {
      snackBarSuccess('${data['message']}');
      return false;
    }
  }

  Future update_new_campaign({Map<String, dynamic>? object}) async {
    final response = await http.post(
        Uri.parse('$baseURL$update_new_campaign_url'),
        body: object,
        headers: {
          'authtoken': '${user_model.accessToken}',
        });
    var data = jsonDecode(response.body);
    print('data is======= ${data}');
    print('object is======= ${object}');
    if (data['result'] == true) {
      snackBarSuccess('${data['message']}');
      return true;
    } else {
      snackBarSuccess('${data['message']}');
      return false;
    }
  }

  static Future<City> get_all_cites() async {
    final response = await http.get(Uri.parse('$baseURL$cities'));
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    City city = City.fromJson(data);
    return city;
  }

  static Future<City> get_cites_by_state({String? id}) async {
    final response = await http.get(Uri.parse('$baseURL$cities_by_state/$id'));
    var data = jsonDecode(response.body);
    print('get_cites_by_state Data is =${data}');
    City city = City.fromJson(data);
    return city;
  }

  static Future deleteMedia({String? id}) async {
    print('$baseURL$delete_media/$id');
    final response =
        await http.get(Uri.parse('$baseURL$delete_media/$id'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('deleteMedia is =${data}');
  }

  static Future<AddProductResponceModel?> add_product_api(
      {Map<String, dynamic>? mapObject}) async {
    print('In the api function');
    final response = await dio.Dio().post('$baseURL$add_products',
        data: dio.FormData.fromMap(mapObject!),
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    var data = response.data;
    print('Add Product result data =$data');
    if (data['status'] == 200) {
      snackBarSuccess(data['message']);
      return AddProductResponceModel.fromJson(data);
    } else {
      snackBarFailer(data['message']);
      return null;
    }
  }

  static Future<OrderDetailModel> orderDetailFunction(String ID) async {
    final response =
        await http.get(Uri.parse('$baseURL$order_detail/$ID'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('orderDetail data =${response.body}');
    var data = jsonDecode(response.body);
    OrderDetailModel model = OrderDetailModel.fromJson(data);
    return model;
  }

  static Future<CompanyTypeModel> companyTypeModel() async {
    final response =
        await http.get(Uri.parse('$baseURL$delivery_company_type'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('companyTypeModel data =${response.body}');
    var data = jsonDecode(response.body);
    CompanyTypeModel model = CompanyTypeModel.fromJson(data);
    return model;
  }

  static Future<WareHouseModel> ware_house_api() async {
    final response = await http.get(Uri.parse('$baseURL$ware_house'), headers: {
      'authtoken': '${user_model.accessToken}',
      'shop-id': user_model.user!.shopId.toString()
    });
    var data = jsonDecode(response.body);
    print('WareHouseModel data =$data');
    WareHouseModel model = WareHouseModel.fromJson(data);
    return model;
  }

  Future ware_house_all_api({int? page, int? count}) async {
    final response = await http.get(
        Uri.parse('$baseURL$ware_house_all?count=$count&page=$page'),
        headers: {
          'authtoken': '${user_model.accessToken}',
          'shop-id': '${user_model.user!.shopId.toString()}'
        });
    var data = jsonDecode(response.body);
    print('WareHouseModel model data =$data');
    if (data['result'] == true) {
      allWareHouseModel allModel = allWareHouseModel.fromJson(data);
      return allModel;
    }
  }

  static Future<Attribute> product_attribute_api(String id) async {
    final response = await http.get(Uri.parse('$baseURL$get_attributes/$id'));
    var data = jsonDecode(response.body);
    print('Colors data =$data');
    Attribute model = Attribute.fromJson(data);
    return model;
  }

  static Future update_delivery_status_api(Map<String, dynamic> object) async {
    final response = await http.post(
        Uri.parse('$baseURL$update_delivery_status'),
        body: object,
        headers: {
          'authtoken': '${user_model.accessToken}',
        });
    print('update_delivery_status_api data =${response.body}');
  }

  static Future update_payment_status_api(Map<String, dynamic> object) async {
    final response = await http.post(
        Uri.parse('$baseURL$update_payment_status'),
        body: object,
        headers: {
          'authtoken': '${user_model.accessToken}',
        });
    var data = jsonDecode(response.body);
    print('update_payment_status_api data =$data');
  }

  static Future update_delivarable_by_api(
      {Map<String, dynamic>? object, String? id}) async {
    final response = await http.post(
      Uri.parse('$baseURL$update_delivarable_by/$id'),
      body: object,
    );
    var data = jsonDecode(response.body);
    print('update_delivarable_by_api data =$data');
  }

  static Future<color.Colors> product_color_api() async {
    final response = await http.get(Uri.parse('$baseURL$get_colors'));
    var data = jsonDecode(response.body);
    print('Colors data =$data');
    color.Colors model = color.Colors.fromJson(data);
    return model;
  }

  static Future<ProductAttributes> productAttribute_api(
      {Map? mapObject}) async {
    final response = await http.get(Uri.parse('$baseURL$get_attributes'));
    var data = jsonDecode(response.body);
    print('ProductAttributes data =$data');
    ProductAttributes model = ProductAttributes.fromJson(data);
    return model;
  }

  static Future<ProductCategories> productCategories_api() async {
    final response = await http.get(Uri.parse('$baseURL$product_categories'));
    var data = jsonDecode(response.body);
    print('product cat data =$data');
    ProductCategories model = ProductCategories.fromJson(data);
    return model;
  }

  static Future<ConstructionStages> costruction_stages_api() async {
    final response = await http.get(Uri.parse('$baseURL$construction_stages'));
    var data = jsonDecode(response.body);
    print('ConstructionStages data =$data');
    ConstructionStages model = ConstructionStages.fromJson(data);
    return model;
  }

  static Future<Brands> brandsCategoriesById_api(String id) async {
    print('$baseURL$brand_categories_id/$id');
    final response =
        await http.get(Uri.parse('$baseURL$brand_categories_id/$id'));
    var data = jsonDecode(response.body);
    print('brands cat data =$data');
    Brands model = Brands.fromJson(data);
    return model;
  }

  static Future<Brands> brandsCategories_api() async {
    print('$baseURL$brand_categories');
    final response = await http.get(Uri.parse('$baseURL$brand_categories'));
    var data = jsonDecode(response.body);
    print('brands cat data =$data');
    Brands model = Brands.fromJson(data);
    return model;
  }

  static Future<bool> update_user_api({dio.FormData? mapObject}) async {
    print('${{
      'authtoken': '${user_model.accessToken}',
    }}');
    try {
      final response = await dio.Dio().post('$baseURL$update_user',
          data: mapObject,
          options: dio.Options(headers: {
            'authtoken': '${user_model.accessToken}',
          }));
      var data = response.data;
      print('update user data =$data');
      if (data['result'] == true) {
        return true;
      } else {
        snackBarFailer('${data['message']}');
        return false;
      }
    } catch (e) {
      print('exception is = ${e}');
      return false;
    }
  }

  Future upLoad_user_documents({dio.FormData? mapObject}) async {
    final response = await dio.Dio().post('$baseURL$upload_contract',
        data: mapObject,
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    var data = response.data;
    print('upLoad user data =$data');
    if (data['result'] == true) {
      return true;
    } else {
      snackBarFailer('${data['message']}');
      return false;
    }
  }

  Future<States> get_all_states() async {
    final response = await http.get(Uri.parse('$baseURL$states'));
    var data = jsonDecode(response.body);
    print('State is ${data}');
    States state = States.fromJson(data);
    return state;
  }

  static Future<ShopDetails> get_shop_details() async {
    final response = await http.get(Uri.parse('$baseURL$shop_details'),
        headers: {'authtoken': '${user_model.accessToken}'});
    var data = jsonDecode(response.body);
    print('get_shop_details is ${data}');
    ShopDetails state = ShopDetails.fromJson(data);
    return state;
  }

  static Future<IssueAuthority> get_issue_authority() async {
    final response = await http.get(Uri.parse('$baseURL$issue_authority'));
    var data = jsonDecode(response.body);
    print('issue authority is = ${data}');
    IssueAuthority state = IssueAuthority.fromJson(data);
    return state;
  }

  Future<bool> loginFunction({String? Email, String? Password}) async {
    print('loginFunction = $baseURL$userLogin');
    final response = await http.post(Uri.parse('$baseURL$userLogin'), body: {
      'email_or_phone': '$Email',
      'password': '$Password',
      'user_type': 'seller',
    });
    print('Data is ${response.body}');
    print('email is ${Email}');
    print('password is ${Password}');
    var data = jsonDecode(response.body);
    print('data is....... ${data}');
    if (data['result'] == true) {
      print('object...................');
      log("status code is ${response.statusCode}");
      storage.write('user_password', Password);
      user_model = LoginModel.fromJson(data);
      storage.write('userData', user_model.toJson());
      return true;
    } else {
      snackBarFailer('Invalid credentials');
      return false;
    }
  }

  Future<bool> signUpFunction(
      {String? Email,
      String? Password,
      String? name,
      String? shopName,
      String? phone,
      BuildContext? context,
      String? confirmPassword}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL$userSignUp'),
        body: {
          'email': '$Email',
          'phone': '$phone',
          'name': '$name',
          'password': '$Password',
          'shop_name': '$shopName',
          'password_confirmation': '$confirmPassword',
          'user_type': 'seller',
          'phone_code': '971'
        },
      );
      var data = jsonDecode(response.body);
     // print('Data is ${data}');
      //snackBarSuccess('${data['message']}');
      if (data['result'] == true) {
        Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
        //snackBarSuccess('${data['message']}');
        return true;
      } else {
        snackBarSuccess('${data['message']}');
        return false;
      }
    } catch (e) {
      snackBarSuccess('Please verify via email/phone');
      return true;
    }
  }

  Future getHome() async {
    HomeScreenModel homeScreenModel;
    final response = await http.get(
      Uri.parse('$baseURL$categories'),
    );
    var data = jsonDecode(response.body);
    log("status code is ${data}");
    if (data['status'] == 200) {
      homeScreenModel = HomeScreenModel.fromJson(data);
      return homeScreenModel;
    }
  }

  Future topBestSeller() async {
    TopBestSellingProduct sellingProduct;
    final response = await http.get(
      Uri.parse('$baseURL$products$topSeller'),
    );
    var data = jsonDecode(response.body);
    log("status code is ${data}");
    if (data['status'] == 200) {
      sellingProduct = TopBestSellingProduct.fromJson(data);
      return sellingProduct;
    }
  }

  Future getSubCategories(String Id) async {
    SubCategoriesModel subCategoriesModel;
    final response = await http.get(
      Uri.parse('$baseURL$subCategories$Id'),
    );
    var data = jsonDecode(response.body);
    log("status code is ${data}");
    if (data['status'] == 200) {
      subCategoriesModel = SubCategoriesModel.fromJson(data);
      return subCategoriesModel;
    }
  }

  Future getCommissionHistoryFunction() async {
    CommissionHistory commissionHistory;
    final response = await http.get(Uri.parse('$baseURL$CommissionUrl'),
        headers: {'authtoken': '${user_model.accessToken}'});
    var data = jsonDecode(response.body);
    print("status code is ${response.body}");
    if (data['status'] == 200) {
      commissionHistory = CommissionHistory.fromJson(data);
      return commissionHistory;
    }
  }

  Future getSelectedWearHouse({Map<String, dynamic>? map}) async {
    log("request getSelectedWearHouse = ${map}");
    final response = await http.post(Uri.parse('$baseURL$slectedHouse'),
        headers: {'authtoken': '${user_model.accessToken}'}, body: map);
    var data = jsonDecode(response.body);
    log("status code is ${data}");
  }

  Future getDeliveryAssign({Map<String, dynamic>? map}) async {
    print('getDeliveryAssign = ${map}');
    final response = await http.post(Uri.parse('$baseURL$assign'),
        headers: {'authtoken': '${user_model.accessToken}'}, body: map);
    print('${response.body}');
    var data = jsonDecode(response.body);
    if (data['status'] == 200) {
      log("status code is ${response.statusCode}");
    }
  }

  Future<GetAllProductOfCategories> getAllProductCategories(
      {String? Id, int? page, int? count = 6}) async {
    print('$baseURL$productIdBy$Id?page=$page&count=$count');
    final response = await http.get(
        Uri.parse('$baseURL$productIdBy$Id?page=$page&count=$count'),
        headers: {'authtoken': '${user_model.accessToken}'});
    var data = jsonDecode(response.body);
    log("status code is ${data}");
    if (data['success'] == true) {
      GetAllProductOfCategories getAllProductOfCategories =
          GetAllProductOfCategories.fromJson(data);
      return getAllProductOfCategories;
    } else {
      return GetAllProductOfCategories(data: [], status: 200, success: true);
    }
  }

  Future<GetAllProductOfCategories> getAllProduct(
      {int? page = 1, int? count = 70}) async {
    print('url is = $baseURL$product?page=1&count=70');
    final response = await http.post(
        Uri.parse('$baseURL$product?page=1&count=70'),
        headers: {'authtoken': '${user_model.accessToken}'});
    var data = jsonDecode(response.body);
    log("status code is ${data}");
    if (data['success'] == true) {
      GetAllProductOfCategories getAllProductOfCategories =
          GetAllProductOfCategories.fromJson(data);
      return getAllProductOfCategories;
    } else {
      return GetAllProductOfCategories(data: [], status: 200, success: true);
    }
  }

  Future getSubCategoriesOfCategoriesFunction(
      {String? CategoryId, int? page, String? name = ''}) async {
    log("CategoryId is ${CategoryId}");
    GetAllProductOfCategories categoriesOfCategoriesModel;
    final response = await http.get(
      Uri.parse('$baseURL$product/sub-category/$CategoryId?page=$page'),
    );
    var data = jsonDecode(response.body);
    if (data['status'] == 200) {
      log("status code is ${response.statusCode}");
      categoriesOfCategoriesModel =
          GetAllProductOfCategories.fromJson(data);
      return categoriesOfCategoriesModel;
    }
  }

  Future<NotificationModel> get_app_notifications(
      {int? count = 20, int? page = 1}) async {
    final response = await http.get(
        Uri.parse('$baseURL' +
            'osnotifications?app=staging-seller&count=$count&page=$page'),
        headers: {'authtoken': '${user_model.accessToken}'});
    print('get_app_notifications .... ${response.body}');
    var data = jsonDecode(response.body);
    NotificationModel appNotification = NotificationModel.fromJson(data);
    return appNotification;
  }

  Future update_notification({String? id}) async {
    final response = await http.post(
        Uri.parse('$baseURL' + 'notification/viewed?notification_id=${id}'),
        headers: {'authtoken': '${user_model.accessToken}'});
    print('update_notification .... ${response.body}');
  }

  Future getSingleUserProduct({
    required String? Id,
  }) async {
    getProductSingleUserModel productSingleUserModel;
    final response = await http.get(Uri.parse('$baseURL$products$Id'),
        headers: {'authtoken': '${user_model.accessToken}'});
    log("getSingleUserProduct data is = ${response.body}");
    var data = jsonDecode(response.body);
    if (data['status'] == 200) {
      productSingleUserModel =
          getProductSingleUserModel.fromJson(data['data'][0]);
      return productSingleUserModel;
    }
  }

  Future<AddToCartList> addToCartListFunction() async {
    AddToCartList cartList;
    final response =
        await http.post(Uri.parse('$baseURL$addToCartsLists'), headers: {
      //'AddToCartList': 'application/json',
      'Authorization': 'Bearer ${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('Data is ${data}');

    log("status code is ${response.statusCode}");
    cartList = AddToCartList.fromJson(data[0]);
    print('Cart List is ${cartList}');

    return cartList;
  }

  Future addToCartSummaryFunction() async {
    AddToCartSummaryModel model;
    final response =
        await http.get(Uri.parse('$baseURL$addToCartSummary'), headers: {
      // 'AddToCartList': 'application/json',
      'Authorization': 'Bearer ${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('Data is ${data}');

    log("status code is ${response.statusCode}");
    model = AddToCartSummaryModel.fromJson(data);
    print('Cart List is ${model}');

    return model;
  }

  Future<bool> addToFunction(
      {String? id, String? userId, String? variant, String? quantity}) async {
    final response = await http.post(
      Uri.parse('$baseURL$userAddToCart'),
      headers: {
        'authtoken': '${user_model.accessToken}',
      },
      body: {
        'id': '$id',
        'variant': '$variant',
        'user_id': '$userId',
        'quantity': '$quantity',
      },
    );
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  Future myOrderFunction({String? status, String? page, String? count}) async {
    MyOrderModel myOrderModel;
    print(
        'Order responce is = ${'$baseURL$orders/' + 'by-multi-status' + '?delivery_status=$status' + '&count=20' + '&page=$page'}');
    final response = await http.get(
      Uri.parse('$baseURL$orders/' +
          'by-multi-status' +
          '?delivery_status=$status' +
          '&count=${count}' +
          '&page=$page'),
      headers: {'authtoken': '${user_model.accessToken}'},
    );
    var data = jsonDecode(response.body);
    print('Order responce is = ${user_model.accessToken}');
    print('Order responce is = ${data}');
    if (data != null) {
      log("status code is ${response.statusCode}");
      myOrderModel = MyOrderModel.fromJson(data);
      print('Data is type ${myOrderModel}');
      return myOrderModel;
    }
  }

  Future<PaymentSentModel?> paymentToAdminFunction(
      {int? page, int? count}) async {
    PaymentSentModel sentModel;
    final response = await http.get(
      Uri.parse('$baseURL$paymentToAdminUrl?count=$count&page=$page'),
      headers: {'authtoken': '${user_model.accessToken}'},
    );
    print('paymentToAdminFunction  = ${response.body}');
    var data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      return null;
    }
    if (data['result'] == true) {
      sentModel = PaymentSentModel.fromJson(data);
      return sentModel;
    } else {
      return null;
    }
  }

  Future getCartCountingFunction() async {
    AddCartCountModel addCartCountModel;
    final response =
        await http.get(Uri.parse('$baseURL$userAddToCartCounting'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('object is ===${user_model.accessToken}');
    var data = jsonDecode(response.body);
    print('object is === ${data}');
    if (data['status'] == true) {
      log("status code is ${response.statusCode}");
      addCartCountModel = AddCartCountModel.fromJson(data);
      print('object is ===== ${addCartCountModel}');
      return addCartCountModel;
    }
  }
  Future viewInvoiceFunction({int? page,int? count}) async {
    invoiceModelView? invoiceModel;
    final response =
        await http.get(Uri.parse('$baseURL$userInvoiceUrl?count=$count&page=$page'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('object is ===${user_model.accessToken}');
    var data = jsonDecode(response.body);
    print('object is === ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      invoiceModel = invoiceModelView.fromJson(data);
      print('object is ===== ${invoiceModel}');
      return invoiceModel;
    }
  }

  Future getDeliveryBoyListFunction() async {
    DeliveryBoyList deliveryBoyList;
    final response = await http.get(Uri.parse('$baseURL$boylist'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('object is data === ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      deliveryBoyList = DeliveryBoyList.fromJson(data);
      print('object is ===== ${deliveryBoyList}');
      return deliveryBoyList;
    }
  }

  Future deleteDeliveryBoy(String id) async {
    print('$baseURL$deleteboy/$id');
    final response =
        await http.get(Uri.parse('$baseURL$deleteboy/$id'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('object is data === ${response.body}');
  }

  Future updateDeliveryBoy({Map<String, dynamic>? map}) async {
    print('update delivery boy === ${map}');
    final response =
        await http.post(Uri.parse('$baseURL$updateBoy'), body: map);
    var data = jsonDecode(response.body);
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      return true;
    }
  }

  Future<GetWearhouseList> getWearHouseFunction() async {
    GetWearhouseList wearHouseList;
    final response =
        await http.get(Uri.parse('$baseURL$wearHouseUrl'), headers: {
      'authtoken': '${user_model.accessToken}',
      'shop-id': '${user_model.user!.shopId}',
    });
    var data = jsonDecode(response.body);
    print('getWearHouseFunction === ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      wearHouseList = GetWearhouseList.fromJson(data);
      print('object is ===== ${wearHouseList}');
      return wearHouseList;
    } else {
      return GetWearhouseList();
    }
  }

  Future wishlistViewFunction() async {
    AddWishlistViewModel addWishlistViewModel;
    final response =
        await http.get(Uri.parse('$baseURL$wishlistView'), headers: {
      'Authorization': 'Bearer ${user_model.accessToken}',
    });
    print('object is ===${user_model.accessToken}');
    var data = jsonDecode(response.body);
    print('object is === ${data}');
    if (data['success'] == true) {
      log("status code is ${response.statusCode}");
      addWishlistViewModel = AddWishlistViewModel.fromJson(data);
      print('object is ===== ${addWishlistViewModel}');
      return addWishlistViewModel;
    }
  }

  Future wishlistCountingFunction() async {
    WishlistCountModel wishlistCountModel;
    final response =
        await http.get(Uri.parse('$baseURL$wishlistCounting'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    print('object is ===${user_model.accessToken}');
    var data = jsonDecode(response.body);
    print('object is === ${data}');
    if (data['status'] == true) {
      log("status code is ${response.statusCode}");
      wishlistCountModel = WishlistCountModel.fromJson(data);
      print('object is ===== ${wishlistCountModel}');
      return wishlistCountModel;
    }
  }

  Future<bool> addToWishlistFunction({
    String? productId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseURL$userAddToWishlist'),
      headers: {
        //  'Content-Type' : 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ${user_model.accessToken}',
      },
      body: {
        'user_id': '${user_model.user!.id}',
        'product_id': '$productId',
      },
    );
    print('Data is ${productId}');
    var data = jsonDecode(response.body);
    print('Data is ${productId}');
    if (data != null) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeToWishlistFunction({
    String? productIdRemove,
  }) async {
    final response = await http.get(
      Uri.parse('$baseURL$userRemoveToWishlist=$productIdRemove'),
      headers: {
        'Authorization': 'Bearer ${user_model.accessToken}',
      },
    );
    print('Data is ${productIdRemove}');
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data != null) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeToWareHouseFunction({Map<String, dynamic>? map}) async {
    final response = await http.post(
      Uri.parse('$baseURL$deleteWareHouse'),
      body: map,
      headers: {
        'authtoken': '${user_model.accessToken}',
      },
    );
    var data = jsonDecode(response.body);
    print('Data is ${data}');
    if (data['result'] != true) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeToCompaignFunction({int? Id}) async {
    final response = await http.delete(
      Uri.parse('$baseURL$campaignUrl$Id'),
      headers: {
        'authtoken': '${user_model.accessToken}',
      },
    );
    return true;
    // var data = jsonDecode(response.body);
    // if (data['result'] == true) {
    //   print('Data is Campaign ${data}');
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future addNewWareHouseFunction({Map<String, dynamic>? map}) async {
    final response = await http.post(
      Uri.parse('$baseURL$addWareHouse'),
      body: map,
      headers: {
        'authtoken': '${user_model.accessToken}',
      },
    );
    print('Data is add warehouse ${map}');
    var data = jsonDecode(response.body);
    print('Data is add warehouse ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  Future updateWareHouseFunction({Map<String, dynamic>? map}) async {
    final response = await http.post(
      Uri.parse('$baseURL$updateWareHouse'),
      body: map,
      headers: {
        'authtoken': '${user_model.accessToken}',
      },
    );
    print('Data is add warehouse ${map}');
    var data = jsonDecode(response.body);
    print('Data is add warehouse ${data}');
    if (data['result'] == true) {
      log("status code is ${response.statusCode}");
      return true;
    } else {
      return false;
    }
  }

  static Future process_bulk_upload_api({dio.FormData? uploadMedia}) async {
    final response = await dio.Dio().post('$baseURL$process_bulk_upload',
        data: uploadMedia,
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    var data = response.data;
    print('process_bulk_upload result data =$data');
    if (data['error'] == false) {
      snackBarFailer('${data['message']}');
    } else {
      snackBarSuccess('${data['message']}');
    }
  }

  Future addDeliveryBoyFunction(Map<String, dynamic> map) async {
    print('addDeliveryBoyFunction request object ${map}');
    print('url ...$baseURL$add_delivery');
    final response = await dio.Dio().post('$baseURL$add_delivery',
        data: dio.FormData.fromMap(map),
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    var data = response.data;
    print('product_media_api data =$data');
    if (data['result'] == true) {
      snackBarFailer('${data['message']}');
    } else {
      snackBarFailer('${data['message']}');
    }
  }

  Future sendPaymentReceiptFunction({required Map<String, dynamic> map}) async {
    final response = await dio.Dio().post('$baseURL$received_payment',
        data: dio.FormData.fromMap(map),
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    print('object of map ${map}');
    var data = response.data;
    print('product_media_api data =$data');
    if (data['result'] == true) {
      snackBarFailer('${data['message']}');
    } else {
      snackBarFailer('${data['message']}');
    }
  }

  static Future<ProductMedia> product_media_api({Map? mapObject}) async {
    final response = await http.get(Uri.parse('$baseURL$get_media'), headers: {
      'authtoken': '${user_model.accessToken}',
    });
    var data = jsonDecode(response.body);
    print('product_media_api data =$data');
    if (response.statusCode == 200) {
      ProductMedia model = ProductMedia.fromJson(data);
      return model;
    } else {
      snackBarFailer('${data['message']}');
      return ProductMedia();
    }
  }

  static Future uploadMedia_api({dio.FormData? uploadMedia}) async {
    final response = await dio.Dio().post('$baseURL$upload_media',
        data: uploadMedia,
        options: dio.Options(headers: {
          'authtoken': '${user_model.accessToken}',
        }));
    var data = response.data;
    print('Add Product result data =$data');
    if (data['error'] == false) {
      snackBarFailer('${data['message']}');
    } else {
      snackBarSuccess('${data['message']}');
    }
  }
}
