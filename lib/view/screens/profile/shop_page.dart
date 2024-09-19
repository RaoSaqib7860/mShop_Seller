import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/view/global_widgets/Sackbars.dart';
import 'package:mShop_Seller/view/global_widgets/text_field.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../model/verification_page/ware_house_model.dart';
import '../../../providers/profile_provider.dart';
import '../../../utils_services/GooogleMapSearchAddress.dart';
import '../../../utils_services/text_field_decorated.dart';
import '../../global_widgets/drop_down_2_custom.dart';

class StorePage extends StatefulWidget {
  final bool? display_data;
  const StorePage({Key? key, this.display_data}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  void parseCoordinates(String url) {
    final uri = Uri.parse(url);
    final queryParams = uri.queryParameters;

    if (queryParams.containsKey('q')) {
      final location = queryParams['q'];
      final coordinates = location?.split('@')[1].split(',');

      final latitude = coordinates?[0];
      final longitude = coordinates?[1];

      // Use latitude and longitude as needed
      print('Latitude: $latitude');
      print('Longitude: $longitude');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var controller = Provider.of<ProfileProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: VisibilityDetector(
          key: Key('licence-key'),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (visiblePercentage > 80.0 && controller.update_status) {
              controller.formKey_shop.currentState!.validate();
            }
          },
          child: Form(
            key: controller.formKey_shop,
            child: Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFields(
                      controller: controller.store_name_Controller,
                      labelText: 'Shop Name'.tr,
                      onchaged: (v) {
                        controller.formKey_shop.currentState!.validate();
                      },
                      enable: false,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    CustomTextFields(
                      controller: controller.store_adress_Controller,
                      labelText: 'Shop Address'.tr,
                      onchaged: (v) {
                        controller.formKey_shop.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Shop Address is empty'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFields(
                      controller: controller.store_phone_Controller,
                      labelText: 'Shop Phone'.tr,
                      onchaged: (v) {
                        controller.formKey_shop.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Shop Phone is empty'.tr;
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
                            child: Text('Shop State'.tr,
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
                                initial_value: controller.store_selected_state,
                                list_items: items,
                                selected_index: (selected_index) async {
                                  controller.store_selected_state =
                                      items[selected_index];
                                  setState(() {});
                                  await controller.get_all_store_cites(
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
                        controller.store_selected_state.isEmpty)
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
                    if (controller.store_selected_state.isNotEmpty &&
                        controller.store_allCites != null)
                      Container(
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text('Shop City'.tr,
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
                                controller.store_allCites!.data!
                                    .forEach((element) {
                                  items.add(element.name!);
                                });
                                return CustomDropDown2(
                                  initial_value: controller.store_selected_city,
                                  list_items: items,
                                  selected_index: (selected_index) async {
                                    controller.store_selected_city =
                                        items[selected_index];
                                    setState(() {});
                                  },
                                  hint: 'Shop City',
                                );
                              }),
                            ),
                            if (controller.update_status &&
                                controller.store_selected_city.isEmpty)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Shop City is empty',
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
                      height: 2.0.h,
                    ),
                    CustomTextFields(
                      controller: controller.store_pickup_adress_Controller,
                      labelText: 'Shop Address'.tr,
                      onchaged: (v) {
                        controller.formKey_shop.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Shop Address is empty'.tr;
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Shop Google Location'.tr,
                                    style: TextStyle(fontSize: 10))
                                .translate(),
                          ),
                          InkWell(
                            onTap: () async {
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
                                      controller.store_google_location_address =
                                          v!;
                                      print('address=$v');
                                      controller.updateUI();
                                    },
                                    latitude: (v) {
                                      controller.store_location_lat = v!;
                                      print('address=$v');
                                    },
                                    longitude: (v) {
                                      controller.store_location_lng = v!;
                                      print('address=$v');
                                    });
                              }
                            },
                            child: Container(
                                width: width,
                                height: 55,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black26,
                                            width: 0.7))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                              controller
                                                      .store_google_location_address
                                                      .isEmpty
                                                  ? 'Shop Google Location'.tr
                                                  : controller
                                                      .store_google_location_address,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.grey))
                                          .translate(),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    if (controller.update_status &&
                        controller.store_google_location_address.isEmpty)
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
                      height: 1.0.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Warehouse Address'.tr,
                                  style: TextStyle(
                                      fontFamily: AppFonts.segoeui,
                                      fontSize: 17))
                              .translate(),
                          Visibility(
                            visible: !widget.display_data!,
                            child: IconButton(
                                onPressed: () {
                                  controller.list_of_ware_house_data.add(
                                      WareHouse(
                                          ware_house_address: '',
                                          ware_house_contact: '',
                                          ware_house_email: '',
                                          ware_house_name: '',
                                          ware_house_google_location: '',
                                          ware_house_city: 'Abu Dhabi'.tr,
                                          ware_house_country: 'Abu Dhabi'.tr,
                                          ware_house_state: 'Abu Dhabi'.tr));
                                  controller.updateUI();
                                },
                                icon: Icon(Icons.add_circle)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    ...controller.list_of_ware_house_data.map((e) {
                      int index = controller.list_of_ware_house_data.indexOf(e);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Text(
                                          'Warehouse Address'.tr +
                                              ' ${index + 1}',
                                          style: TextStyle(
                                              fontFamily: AppFonts.segoeui,
                                              fontSize: 14))
                                      .translate(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Row(
                                    children: [
                                      Text('Warehouse Address ${index + 1}'.tr,
                                              style: TextStyle(
                                                  fontFamily: AppFonts.segoeui,
                                                  fontSize: 14))
                                          .translate(),
                                      Visibility(
                                          child: IconButton(
                                              onPressed: () {
                                                controller
                                                    .list_of_ware_house_data
                                                    .removeAt(index);
                                                controller.updateUI();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              )),
                                          visible: !widget.display_data!)
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFieldsDecorated(
                              labelText: 'Warehouse Name'.tr,
                              title: 'Warehouse Name'.tr,
                              maxline: 1,
                              initial_text: e.ware_house_name,
                              show_title: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Warehouse Name is empty'.tr;
                                } else {
                                  return null;
                                }
                              },
                              onchange: (v) {
                                e.ware_house_name = v;
                                controller.updateUI();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFieldsDecorated(
                              labelText: 'Warehouse Contact'.tr,
                              title: 'Warehouse Contact'.tr,
                              maxline: 1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Warehouse Contact is empty'.tr;
                                } else {
                                  return null;
                                }
                              },
                              initial_text: e.ware_house_contact,
                              show_title: false,
                              onchange: (v) {
                                e.ware_house_contact = v;
                                controller.updateUI();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFieldsDecorated(
                              labelText: 'Warehouse Address'.tr,
                              title: 'Warehouse Address'.tr,
                              maxline: 1,
                              initial_text: e.ware_house_address,
                              show_title: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Warehouse Address is empty'.tr;
                                } else {
                                  return null;
                                }
                              },
                              onchange: (v) {
                                e.ware_house_address = v;
                                controller.updateUI();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('Warehouse Google Location'.tr,
                                          style: TextStyle(fontSize: 10))
                                      .translate(),
                                ),
                                InkWell(
                                  onTap: () async {
                                    LocationPermission permission =
                                        await Geolocator.checkPermission();
                                    if (permission ==
                                            LocationPermission.denied ||
                                        permission ==
                                            LocationPermission.deniedForever) {
                                      snackBarFailer(
                                          'Kindly enable Location'.tr);
                                      await Geolocator.requestPermission();
                                    } else {
                                      await getLocation();
                                      await openGoogleDailog(
                                          context: context,
                                          address: (v) {
                                            e.ware_house_google_location = v;
                                            controller.updateUI();
                                          },
                                          latitude: (v) {
                                            controller.store_location_lat = v!;
                                            print('address=$v');
                                          },
                                          longitude: (v) {
                                            controller.store_location_lng = v!;
                                            print('address=$v');
                                          });
                                    }
                                  },
                                  child: Container(
                                      width: width,
                                      height: 55,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.7))),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                                '${e.ware_house_google_location}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black26
                                                      : Colors.grey,
                                                )).translate(),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('Warehouse City'.tr,
                                          style: TextStyle(fontSize: 10))
                                      .translate(),
                                ),
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
                                  // child: DropdownButtonHideUnderline(
                                  //   child: DropdownButton<dynamic>(
                                  //     items: controller.allCites!.data!
                                  //         .map((value) {
                                  //       return DropdownMenuItem<dynamic>(
                                  //         value: value,
                                  //         child:
                                  //             Text('${value.name}').translate(),
                                  //       );
                                  //     }).toList(),
                                  //     hint: Text('${e.ware_house_city}',
                                  //             maxLines: 1,
                                  //             overflow: TextOverflow.ellipsis,
                                  //             style: TextStyle(fontSize: 13))
                                  //         .translate(),
                                  //     onChanged: (data) {
                                  //       city.Data v = data;
                                  //       e.ware_house_city = v.name!;
                                  //       controller.updateUI();
                                  //     },
                                  //   ),
                                  // ),
                                  child: Builder(builder: (context) {
                                    List<String>? items = [];
                                    controller.allCites!.data!
                                        .forEach((element) {
                                      items.add(element.name!);
                                    });
                                    return CustomDropDown2(
                                      initial_value:
                                          items.contains(e.ware_house_city)
                                              ? e.ware_house_city
                                              : items[0],
                                      list_items: items,
                                      selected_index: (selected_index) async {
                                        e.ware_house_city =
                                            items[selected_index];
                                        setState(() {});
                                      },
                                      hint: 'Warehouse City',
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('Warehouse States'.tr,
                                          style: TextStyle(fontSize: 10))
                                      .translate(),
                                ),
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
                                  // child: DropdownButtonHideUnderline(
                                  //   child: DropdownButton<dynamic>(
                                  //     items: controller.allStates!.data!
                                  //         .map((value) {
                                  //       return DropdownMenuItem<dynamic>(
                                  //         value: value,
                                  //         child:
                                  //             Text('${value.name}').translate(),
                                  //       );
                                  //     }).toList(),
                                  //     hint: Text('${e.ware_house_state}',
                                  //             maxLines: 1,
                                  //             overflow: TextOverflow.ellipsis,
                                  //             style: TextStyle(fontSize: 13))
                                  //         .translate(),
                                  //     onChanged: (data) {
                                  //       state.Data v = data;
                                  //       e.ware_house_state = v.name!;
                                  //       controller.updateUI();
                                  //     },
                                  //   ),
                                  // ),
                                  child: Builder(builder: (context) {
                                    List<String>? items = [];
                                    controller.allStates!.data!
                                        .forEach((element) {
                                      items.add(element.name!);
                                    });
                                    print('object$items and ${e.ware_house_state}');
                                    return CustomDropDown2(
                                      initial_value:
                                      items.contains(e.ware_house_state)
                                          ? e.ware_house_state
                                          : items[0],
                                      list_items: items,
                                      selected_index: (selected_index) async {
                                        e.ware_house_state =
                                            items[selected_index];
                                        setState(() {});
                                      },
                                      hint: 'Warehouse State',
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
