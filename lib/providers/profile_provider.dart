import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mShop_Seller/model/verification_page/city.dart';
import 'package:mShop_Seller/model/verification_page/issue_authority.dart';
import 'package:mShop_Seller/model/verification_page/issue_authority.dart'
    as issue_auth;
import 'package:mShop_Seller/model/verification_page/shop_details.dart';
import 'package:mShop_Seller/model/verification_page/states.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/utils_services/storage_util.dart';

import '../api_repo/api_utils.dart';
import '../model/verification_page/LicenseAuthorityModel.dart';
import '../model/verification_page/ware_house_model.dart';
import '../view/global_widgets/snakbar.dart';
import '../view/screens/bottom_sheet/bottom_sheet.dart';

class ProfileProvider extends ChangeNotifier {
  final formKey_general = GlobalKey<FormState>();
  final formKey_shop = GlobalKey<FormState>();
  final formKey_bank = GlobalKey<FormState>();
  final formKey_licence = GlobalKey<FormState>();
  bool update_status = false;
  TabController? tabController;
  updateUI() {
    notifyListeners();
  }

  TextEditingController general_owner_name_Controller = TextEditingController();
  TextEditingController general_owner_moblie_Controller =
      TextEditingController();
  TextEditingController general_owner_email_Controller =
      TextEditingController();
  TextEditingController general_owner_adress_Controller =
      TextEditingController();
  String general_owner_type = 'Emirati';
  List<String> general_dropDown_owner_type_list = ['Emirati', 'Resident'];

  String general_owner_id_type = 'Emirates ID';
  List<String> general_dropDown_owner_id_type_list = ['Emirates ID', 'Visa'];

  TextEditingController general_issue_date = TextEditingController();
  TextEditingController general_exp_date = TextEditingController();

  TextEditingController store_name_Controller = TextEditingController();
  TextEditingController store_adress_Controller = TextEditingController();
  TextEditingController store_phone_Controller = TextEditingController();
  TextEditingController store_pickup_adress_Controller =
      TextEditingController();

  double store_location_lat = 0.0;
  double store_location_lng = 0.0;
  double store_pickup_location_lat = 0.0;
  double store_pickup_location_lng = 0.0;
  String store_google_location_address = '';

  TextEditingController document_liceince_no = TextEditingController();
  TextEditingController document_issue_auth = TextEditingController();
  TextEditingController document_licence_activity = TextEditingController();
  TextEditingController document_vat_no = TextEditingController();
  String document_vat_register = 'yes';
  List<String> document_list_of_vat_register = ['yes', 'no'];

  TextEditingController bank_beneficiary_name = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  TextEditingController bank_IBAN = TextEditingController();
  TextEditingController document_issue_data = TextEditingController();
  TextEditingController document_expiry_data = TextEditingController();
  String bank_city = '';
  TextEditingController bank_account_number = TextEditingController();
  TextEditingController bank_swift_code = TextEditingController();
  TextEditingController bank_currncy = TextEditingController();
  TextEditingController bank_payment_mode =
      TextEditingController(text: 'Bank Transfer');

  final ImagePicker _picker = ImagePicker();
  XFile? document_liceince_image;
  Future get_document_liceince_image() async {
    document_liceince_image =
        await _picker.pickImage(source: ImageSource.gallery);
  }

  XFile? document_liceince_vat_image;
  Future get_document_liceince_vat_image() async {
    document_liceince_vat_image =
        await _picker.pickImage(source: ImageSource.gallery);
  }

  XFile? generat_id_card;
  Future get_generat_id_card() async {
    generat_id_card = await _picker.pickImage(source: ImageSource.gallery);
  }

