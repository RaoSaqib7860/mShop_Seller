import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:mShop_Seller/utils_services/Loader.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/screens/profile/shop_page.dart';

import '../../../model/verification_page/ware_house_model.dart';
import '../../../providers/profile_provider.dart';
import '../../../utils_services/KeyboaredDismissPage.dart';
import '../../../utils_services/app_font.dart';
import '../../conectivity/connectivity.dart';
import '../LoginPages/login_screen.dart';
import 'bank_page.dart';
import 'general_page.dart';
import 'licence_page.dart';

class ProfileMainScreen extends StatefulWidget {
  final bool? verifiedUser;
  final bool? display_data;
  const ProfileMainScreen(
      {Key? key, this.verifiedUser = false, this.display_data = false})
      : super(key: key);

  @override
  _ProfileMainScreenState createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription? subscription;
  @override
  void initState() {
    final controller = Provider.of<ProfileProvider>(context, listen: false);
    controller.general_owner_name_Controller.text = user_model.user!.name ?? '';
    controller.general_owner_email_Controller.text =
        user_model.user!.email ?? '';
    controller.store_name_Controller.text = user_model.user!.shopName ?? '';
    get_api_data();
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            final controller = Provider.of<ProfileProvider>(context, listen: false);
            controller.general_owner_name_Controller.text = user_model.user!.name ?? '';
            controller.general_owner_email_Controller.text =
                user_model.user!.email ?? '';
            controller.store_name_Controller.text = user_model.user!.shopName ?? '';
            get_api_data();
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  bool load = true;

  get_api_data() async {
    var controller = Provider.of<ProfileProvider>(context, listen: false);
    await controller.get_all_states();
    await controller.get_all_cites();
    await controller.get_issue_authority();
    if (widget.display_data!) {
      await controller.get_shop_details();
      controller.general_owner_name_Controller.text =
          controller.shopDetails.shop!.ownerName ?? '';
      controller.general_owner_email_Controller.text =
          controller.shopDetails.shop!.ownerEmail ?? '';
      controller.store_name_Controller.text =
          controller.shopDetails.shop!.shopName ?? '';
      controller.general_owner_adress_Controller.text =
          controller.shopDetails.shop!.ownerAddress ?? '';
      controller.general_owner_moblie_Controller.text =
          controller.shopDetails.shop!.ownerMobile ?? '';
      controller.general_issue_date.text =
          controller.shopDetails.shop!.idIssueDate ?? '';
      controller.general_exp_date.text =
          controller.shopDetails.shop!.idExpiryDate ?? '';
      controller.general_owner_type =
          controller.shopDetails.shop!.ownerType ?? '';
      controller.general_owner_id_type =
          controller.shopDetails.shop!.ownerIdType ?? '';
      controller.store_adress_Controller.text =
          controller.shopDetails.shop!.shopAddress ?? '';
      controller.store_pickup_adress_Controller.text =
          controller.shopDetails.shop!.shopAddress ?? '';
      controller.store_google_location_address =
          controller.shopDetails.shop!.shopGoogleLocation ?? '';
      controller.store_selected_state =
          controller.shopDetails.shop!.shopState ?? '';
      controller.bank_beneficiary_name.text =
          controller.shopDetails.shop!.beneficiaryName ?? '';
      controller.store_bank_city =
          controller.shopDetails.shop!.branchCity ?? '';
      controller.bank_IBAN.text = controller.shopDetails.shop!.iBAN ?? '';
      controller.bank_currncy.text =
          controller.shopDetails.shop!.currency ?? '';
      controller.bank_name.text = controller.shopDetails.shop!.bankName ?? '';
      controller.bank_account_number.text =
          controller.shopDetails.shop!.accountNo ?? '';
      controller.bank_payment_mode.text = 'Bank Transfer'.tr;
      controller.bank_swift_code.text =
          controller.shopDetails.shop!.swiftCode ?? '';
      controller.document_liceince_no.text =
          controller.shopDetails.shop!.licenseNo ?? '';
      controller.document_vat_no.text =
          controller.shopDetails.shop!.vatNo ?? "";
      controller.store_phone_Controller.text =
          controller.shopDetails.shop!.shopPhone ?? "";
      controller.document_licence_activity.text =
          controller.shopDetails.shop!.licenseActivity ?? "";
      controller.document_issue_data.text =
          controller.shopDetails.shop!.issueDate ?? "";
      controller.document_expiry_data.text =
          controller.shopDetails.shop!.expiryDate ?? "";
      controller.owner_selected_state =
          controller.shopDetails.shop!.ownerState ?? 'Abu Dhabi'.tr;
      controller.owner_selected_city =
          controller.shopDetails.shop!.ownerCity ?? 'Abu Dhabi'.tr;
      controller.general_owner_type =
          controller.shopDetails.shop!.ownerType ?? 'UAE Citizen'.tr;
      controller.general_owner_id_type =
          controller.shopDetails.shop!.ownerIdType ?? 'Passport'.tr;
      controller.generat_id_card_path =
          controller.shopDetails.shop!.ownerIdProof;
      controller.document_liceince_vat_image_path =
          controller.shopDetails.shop!.imgVat;
      controller.document_liceince_image_path =
          controller.shopDetails.shop!.imgLicense;
      controller.document_vat_register =
          controller.shopDetails.shop!.vatRegistered == null ||
                  controller.shopDetails.shop!.vatRegistered!.isEmpty
              ? 'yes'.tr
              : controller.shopDetails.shop!.vatRegistered ?? 'yes'.tr;
      controller.list_of_ware_house_data = [];
      controller.shopDetails.warehouses!.forEach((element) {
        controller.list_of_ware_house_data.add(WareHouse(
            ware_house_state: element.warehouseState,
            ware_house_city: element.warehouseCity,
            ware_house_google_location: element.warehouseGoogleLocation,
            ware_house_name: element.warehouseName,
            ware_house_email: '',
            ware_house_contact: element.warehouseContact,
            ware_house_address: element.warehouseAddress,
            ware_house_country: element.warehouseCountry));
      });
    }
    load = false;
    setState(() {});
  }

  @override
  void deactivate() {
    final controller = Provider.of<ProfileProvider>(context, listen: false);
    controller.clearData();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return KeyBoardDismissPage(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            elevation: 0,
            centerTitle: false,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
                onPressed: () {
                  if (widget.verifiedUser!) {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      ModalRoute.withName('/'),
                    );
                  }
                }),
            title: Text(
              'Shop'.tr,
              style: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 17,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, v) {
              return [
                SliverPersistentHeader(
                    pinned: true, floating: true, delegate: MyTab())
              ];
            },
            floatHeaderSlivers: true,
            physics: NeverScrollableScrollPhysics(),
            body: TabBarView(
              children: [
                load
                    ? Center(
                        child: screenLoader(use_opacity: false),
                      )
                    : IgnorePointer(
                        child: GeneralPage(display_data: widget.display_data),
                        ignoring: widget.display_data ?? true),
                IgnorePointer(
                    child: StorePage(display_data: widget.display_data),
                    ignoring: widget.display_data ?? true),
                IgnorePointer(
                    child: BankPage(display_data: widget.display_data),
                    ignoring: widget.display_data ?? true),
                IgnorePointer(
                    child: LicencePage(display_data: widget.display_data),
                    ignoring: widget.display_data ?? true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTab extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double, bool) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      child: Column(
        children: [
          TabBar(labelPadding: EdgeInsets.zero, tabs: [
            Tab(
              child: Container(
                height: 20,
                width: 60,
                child: Center(
                  child: Text(
                    'General'.tr,
                    style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 20,
                  width: 65,
                  child: Center(
                    child: Text(
                      'Shop'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 12,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: 20,
                  width: 90,
                  child: Center(
                    child: Text(
                      'Bank'.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 12,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 20,
                width: 60,
                child: Center(
                  child: Text(
                    'License'.tr,
                    style: TextStyle(
                      fontFamily: AppFonts.segoeui,
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 75;
  @override
  double minExtent = 75;
}
