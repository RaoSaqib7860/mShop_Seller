import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';

import '../../../../extentions/app_colors.dart';
import '../../../../utils_services/Loader.dart';
import '../../../../utils_services/colors_util.dart';
import '../../../../view_model/delivery_bloc/delivery_boy_repository.dart';
import '../../../global_widgets/Sackbars.dart';
import '../../../global_widgets/drop_down_2_custom.dart';
import '../../../global_widgets/text_field.dart';

class AddDeliveryBoyScreen extends StatefulWidget {
  String? tag;
  int? Id;
  String? name;
  String? email;
  String? phoneNo;
  String? nationality;
  String? warehouseName;
  String? emiratesId;
  String? emiratesExpiryDate;
  String? emiratesImage;
  String? passportId;
  String? passportExpiryDate;
  String? passportImage;
  String? visaId;
  String? visaExpiryDate;
  File? visaImage;
  String? licenseId;
  String? licenseExpiryDate;
  File? licenseImage;

  AddDeliveryBoyScreen(
      {Key? key,
      this.tag,
      this.licenseExpiryDate,
      this.licenseId,
      this.licenseImage,
      this.visaExpiryDate,
      this.Id,
      this.visaId,
      this.visaImage,
      this.passportExpiryDate,
      this.passportId,
      this.passportImage,
      this.emiratesId,
      this.emiratesImage,
      this.emiratesExpiryDate,
      this.warehouseName,
      this.name,
      this.email,
      this.nationality,
      this.phoneNo})
      : super(key: key);

  @override
  State<AddDeliveryBoyScreen> createState() => _AddDeliveryBoyScreenState();
}