  bool progress = false;
  updateUser(BuildContext context) async {
    update_status = true;
    formKey_licence.currentState!.validate();
    if (general_owner_name_Controller.text.isEmpty) {
      snackBarFailer('Owner name is missing'.tr);
    } else if (general_owner_email_Controller.text.isEmpty) {
      snackBarFailer('Owner email is missing'.tr);
    } else if (general_owner_moblie_Controller.text.isEmpty) {
      snackBarFailer('Owner mobile is missing'.tr);
    } else if (general_owner_adress_Controller.text.isEmpty) {
      snackBarFailer('Owner address is missing'.tr);
    } else if (store_name_Controller.text.isEmpty) {
      snackBarFailer('Store name is missing'.tr);
    } else if (bank_account_number.text.isEmpty) {
      snackBarFailer('Bank account number is missing'.tr);
    } else if (general_owner_type.isEmpty) {
      snackBarFailer('Owner type is missing'.tr);
    } else if (general_issue_date.text.isEmpty) {
      snackBarFailer('Issue date is missing'.tr);
    } else if (general_exp_date.text.isEmpty) {
      snackBarFailer('Expiry date is missing'.tr);
    } else if (store_adress_Controller.text.isEmpty) {
      snackBarFailer('Store address is missing'.tr);
    } else if (store_pickup_adress_Controller.text.isEmpty) {
      snackBarFailer('Pickup address is missing'.tr);
    } else if (document_liceince_no.text.isEmpty) {
      snackBarFailer('Document licence number is missing'.tr);
    } else if (document_issue_data.text.isEmpty) {
      snackBarFailer('Document issue date is missing'.tr);
    } else if (document_expiry_data.text.isEmpty) {
      snackBarFailer('Document expiry date is missing'.tr);
    } else if (document_vat_register.isEmpty) {
      snackBarFailer('Document vat register is missing'.tr);
    } else if (document_vat_no.text.isEmpty) {
      snackBarFailer('Document vat number is missing'.tr);
    } else if (bank_beneficiary_name.text.isEmpty) {
      snackBarFailer('Bank beneficiary name is missing'.tr);
    } else if (bank_IBAN.text.isEmpty) {
      snackBarFailer('Bank IBAN is missing'.tr);
    } else if (bank_swift_code.text.isEmpty) {
      snackBarFailer('Bank swift code is missing'.tr);
    } else {
      if (formKey_general.currentState!.validate() &&
          formKey_bank.currentState!.validate() &&
          formKey_shop.currentState!.validate() &&
          formKey_licence.currentState!.validate()) {
        progress = true;
        notifyListeners();
        List list_of_warehouse_name = [];
        List list_of_warehouse_address = [];
        List list_of_warehouse_states = [];
        List list_of_warehouse_cities = [];
        List list_of_warehouse_country = [];
        List list_of_warehouse_contact = [];
        List list_of_warehouse_google_location = [];

        list_of_ware_house_data.forEach((element) {
          list_of_warehouse_name.add(element.ware_house_name);
          list_of_warehouse_address.add(element.ware_house_address);
          list_of_warehouse_states.add(element.ware_house_state);
          list_of_warehouse_cities.add(element.ware_house_city);
          list_of_warehouse_country.add('UAE');
          list_of_warehouse_google_location
              .add(element.ware_house_google_location);
          list_of_warehouse_contact.add(element.ware_house_contact);
        });

        Map<String, dynamic> map = {
          'shop_name': '${store_name_Controller.text}',
          'shop_phone': '${store_phone_Controller.text}',
          'shop_address': '${store_adress_Controller.text}',
          'shop_country': 'UAE',
          'shop_state': '${store_selected_state}',
          'shop_city': '${store_selected_city}',
          'shop_google_location': '${store_google_location_address}',
          'owner_name': '${general_owner_name_Controller.text}',
          'owner_address': '${general_owner_adress_Controller.text}',
          'owner_country': 'UAE',
          'owner_state': '${owner_selected_state}',
          'owner_city': '${owner_selected_city}',
          'owner_mobile': '${general_owner_moblie_Controller.text}',
          'owner_email': '${general_owner_email_Controller.text}',
          'owner_type': '${general_owner_type}',
          'owner_id_type': '${general_owner_id_type}',
          'id_issue_date': '${general_issue_date.text}',
          'id_expiry_date': '${general_exp_date.text}',
          'warehouse_name[]': list_of_warehouse_name,
          'warehouse_address[]': list_of_warehouse_address,
          'warehouse_country[]': list_of_warehouse_country,
          'warehouse_state[]': list_of_warehouse_states,
          'warehouse_city[]': list_of_warehouse_cities,
          'warehouse_contact[]': list_of_warehouse_contact,
          'warehouse_google_Location[]': list_of_warehouse_google_location,
          'license_no': '${document_liceince_no.text}',
          'issue_date': '${document_issue_data.text}',
          'expiry_date': '${document_expiry_data.text}',
          'issue_authority': 'Dubai Chamber of Commerce and Industry',
          'license_activity': document_licence_activity.text,
          'vat_no': '${document_vat_no.text}',
          'beneficiary_name': "${bank_beneficiary_name.text}",
          'bank_name': "${bank_name.text}",
          'branch_city': '${store_bank_city}',
          'IBAN': '${bank_IBAN.text}',
          'account_no': '${bank_account_number.text}',
          'currency': 'AED',
          'payment_mode': 'Bank Transfer',
          'vat_registered': '${document_vat_register}',
          'seller_id': user_model.user!.id.toString(),
          'shop_id': user_model.user!.shopId.toString(),
          'swift_code': bank_swift_code.text,
          'owner_id_proof': await dio.MultipartFile.fromFile(
            generat_id_card!.path,
            filename: '${generat_id_card!.name}',
          ),
          'img_license': await dio.MultipartFile.fromFile(
            document_liceince_image!.path,
            filename: '${document_liceince_image!.name}',
          ),
          'img_vat': await dio.MultipartFile.fromFile(
            document_liceince_vat_image!.path,
            filename: '${document_liceince_vat_image!.name}',
          ),
        };
        if (generat_id_card == null) {
          map.remove('national_identity_card');
        }
        if (document_liceince_image == null) {
          map.remove('upload_license');
        }
        if (document_liceince_vat_image == null) {
          map.remove('upload_vat');
        }
        log('${map}');
        dio.FormData mapData = dio.FormData.fromMap(map);
        bool v = await DataProvider.update_user_api(mapObject: mapData);
        progress = false;
        if (v) {
          await DataProvider().loginFunction(
              Email: user_model.user!.email,
              Password: storage.read('user_password'));
          Get.offAll(BottomSheetCustom());
        }
        notifyListeners();
      } else {
        snackBarFailer(
            'Something is missing,check your provided information in the tabs'
                .tr);
      }
    }
  }

