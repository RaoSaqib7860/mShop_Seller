import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../providers/profile_provider.dart';
import '../../global_widgets/drop_down_2_custom.dart';
import '../../global_widgets/text_field.dart';

class BankPage extends StatefulWidget {
  final bool? display_data;
  const BankPage({Key? key, this.display_data}) : super(key: key);

  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProfileProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: VisibilityDetector(
        key: Key('bank-key'),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage > 80.0 && controller.update_status) {
            controller.formKey_bank.currentState!.validate();
          }
        },
        child: Form(
          key: controller.formKey_bank,
          child: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFields(
                    controller: controller.bank_beneficiary_name,
                    labelText: 'Beneficiary name'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Beneficiary name is empty'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFields(
                    controller: controller.bank_name,
                    labelText: 'Bank Name'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bank name is empty'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Branch City'.tr,
                              style: TextStyle(fontSize: 10)),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black26, width: 0.7))),
                          child: Builder(builder: (context) {
                            List<String>? items = [];
                            controller.allCites!.data!.forEach((element) {
                              items.add(element.name!);
                            });
                            return CustomDropDown2(
                              initial_value:
                                  items.contains(controller.store_bank_city)
                                      ? controller.store_bank_city
                                      : items[0],
                              list_items: items,
                              selected_index: (selected_index) async {
                                controller.store_bank_city =
                                    items[selected_index];
                                setState(() {});
                              },
                              hint: 'Owner City',
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  if (controller.update_status &&
                      controller.store_bank_city.isEmpty)
                    Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            'Shop city is empty',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFields(
                    controller: controller.bank_IBAN,
                    labelText: 'IBAN'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'IBAN is empty'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFields(
                    controller: controller.bank_account_number,
                    labelText: 'Account No'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Account no is empty'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFields(
                    controller: controller.bank_swift_code,
                    labelText: 'Swift Code'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Swift code is empty'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Currency'.tr, style: TextStyle(fontSize: 10)),
                  ),
                  CustomTextFields(
                    controller: controller.bank_currncy,
                    labelText: 'AED'.tr,
                    onchaged: (v) {
                      controller.formKey_bank.currentState!.validate();
                    },
                    enable: false,
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFields(
                      controller: controller.bank_payment_mode,
                      enable: false,
                      onchaged: (v) {
                        controller.formKey_bank.currentState!.validate();
                      },
                      labelText: 'Payment Mode'.tr),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