class _AddDeliveryBoyScreenState extends State<AddDeliveryBoyScreen>
    with DeliveryBoy {
  final TextEditingController _controller = new TextEditingController();
  final validatorformKey = GlobalKey<FormState>();
  var items = [
    'Working a lot harder'.tr,
    'Being a lot smarter'.tr,
    'Being a self-starter'.tr,
    'Placed in charge of trading charter'.tr
  ];
  File? _image;
  File? visaImage;
  File? licenseImage;
  final picker = ImagePicker();
  final visapicker = ImagePicker();
  final licensepicker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getVisaImageFromGallery() async {
    final pickedFile = await visapicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        visaImage = File(pickedFile.path);
      }
    });
  }

  Future getLicenseImageFromGallery() async {
    final pickedFile = await licensepicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        licenseImage = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    get_where_house_list().then((value) {
      setState(() {});
    });
    if (widget.tag == 'update') {
      nameController.text = widget.name ?? '';
      emailController.text = widget.email ?? '';
      mobileController.text = widget.phoneNo ?? '';
      eIdController.text = widget.emiratesId ?? '';
      dateInput.text = widget.emiratesExpiryDate ?? '';
      visaNoController.text = widget.visaId ?? '';
      visaExpiryDate.text = widget.visaExpiryDate ?? '';
      passportController.text = widget.passportId ?? '';
      licenseController.text = widget.licenseId ?? '';
      passportExpiryDate.text = widget.passportExpiryDate ?? '';
      licenceExpiryDate.text = widget.licenseExpiryDate ?? '';
      countoryController = widget.nationality ?? '';
      // _image = widget.emiratesImage;
      // visaImage = widget.visaImage;
      // licenseImage = widget.licenseImage;
    }
    super.initState();
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.whiteColor,
                size: 30)),
        title: Text('Add Delivery Boy',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.whiteColor,
                fontSize: 16)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: validatorformKey,
              child: Column(
                children: [
                  Container(
                    //height: 54.h,
                    width: 100.w,
                    //color: Colors.green,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 12),
                              child: Text('Delivery Boy Details',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : AppColors.whiteColor,
                                  )),
                            )),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: nameController,
                          labelText: 'Name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the name '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: emailController,
                          labelText: 'Email'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the email '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: mobileController,
                          labelText: 'Mobile Number'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the Mobile No '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 6.h,
                            //width: 88.w,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 0.7))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    countoryController == null
                                        ? 'Select Nationality'
                                        : '${countoryController}',
                                  ),
                                  Container(
                                    height: 6.h,
                                    //width: 30.w,
                                    //color: Colors.deepPurple,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CountryCodePicker(
                                            backgroundColor: Colors.red,
                                            enabled: true,
                                            padding: EdgeInsets.zero,
                                            // dialogSize: Size.zero,

                                            onChanged: (v) {
                                              countoryController = v.name;
                                              setState(() {});
                                            },
                                            // closeIcon: Icon(Icons.add),
                                            initialSelection: 'ar',
                                            // favorite: ['+39','FR'],
                                            showCountryOnly: true,
                                            showFlag: false,
                                            showOnlyCountryWhenClosed: true,
                                            alignLeft: false,
                                          ),
                                          Icon(Icons.arrow_drop_down_rounded)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 6.h,
                            //width: 88.w,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 0.7))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  wearHouseList == null
                                      ? SizedBox()
                                      : Expanded(
                                          child: Builder(builder: (context) {
                                            List<String>? items = [];
                                            wearHouseList!.data!
                                                .forEach((element) {
                                              items.add(element.warehouseName!);
                                            });
                                            return CustomDropDown2(
                                              initial_value:
                                                  list_of_selected_wearhouse
                                                          .isEmpty
                                                      ? ''
                                                      : list_of_selected_wearhouse
                                                          .last.warehouseName,
                                              list_items: items,
                                              selected_index: (selected_index) {
                                                if (!list_of_selected_wearhouse
                                                    .contains(
                                                        wearHouseList!.data![
                                                            selected_index])) {
                                                  list_of_selected_wearhouse
                                                      .add(wearHouseList!.data![
                                                          selected_index]);
                                                  setState(() {});
                                                }
                                              },
                                              hint: 'Select Warehouses',
                                            );
                                          }),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (list_of_selected_wearhouse.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: 100.h,
                              height: 55,
                              child: ListView(
                                children: list_of_selected_wearhouse
                                    .map((e) => Chip(
                                          label: Text('${e.warehouseName}'),
                                          onDeleted: () {
                                            list_of_selected_wearhouse
                                                .remove(e);
                                            setState(() {});
                                          },
                                        ))
                                    .toList(),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    //height: 108.h,
                    width: 100.w,
                    //color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 12),
                          child: Text('Verifications',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : AppColors.whiteColor,
                              )),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 12),
                              child: Text('Emirates',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                            )),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: eIdController,
                          labelText: 'ID No'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the emirates id no '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          //controller: emailController,
                          labelText: 'Expiry Date'.tr,
                          controller: dateInput,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please select the expiry date '.tr;
                            } else {
                              return null;
                            }
                          },
                          readOnly: true,
                          suffixIcon: InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                              child: Icon(Icons.calendar_today)),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 6.h,
                            // width: 88.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xffffffff)
                                  : Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  //color: const Color(0x290bab0d),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _image == null
                                      ? Text('Upload Emirates Image')
                                      : Container(
                                          width: 68.w,
                                          child: Text(
                                            '${_image}',
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                  InkWell(
                                      onTap: () async {
                                        await getImageFromGallery();
                                      },
                                      child: Icon(Icons.image,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomTextFields(
                        //   //controller: emailController,
                        //   // validator: (value) {
                        //   //   if (value!.isEmpty) {
                        //   //     return 'please select image '.tr;
                        //   //   } else {
                        //   //     return null;
                        //   //   }
                        //   // },
                        //   readOnly: true,
                        //   labelText: _image == null
                        //       ? 'Upload Emirates Image'.tr
                        //       : '${_image}',
                        //   suffixIcon: InkWell(
                        //       onTap: () async {
                        //         await getImageFromGallery();
                        //       },
                        //       child: Icon(Icons.image, color: Colors.grey)),
                        // ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 12),
                              child: Text('Visa',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                            )),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: visaNoController,
                          labelText: 'Visa No.'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the visa no '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          //controller: emailController,
                          labelText: 'Visa Expiry Date'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please select the visa expiry date '.tr;
                            } else {
                              return null;
                            }
                          },
                          controller: visaExpiryDate,
                          readOnly: true,
                          suffixIcon: InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    visaExpiryDate.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                              child: Icon(Icons.calendar_today)),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 6.h,
                            // width: 88.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xffffffff)
                                  : Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  //color: const Color(0x290bab0d),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  visaImage == null
                                      ? Text('Upload Visa Image')
                                      : Container(
                                          width: 68.w,
                                          child: Text(
                                            '${visaImage}',
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                  InkWell(
                                      onTap: () async {
                                        await getVisaImageFromGallery();
                                      },
                                      child: Icon(Icons.image,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomTextFields(
                        //   //controller: emailController,
                        //   // validator: (value) {
                        //   //   if (value!.isEmpty) {
                        //   //     return 'please upload visa image'.tr;
                        //   //   } else {
                        //   //     return null;
                        //   //   }
                        //   // },
                        //   labelText: visaImage == null
                        //       ? 'Upload Visa'.tr
                        //       : '${visaImage}',
                        //   suffixIcon: InkWell(
                        //       onTap: () async {
                        //         await getVisaImageFromGallery();
                        //       },
                        //       child: Icon(Icons.image, color: Colors.grey)),
                        // ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 12),
                              child: Text('Passport',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                            )),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: passportController,
                          labelText: 'Passport No.'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the passport no '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          //controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please select the passport expiry date '
                                  .tr
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          labelText: 'Passport Expiry Date'.tr,
                          controller: passportExpiryDate,
                          readOnly: true,
                          suffixIcon: InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    passportExpiryDate.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                              child: Icon(Icons.calendar_today)),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 12),
                              child: Text('Driving License',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                            )),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: licenseController,
                          labelText: 'License No.'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the license no '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: licenceExpiryDate,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please select the licence expiry data'.tr;
                            } else {
                              return null;
                            }
                          },
                          labelText: 'License Expiry Date'.tr,
                          readOnly: true,
                          suffixIcon: InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    licenceExpiryDate.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                              child: Icon(Icons.calendar_today)),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: 6.h,
                            // width: 88.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xffffffff)
                                  : Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  //color: const Color(0x290bab0d),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  licenseImage == null
                                      ? Text('Upload Visa Image')
                                      : Container(
                                          width: 68.w,
                                          child: Text(
                                            '${licenseImage}',
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                  InkWell(
                                      onTap: () async {
                                        await getLicenseImageFromGallery();
                                      },
                                      child: Icon(Icons.image,
                                          color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomTextFields(
                        //   //controller: emailController,
                        //   // validator: (value) {
                        //   //   if (value!.isEmpty) {
                        //   //     return 'please upload license image '.tr;
                        //   //   } else {
                        //   //     return null;
                        //   //   }
                        //   // },
                        //   labelText: licenseImage == null
                        //       ? 'Upload License'.tr
                        //       : '${licenseImage}',
                        //   suffixIcon: InkWell(
                        //       onTap: () async {
                        //         await getLicenseImageFromGallery();
                        //       },
                        //       child: Icon(Icons.image, color: Colors.grey)),
                        // ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if (widget.tag != 'update') {
                        if (validatorformKey.currentState!.validate()) {
                          if (_image != null &&
                              visaImage != null &&
                              licenseImage != null) {
                            print('object validation number');
                            List<String> ids = [];
                            list_of_selected_wearhouse.forEach((element) {
                              ids.add(element.id!.toString());
                            });
                            print('ids .....${ids}');
                            loader = true;
                            setState(() {});
                            await DataProvider().addDeliveryBoyFunction({
                              'name': '${nameController.text}',
                              'email': '${emailController.text}',
                              'user_type': 'delivery_boy',
                              'phone': '${mobileController.text}',
                              'added_by': 'seller',
                              'added_by_id': '${user_model.user!.id}',
                              'nationality': '${countoryController}',
                              'warehouse_ids[]': ids,
                              'emirates_id_no': '${eIdController.text}',
                              'emirates_id_expiry': '${dateInput.text}',
                              'visa_no': '${visaNoController.text}',
                              'visa_expiry': '${visaExpiryDate.text}',
                              'passport_expiry': '${passportExpiryDate.text}',
                              'license_no': '${licenseController.text}',
                              'license_expiry': '${licenceExpiryDate.text}',
                              'passport_no': '${passportController.text}',
                              'emirates_id': await dio.MultipartFile.fromFile(
                                  _image!.path),
                              'visa': await dio.MultipartFile.fromFile(
                                  visaImage!.path),
                              'license': await dio.MultipartFile.fromFile(
                                  licenseImage!.path),
                            });
                            loader = false;
                            setState(() {});
                            Navigator.of(context).pop('submit');
                          } else {
                            snackBarFailer('All field must be filled'.tr);
                          }
                        } else {
                          snackBarFailer('All field must be filled'.tr);
                        }
                      } else {
                        if (validatorformKey.currentState!.validate()) {
                          if (_image != null &&
                              visaImage != null &&
                              licenseImage != null) {
                            print('object validation number');
                            List<String> ids = [];
                            list_of_selected_wearhouse.forEach((element) {
                              ids.add(element.id.toString());
                            });

                            // loader = true;
                            // setState(() {});
                            await DataProvider().updateDeliveryBoy(map: {
                              'name': '${nameController.text}',
                              'email': '${emailController.text}',
                              'user_type': 'delivery_boy',
                              'phone': '${mobileController.text}',
                              'added_by': 'seller',
                              'user_id': '${widget.Id}',
                              'added_by_id': '${user_model.user!.id}',
                              'nationality': '${countoryController}',
                              'emirates_id_no': '${eIdController.text}',
                              'emirates_id_expiry': '${dateInput.text}',
                              'visa_no': '${visaNoController.text}',
                              'visa_expiry': '${visaExpiryDate.text}',
                              'passport_expiry': '${passportExpiryDate.text}',
                              'license_no': '${licenseController.text}',
                              'license_expiry': '${licenceExpiryDate.text}',
                              'passport_no': '${passportController.text}',
                              'warehouse_ids[]': ids,
                              // 'emirates_id':
                              // await dio.MultipartFile.fromFile(_image!.path),
                              // 'visa': await dio.MultipartFile.fromFile(
                              //     visaImage!.path),
                              // 'license': await dio.MultipartFile.fromFile(
                              //     licenseImage!.path),
                            });
                            loader = false;
                            setState(() {});
                            Navigator.of(context).pop('update');
                          } else {
                            snackBarFailer('All field must be filled'.tr);
                          }
                        } else {
                          snackBarFailer('All field must be filled'.tr);
                        }
                      }
                    },
                    child: Container(
                      height: 6.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? blueGrey
                            : AppColors.blackColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400.withOpacity(0.5),
                            //color: const Color(0x290bab0d),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(
                        widget.tag != 'update' ? 'Submit' : 'Update',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.whiteColor
                                    : AppColors.whiteColor,
                            fontSize: 20),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: loader,
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white.withOpacity(0.5),
              child: screenLoader(use_opacity: false),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    _controller.dispose();
    mobileController.dispose();
    dateInput.dispose();
    eIdController.dispose();
    imageController.dispose();
    licenceExpiryDate.dispose();
    licenseController.dispose();
    passportController.dispose();
    passportExpiryDate.dispose();
    visaExpiryDate.dispose();
    visaNoController.dispose();
  }
}