  String? generat_id_card_path = '';
  String? document_liceince_image_path = '';
  String? document_liceince_vat_image_path = '';
  LicenseAuthorityModel licience_model = LicenseAuthorityModel();

  List listOfCites = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Fujairah',
    'Ras Al Khaimah',
    'Al Ain',
    'Al Ruwais',
    'Ghayathi',
    'Madinat Zayed Al Dhafrah'
  ];

  City? allCites;
  States? allStates;
  City? owner_allCites;
  String owner_selected_city = '';
  String owner_selected_state = '';
  City? store_allCites;
  String store_selected_city = '';
  String store_selected_state = '';
  String store_bank_city = '';

  Future get_all_owner_cites(String? id) async {
    owner_allCites = await DataProvider.get_cites_by_state(id: id);
  }

  Future get_all_store_cites(String? id) async {
    store_allCites = await DataProvider.get_cites_by_state(id: id);
  }

  Future get_all_cites() async {
    allCites = await DataProvider.get_all_cites();
  }

  Future get_all_states() async {
    allStates = await DataProvider().get_all_states();
  }

  IssueAuthority issue_authority = IssueAuthority();
  issue_auth.Data? selected_issue_authority;
  Future get_issue_authority() async {
    issue_authority = await DataProvider.get_issue_authority();
  }

  List<WareHouse> list_of_ware_house_data = [
    WareHouse(
        ware_house_address: '',
        ware_house_contact: '',
        ware_house_email: '',
        ware_house_name: '',
        ware_house_google_location: '',
        ware_house_city: 'Abu Dhabi',
        ware_house_country: 'Abu Dhabi',
        ware_house_state: 'Abu Dhabi')
  ];

  ShopDetails shopDetails = ShopDetails();
  get_shop_details() async {
    shopDetails = await DataProvider.get_shop_details();
  }

  clearData() {
    print('call');
    owner_allCites = null;
    owner_selected_city = '';
    owner_selected_state = '';
    store_allCites = null;
    store_selected_city = '';
    store_selected_state = '';
    store_bank_city = '';
    update_status = false;
  }
}
