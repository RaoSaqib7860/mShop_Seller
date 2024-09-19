import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as dt;
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../providers/profile_provider.dart';
import '../../global_widgets/drop_down_2_custom.dart';
import '../../global_widgets/text_field.dart';

class GeneralPage extends StatefulWidget {
  final bool? display_data;
  const GeneralPage({Key? key, this.display_data = true}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProfileProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: VisibilityDetector(
        key: Key('shop-key'),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage > 80.0 && controller.update_status) {
            controller.formKey_general.currentState!.validate();
          }
        },
        child: Form(
          key: controller.formKey_general,
          child: Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFields(
                      controller: controller.general_owner_name_Controller,
                      labelText: 'Owner Name'.tr,
                      enable: true,
                      onchaged: (v) {
                        controller.formKey_general.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Owner name is empty'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFields(
                      controller: controller.general_owner_adress_Controller,
                      labelText: 'Owner Address'.tr,
                      onchaged: (v) {
                        controller.formKey_general.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Owner address is empty'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFields(
                      controller: controller.general_owner_moblie_Controller,
                      labelText: 'Owner Mobile (xx xxx xxxx)'.tr,
                      enable: true,
                      onchaged: (v) {
                        controller.formKey_general.currentState!.validate();
                      },
                      keyboredType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Owner mobile is empty'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFields(
                      controller: controller.general_owner_email_Controller,
                      labelText: 'Owner Email'.tr,
                      onchaged: (v) {
                        controller.formKey_general.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Owner email is empty'.tr;
                        } else {
                          return null;
                        }
                      },
                      enable: false,
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
                            child: Text('Owner State'.tr,
                                style: TextStyle(fontSize: 10)),
                          ),
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 0.7))),
                            child: Builder(builder: (context) {
                              List<String>? items = [];
                              controller.allStates!.data!.forEach((element) {
                                items.add(element.name!);
                              });
                              return CustomDropDown2(
                                initial_value: controller.owner_selected_state,
                                list_items: items,
                                selected_index: (selected_index) async {
                                  controller.owner_selected_state =
                                      items[selected_index];
                                  setState(() {});
                                  await controller.get_all_owner_cites(
                                      controller
                                          .allStates!.data![selected_index].id
                                          .toString());
                                  setState(() {});
                                },
                                hint: 'Owner State',
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    if (controller.update_status &&
                        controller.owner_selected_state.isEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              'Owner State is empty',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    if (controller.owner_selected_state.isNotEmpty &&
                        controller.owner_allCites != null)
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text('Owner City'.tr,
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
                                controller.owner_allCites!.data!
                                    .forEach((element) {
                                  items.add(element.name!);
                                });
                                return CustomDropDown2(
                                  initial_value: controller.owner_selected_city,
                                  list_items: items,
                                  selected_index: (selected_index) {
                                    controller.owner_selected_city =
                                        items[selected_index];
                                    setState(() {});
                                  },
                                  hint: 'Owner City',
                                );
                              }),
                            ),
                            if (controller.update_status &&
                                controller.owner_selected_city.isEmpty)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Owner City is empty',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Owner Type'.tr,
                                    style: TextStyle(fontSize: 10))
                                .translate(),
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
                                        padding: const EdgeInsets.only(left: 5),
                                        child:
                                            Text(controller.general_owner_type),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  )
                                : CustomDropDown2(
                                    initial_value:
                                        controller.general_owner_type,
                                    list_items: controller
                                        .general_dropDown_owner_type_list,
                                    selected_index: (selected_index) {
                                      controller.general_owner_type = controller
                                              .general_dropDown_owner_type_list[
                                          selected_index];
                                      setState(() {});
                                    },
                                    hint: 'Owner type',
                                  ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.update_status &&
                        controller.general_owner_type.isEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              'Owner Type is empty',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('ID Proof'.tr,
                                style: TextStyle(fontSize: 10)),
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
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                            controller.general_owner_id_type),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  )
                                : CustomDropDown2(
                                    initial_value:
                                        controller.general_owner_id_type,
                                    list_items: controller
                                        .general_dropDown_owner_id_type_list,
                                    selected_index: (selected_index) {
                                      controller
                                          .general_owner_id_type = controller
                                              .general_dropDown_owner_id_type_list[
                                          selected_index];
                                      setState(() {});
                                    },
                                    hint: 'ID Proof',
                                  ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.update_status &&
                        controller.general_owner_id_type.isEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              'Owner Type is empty',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        // dt.DatePicker.showDatePicker(context,
                        //     showTitleActions: true,
                        //     minTime: DateTime(2010, 3, 5),
                        //     onConfirm: (date) {
                        //       controller.general_issue_date.text =
                        //           date.toIso8601String();
                        //       controller.updateUI();
                        //     },
                        //     maxTime: DateTime(2070, 3, 5),
                        //     onChanged: (date) {
                        //       controller.general_issue_date.text =
                        //           date.toIso8601String();
                        //       controller.updateUI();
                        //     },
                        //     currentTime: DateTime.now(),
                        //     locale: dt.LocaleType.en);
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child: CustomTextFields(
                          controller: controller.general_issue_date,
                          labelText: 'ID Issue Date'.tr,
                          onchaged: (v) {
                            controller.formKey_general.currentState!.validate();
                          },
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
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        // dt.DatePicker.showDatePicker(context,
                        //     showTitleActions: true,
                        //     onConfirm: (date) {
                        //       controller.general_exp_date.text =
                        //           date.toIso8601String();
                        //       controller.updateUI();
                        //     },
                        //     minTime: DateTime(2010, 3, 5),
                        //     maxTime: DateTime(2070, 3, 5),
                        //     onChanged: (date) {
                        //       controller.general_exp_date.text =
                        //           date.toIso8601String();
                        //       controller.updateUI();
                        //     },
                        //     currentTime: DateTime.now(),
                        //     locale: dt.LocaleType.en);
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child: CustomTextFields(
                          controller: controller.general_exp_date,
                          labelText: 'ID Expiry Date'.tr,
                          onchaged: (v) {
                            controller.formKey_general.currentState!.validate();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'ID Expiry Date is empty'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text('ID Proof'.tr).translate(),
                              SizedBox(width: 10),
                              Visibility(
                                visible: !widget.display_data!,
                                child: InkWell(
                                  onTap: () async {
                                    await controller.get_generat_id_card();
                                    controller.updateUI();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    child:
                                        Center(child: Icon(Icons.upload_file)),
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100]!
                                            .withOpacity(0.5)
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5)),
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
                              SizedBox(width: 15),
                              if (controller.generat_id_card != null)
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.file(
                                            File(controller
                                                .generat_id_card!.path),
                                            fit: BoxFit.cover),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.blueGrey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: InkWell(
                                          child: Icon(Icons.cancel),
                                          onTap: () {
                                            controller.generat_id_card = null;
                                            setState(() {});
                                          }),
                                      top: 3,
                                      right: 3,
                                    )
                                  ],
                                ),
                              if (controller.generat_id_card_path!
                                      .trim()
                                      .isNotEmpty &&
                                  controller.generat_id_card == null)
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
                                        id: controller.generat_id_card_path),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
