import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/model/verification_page/city.dart' as city_model_is;
import 'package:mShop_Seller/view/screens/WareHouse%20List/Add%20WareHouse/repository.dart';

import '../../../../api_repo/api_utils.dart';
import '../../../../extentions/app_colors.dart';
import '../../../../model/verification_page/states.dart' as state_model_is;
import '../../../../utils_services/GooogleMapSearchAddress.dart';
import '../../../../utils_services/app_font.dart';
import '../../../global_widgets/AppSize.dart';
import '../../../global_widgets/Sackbars.dart';
import '../../../global_widgets/custom_dropdown.dart';
import '../../../global_widgets/text_field.dart';

class AddWareHouse extends StatefulWidget {
  String? tag;
  int? id;
  String? name;
  String? address;
  String? state;
  String? city;
  String? contact;
  String? location;
  AddWareHouse(
      {Key? key,
      this.tag,
      this.name,
      this.state,
      this.address,
      this.location,
      this.city,
      this.contact,
      this.id})
      : super(key: key);

  @override
  State<AddWareHouse> createState() => _AddWareHouseState();
}

class _AddWareHouseState extends State<AddWareHouse>
    with addWarehouseRepository {
  final validatorformKey = GlobalKey<FormState>();
  bool loader = false;
  late final List<String> items = [
    'Item1'.tr,
    'Item2'.tr,
    'Item3'.tr,
    'Item4'.tr,
    'Item5'.tr,
    'Item6'.tr,
    'Item7'.tr,
    'Item8'.tr,
  ];
  String? selectedValue;
  @override
  void initState() {
    apiFunction();
    if (widget.tag == 'update') {
      nameController.text = widget.name ?? '';
      addressController.text = widget.address.toString() ?? '';
      contactController.text = widget.contact ?? '';
      val = widget.state ?? '';
      store_google_location_address = widget.location ?? '';
      owner_selected_city = widget.city ?? 'flat'.tr;
    }
    super.initState();
  }

  apiFunction() async {
    await get_states_list().then((value) {
      setState(() {});
    });
  }

  state_model_is.Data? selectData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(CupertinoIcons.back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                size: 30)),
        title: Text(
          widget.tag == 'update' ? 'Update WareHouse' : 'Add new WareHouses'.tr,
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ).translate(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: validatorformKey,
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    child: Column(
                      children: [
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
                          controller: addressController,
                          labelText: 'Address'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the address '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        if (statesModelClass != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26,
                                              width: 0.7))),
                                  child: Center(
                                    child: CustomDropdownButton2(
                                      buttonDecoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      //buttonPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 0),
                                      dropdownWidth: 95.w,
                                      buttonWidth: 100.w,
                                      offset: Offset(0, -10),
                                      hint: val != null
                                          ? '${val}'
                                          : 'Select State',
                                      dropdownItems: statesModelClass!.data!
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.name,
                                                child: Text('${item.name}')
                                                    .translate(),
                                              ))
                                          .toList(),
                                      // value: selectedValue,
                                      onChanged: (data) async {
                                        int index = statesModelClass!.data!
                                            .indexWhere((element) =>
                                                element.name == data);
                                        state_model_is.Data v =
                                            statesModelClass!.data![index];
                                        val = v.name!;
                                        setState(() {});
                                        await get_city_by_cites(
                                            v.id.toString());
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 2.h,
                        ),
                        if (owner_allCites != null)
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26,
                                              width: 0.7))),
                                  child: Center(
                                    child: CustomDropdownButton2(
                                      buttonDecoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white)),
                                      dropdownWidth: 95.w,
                                      offset: Offset(0, -10),
                                      buttonWidth: 100.w,
                                      hint: owner_selected_city.isNotEmpty
                                          ? '${owner_selected_city}'
                                          : 'Select City',
                                      dropdownItems:
                                          owner_allCites!.data!.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: Text('${value.name}'),
                                        );
                                      }).toList(),
                                      onChanged: (data) async {
                                        int index = owner_allCites!.data!
                                            .indexWhere((element) =>
                                                element.name == data);
                                        city_model_is.Data v =
                                            owner_allCites!.data![index];
                                        owner_selected_city = v.name!;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        CustomTextFields(
                          controller: contactController,
                          prefixIcon: Row(children: [
                            Text('+971'),
                            SizedBox(width: 5),
                          ], mainAxisSize: MainAxisSize.min),
                          labelText: '5X XXX XXXX'.tr,
                          keyboredType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the Enter contact '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        InkWell(
                          onTap: () async {
                            print('hjdsjhjsdjsdhjd');
                            LocationPermission permission =
                                await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied ||
                                permission ==
                                    LocationPermission.deniedForever) {
                              snackBarFailer('Kindly enable Location'.tr);
                              await Geolocator.requestPermission();
                            } else {
                              await getLocation();
                              await openGoogleDailog(
                                  context: context,
                                  address: (v) {
                                    store_google_location_address = v!;
                                    print('address=$v');
                                    setState(() {});
                                  },
                                  latitude: (v) {
                                    store_location_lat = v!;
                                    print('address=$v');
                                  },
                                  longitude: (v) {
                                    store_location_lng = v!;
                                    print('address=$v');
                                  });
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              height: 5.5.h,
                              width: width,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 0.7))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store_google_location_address.isEmpty
                                        ? 'Google Location'.tr
                                        : store_google_location_address,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0.h,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (validatorformKey.currentState!.validate()) {
                        if (nameController != null &&
                            addressController != null &&
                            val != null &&
                            owner_selected_city != null &&
                            contactController != null &&
                            store_google_location_address != null) {
                          // loader = true;
                          // setState(() {});
                          if (widget.tag != 'update') {
                            bool result = await DataProvider()
                                .addNewWareHouseFunction(map: {
                              'warehouse_name': '${nameController.text}',
                              'warehouse_address': '${addressController.text}',
                              'warehouse_country': 'UAE',
                              'warehouse_state': '${val}',
                              'warehouse_city': '${owner_selected_city}',
                              'warehouse_contact': '${contactController.text}',
                              'warehouse_google_Location':
                                  '${store_google_location_address}',
                            });
                            if (result == true) {
                              Navigator.of(context).pop('add');
                            }
                          } else {
                            bool result = await DataProvider()
                                .updateWareHouseFunction(map: {
                              'warehouse_id': '${widget.id.toString()}',
                              'warehouse_name': '${nameController.text}',
                              'warehouse_address': '${addressController.text}',
                              'warehouse_country': 'UAE',
                              'warehouse_state': '${val}',
                              'warehouse_city': '${owner_selected_city}',
                              'warehouse_contact': '${contactController.text}',
                              'warehouse_google_Location':
                                  '${store_google_location_address}',
                            });
                            if (result == true) {
                              Navigator.of(context).pop('update');
                            }
                          }
                          // loader = false;
                          // setState(() {});
                          // Navigator.of(context).pop();
                        } else {
                          snackBarFailer('All field must be filled'.tr);
                        }
                      } else {
                        snackBarFailer('All field must be filled'.tr);
                      }
                    },
                    child: Container(
                      height: 6.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.blueGrey.shade50
                            : AppColors.blackColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400.withOpacity(0.5),
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(
                        widget.tag != 'update' ? 'Add' : 'Update',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : AppColors.whiteColor,
                            fontSize: 20),
                      ).translate()),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Processing',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    contactController.dispose();
    stateController.dispose();
    locationController.dispose();
  }

}
