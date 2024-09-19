import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as dt;
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../api_repo/api_utils.dart';
import '../../../providers/profile_provider.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/colors_util.dart';
import '../../global_widgets/drop_down_2_custom.dart';
import '../../global_widgets/text_field.dart';

class LicencePage extends StatefulWidget {
  final bool? display_data;
  const LicencePage({Key? key, this.display_data}) : super(key: key);

  @override
  _LicencePageState createState() => _LicencePageState();
}

class _LicencePageState extends State<LicencePage> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProfileProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Form(
            key: controller.formKey_licence,
            child: VisibilityDetector(
              key: Key('licence-key'),
              onVisibilityChanged: (visibilityInfo) {
                var visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 80.0 && controller.update_status) {
                  controller.formKey_licence.currentState!.validate();
                }
              },
              child: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFields(
                        controller: controller.document_liceince_no,
                        labelText: 'License No'.tr,
                        onchaged: (v) {
                          controller.formKey_licence.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'License No is empty'.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Container(
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26, width: 0.7))),
                        child: Builder(builder: (context) {
                          List<String>? items = [];
                          controller.issue_authority.data!.forEach((element) {
                            items.add(element.name!);
                          });
                          return CustomDropDown2(
                            initial_value:
                                controller.selected_issue_authority == null
                                    ? ''
                                    : controller
                                            .selected_issue_authority!.name ??
                                        '',
                            list_items: items,
                            selected_index: (selected_index) {
                              controller.selected_issue_authority = controller
                                  .issue_authority.data![selected_index];
                              setState(() {});
                            },
                            hint: 'Issue Authority',
                          );
                        }),
                      ),
                      if (controller.update_status &&
                          controller.selected_issue_authority == null)
                        Column(
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'issue Authority is empty',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      CustomTextFields(
                        controller: controller.document_licence_activity,
                        labelText: 'License Activity'.tr,
                        onchaged: (v) {
                          controller.formKey_licence.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'License Activity is empty'.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      InkWell(
                        onTap: () {
                          // dt.DatePicker.showDatePicker(context,
                          //     showTitleActions: true,
                          //     minTime: DateTime(2010, 3, 5),
                          //     onConfirm: (date) {
                          //       controller.document_issue_data.text =
                          //           date.toIso8601String();
                          //       ;
                          //       controller.updateUI();
                          //     },
                          //     maxTime: DateTime(2070, 3, 5),
                          //     onChanged: (date) {
                          //       controller.document_issue_data.text =
                          //           date.toIso8601String();
                          //       controller.updateUI();
                          //     },
                          //     currentTime: DateTime.now(),
                          //     locale: dt.LocaleType.en);
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          child: CustomTextFields(
                            controller: controller.document_issue_data,
                            labelText: 'Issue Date'.tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Issue Date is empty'.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      InkWell(
                        onTap: () {
                          // dt.DatePicker.showDatePicker(context,
                          //     showTitleActions: true,
                          //     minTime: DateTime(2010, 3, 5),
                          //     onConfirm: (date) {
                          //       controller.document_expiry_data.text =
                          //           date.toIso8601String();
                          //       controller.updateUI();
                          //     },
                          //     maxTime: DateTime(2070, 3, 5),
                          //     onChanged: (date) {
                          //       controller.document_expiry_data.text =
                          //           date.toIso8601String();
                          //       controller.updateUI();
                          //     },
                          //     currentTime: DateTime.now(),
                          //     locale: dt.LocaleType.en);
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          child: CustomTextFields(
                            controller: controller.document_expiry_data,
                            labelText: 'Exp Date'.tr,
                            onchaged: (v) {
                              controller.formKey_licence.currentState!
                                  .validate();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Exp Date is empty'.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text('Vat Registered'.tr,
                                  style: TextStyle(fontSize: 12)),
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.7))),
                              child: widget.display_data!
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              controller.document_vat_register),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                      ],
                                    )
                                  : CustomDropDown2(
                                      initial_value:
                                          controller.document_vat_register,
                                      list_items: controller
                                          .document_list_of_vat_register,
                                      selected_index: (selected_index) {
                                        controller
                                            .document_vat_register = controller
                                                .document_list_of_vat_register[
                                            selected_index];
                                        setState(() {});
                                      },
                                      hint: 'Owner type',
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      CustomTextFields(
                        controller: controller.document_vat_no,
                        labelText: 'Vat No'.tr,
                        onchaged: (v) {
                          controller.formKey_licence.currentState!.validate();
                        },
                        validator: controller.document_vat_register == 'yes'
                            ? (value) {
                                if (value!.isEmpty) {
                                  return 'Exp Date is empty'.tr;
                                } else {
                                  return null;
                                }
                              }
                            : null,
                        enable: controller.document_vat_register == 'yes'
                            ? true
                            : false,
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 5),
                                Text('License image'.tr).translate(),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: !widget.display_data!,
                                  child: InkWell(
                                    onTap: () async {
                                      await controller
                                          .get_document_liceince_image();
                                      controller.updateUI();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Center(
                                          child: Icon(Icons.upload_file)),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[100]!
                                              .withOpacity(0.5)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                if (controller.document_liceince_image != null)
                                  InkWell(
                                    onTap: () {},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            child: Image.file(
                                                File(controller
                                                    .document_liceince_image!
                                                    .path),
                                                fit: BoxFit.cover),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: InkWell(
                                              child: Icon(Icons.cancel),
                                              onTap: () {
                                                controller
                                                        .document_liceince_image =
                                                    null;
                                                setState(() {});
                                              }),
                                          top: 3,
                                          right: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                if (controller.document_liceince_image_path!
                                        .isNotEmpty &&
                                    controller.document_liceince_image == null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FutureBuilder(
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                                '${snapshot.data}',
                                                fit: BoxFit.cover),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                      future: DataProvider.get_image_path_api(
                                          id: controller
                                              .document_liceince_image_path),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 5),
                                Text('VAT image'.tr).translate(),
                                SizedBox(width: 35),
                                Visibility(
                                  visible: !widget.display_data!,
                                  child: InkWell(
                                    onTap: () async {
                                      await controller
                                          .get_document_liceince_vat_image();
                                      controller.updateUI();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Center(
                                          child: Icon(Icons.upload_file)),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[100]!
                                              .withOpacity(0.5)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                if (controller.document_liceince_vat_image !=
                                    null)
                                  InkWell(
                                    onTap: () {},
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            child: Image.file(
                                                File(controller
                                                    .document_liceince_vat_image!
                                                    .path),
                                                fit: BoxFit.cover),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: InkWell(
                                              child: Icon(Icons.cancel),
                                              onTap: () {
                                                controller
                                                        .document_liceince_vat_image =
                                                    null;
                                                setState(() {});
                                              }),
                                          top: 3,
                                          right: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                if (controller.document_liceince_vat_image_path!
                                        .isNotEmpty &&
                                    controller.document_liceince_vat_image ==
                                        null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FutureBuilder(
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                                '${snapshot.data}',
                                                fit: BoxFit.cover),
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.5),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                      future: DataProvider.get_image_path_api(
                                          id: controller
                                              .document_liceince_vat_image_path),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Visibility(
                        visible: !widget.display_data!,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.updateUser(context);
                              },
                              child: Container(
                                height: height * 0.050,
                                width: width * 0.4,
                                child: Center(
                                    child: Text(
                                  'Update Profile'.tr,
                                  style: TextStyle(color: Colors.white),
                                ).translate()),
                                decoration: BoxDecoration(
                                    color: blueGrey,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          controller.progress
              ? screenLoader(onTap: () {
                  controller.progress = !controller.progress;
                  setState(() {});
                })
              : SizedBox()
        ],
      ),
    );
  }
}
