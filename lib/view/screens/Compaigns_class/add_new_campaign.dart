import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../api_repo/api_utils.dart';
import '../../../extentions/app_colors.dart';
import '../../../model/All Products/all_products_model.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';
import '../../../utils_services/colors_util.dart';
import '../../../view_model/all_products_blocs/all_product_event.dart';
import '../../../view_model/all_products_blocs/all_product_state.dart';
import '../../../view_model/all_products_blocs/all_products_bloc.dart';
import '../../global_widgets/text_field.dart';
import 'campaign_search_repository.dart';

class NewCampaign extends StatefulWidget {
  String? tag;
  String? name;
  dynamic discount;
  String? discount_type;
  String? startDate;
  String? endDate;
  List<String>? productId;
  int? campaignId;
  String? active_or_inactive;
  NewCampaign(
      {Key? key,
      this.productId,
      this.tag,
      this.name,
      this.endDate,
      this.startDate,
      this.campaignId,
      this.discount,
      this.discount_type,
      this.active_or_inactive})
      : super(key: key);

  @override
  State<NewCampaign> createState() => _NewCampaignState();
}

class _NewCampaignState extends State<NewCampaign>
    with CampaignSearchRepository {
  @override
  void initState() {
    myAllProductBloc.add(AllProductEvent());
    if (widget.tag == 'update') {
      nameController.text = widget.name ?? '';
      discountController.text = widget.discount.toString() ?? '';
      startDateController.text = widget.startDate ?? '';
      endDateController.text = widget.endDate ?? '';
      dropdownvalue = widget.discount_type ?? 'flat'.tr;
      switch_value = widget.active_or_inactive == '0' ? false : true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
        title: Text(
          widget.tag != 'update' ? 'Add new campaign' : 'Update Campaign',
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: InkWell(
              onTap: () async {
                if (widget.tag != 'update') {
                  bool result = await DataProvider().add_new_campaign(object: {
                    'name': '${nameController.text}',
                    'discount': '${discountController.text}',
                    'discount_type': '$dropdownvalue',
                    'start_date': '${startDateController.text}',
                    'end_date': '${endDateController.text}',
                    'is_active': switch_value ? '1' : '0',
                    'product_ids[]': '${selected_ids.join(',')}'
                  });
                  if (result == true) {
                    Navigator.of(context).pop('add');
                  }
                } else {
                  bool result =
                      await DataProvider().update_new_campaign(object: {
                    'name': '${nameController.text}',
                    'discount': '${discountController.text}',
                    'discount_type': '$dropdownvalue',
                    'start_date': '${startDateController.text}',
                    'end_date': '${endDateController.text}',
                    'is_active': switch_value ? '1' : '0',
                    'product_ids[]': '${selected_ids.join(',')}',
                    'remove_product_ids[]': '${deSelected_ids.join(',')}',
                    'campaign_id': '${widget.campaignId}'
                  });
                  if (result == true) {
                    Navigator.of(context).pop('update');
                  }
                }
              },
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: offBlackAvatr,
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    widget.tag != 'update' ? 'ADD' : 'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: BlocConsumer<allProductBloc, AllProductState>(
        bloc: myAllProductBloc,
        listener: (context, state) {
          if (state is AllProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${state.error}').translate()));
          }
        },
        builder: (context, state) {
          if (state is AllProductLoadingState) {
            return Center(
                child: Center(child: screenLoader(use_opacity: false)));
          } else if (state is AllProductLoadedState) {
            return allProductUi(
                context: context, getAllProduct: state.response);
          } else {
            return Center(child: Text('data Not Loaded....').translate());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    discountController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    searchController.dispose();
  }

  bool switch_value = false;
  Widget allProductUi(
      {GetAllProductModels? getAllProduct, BuildContext? context}) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(switch_value ? 'Active' : 'Inactive'),
                  SizedBox(width: 10),
                  CupertinoSwitch(
                    activeColor: Colors.green,
                    value: switch_value,
                    onChanged: (v) => setState(() => switch_value = v),
                  ),
                  SizedBox(width: 10),
                ],
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
                height: 2.h,
              ),
              CustomTextFields(
                controller: discountController,
                labelText: 'Discount'.tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter the name '.tr;
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              // Container(
              //   height: 6.h,
              //   //width: 30.w,
              //   //color: Colors.deepPurple,
              //   child: Center(
              //     child: Row(
              //       mainAxisAlignment:
              //       MainAxisAlignment.center,
              //       //crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         DropdownButton(
              //
              //           // Initial Value
              //           value: dropdownvalue,
              //
              //           //isExpanded: true,
              //           // Down Arrow Icon
              //           icon: const Icon(Icons.keyboard_arrow_down),
              //
              //           // Array list of items
              //           items: items.map((String items) {
              //             return DropdownMenuItem(
              //               value: items,
              //               child: Text(items),
              //             );
              //           }).toList(),
              //           // After selecting the desired option,it will
              //           // change button value to selected value
              //           onChanged: (String? newValue) {
              //             setState(() {
              //               dropdownvalue = newValue!;
              //             });
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: DropdownButton(
                  value: dropdownvalue,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFields(
                controller: startDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please select the licence expiry data'.tr;
                  } else {
                    return null;
                  }
                },
                labelText: 'start Date'.tr,
                readOnly: true,
                suffixIcon: InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context!,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          startDateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                    child: Icon(Icons.calendar_today)),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFields(
                controller: endDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please select the licence expiry data'.tr;
                  } else {
                    return null;
                  }
                },
                labelText: 'end Date'.tr,
                readOnly: true,
                suffixIcon: InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context!,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          endDateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                    child: Icon(Icons.calendar_today)),
              ),
              SizedBox(
                height: 2.h,
              ),
              Visibility(
                visible: widget.tag == 'update' ? true : false,
                child: Container(
                  height: 40.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context!).brightness == Brightness.light
                        ? Colors.white
                        : AppColors.blackColor,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(3, 3),
                          blurRadius: 7,
                          spreadRadius: 3),
                      BoxShadow(
                          color: blueGrey.withOpacity(0.1),
                          offset: Offset(-1, -1))
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Already added campaign',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context!).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            )).translate(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(
                          //height: 20.h,
                          child: ListView.builder(
                        itemCount: getAllProduct!.data!.length,
                        itemBuilder: (context, index) {
                          return getAllProduct!.data![index].campaign != null &&
                                  widget.productId!.contains(
                                      '${getAllProduct!.data![index].id}')
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    leading: Container(
                                      height: 8.h,
                                      width: 7.2.h,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${getAllProduct.data![index].thumbnailImg}",
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: Container(
                                      width: 20.w,
                                      height: 6.h,
                                      child: Text(
                                        '${getAllProduct.data![index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color:
                                              Theme.of(context!).brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                      ).translate(),
                                    ),
                                    trailing: Checkbox(
                                        checkColor: Colors.white,
                                        side: BorderSide(
                                          color:
                                              Theme.of(context!).brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                        value: !deSelected_ids.contains(
                                            getAllProduct.data![index].id),
                                        activeColor: Colors.green,
                                        onChanged: (newValue) {
                                          if (deSelected_ids.contains(
                                              getAllProduct.data![index].id)) {
                                            deSelected_ids.remove(
                                                getAllProduct.data![index].id);
                                          } else {
                                            deSelected_ids.add(
                                                getAllProduct.data![index].id);
                                          }
                                          setState(() {});
                                        }),
                                  ),
                                )
                              : SizedBox();
                        },
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                title: Text('All Products',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))
                    .translate(),
              ),
              Container(
                height: 70.h,
                width: 95.w,
                decoration: BoxDecoration(
                  color: Theme.of(context!).brightness == Brightness.light
                      ? Colors.white
                      : AppColors.blackColor,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                        color: blueGrey.withOpacity(0.1),
                        offset: Offset(3, 3),
                        blurRadius: 7,
                        spreadRadius: 3),
                    BoxShadow(
                        color: blueGrey.withOpacity(0.1),
                        offset: Offset(-1, -1))
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(30.0),
                          //color: Colors.blueGrey.shade50,
                          color:
                              Theme.of(context!).brightness == Brightness.light
                                  ? Colors.blueGrey.shade50
                                  : AppColors.blackColor,
                          boxShadow: [
                            BoxShadow(
                                color: blueGrey.withOpacity(0.1),
                                offset: Offset(3, 3),
                                blurRadius: 1,
                                spreadRadius: 1),
                            BoxShadow(
                                color: blueGrey.withOpacity(0.1),
                                offset: Offset(-1, -1))
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (searchController != null) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SubCategoriesScreen(
                              //         Id: '',
                              //         CategoryId: '',
                              //         name: '${searchText.value}',
                              //         search_result: search_result,
                              //       ),
                              //     ));
                            }
                          },
                          onChanged: (v) async {
                            await get_search_campaign(value: v);
                            setState(() {});
                            //searchText = v;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            hintText: 'Search for product'.tr,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.textColor
                                  : AppColors.textColor,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.only(top: 7),
                            border: InputBorder.none,
                            //fillColor:  Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                        child: searchController.text.isNotEmpty
                            ? ListView.builder(
                                itemCount: campaignSearchModel!.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      leading: Container(
                                        height: 8.h,
                                        width: 7.2.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${campaignSearchModel!.data![index].thumbnailImg}",
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.white,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      title: Container(
                                        width: 20.w,
                                        height: 6.h,
                                        child: Text(
                                          '${campaignSearchModel!.data![index].name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context!).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ).translate(),
                                      ),
                                      trailing: Checkbox(
                                          checkColor: Colors.white,
                                          side: BorderSide(
                                            color:
                                                Theme.of(context!).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                          value: selected_ids.contains(
                                              getAllProduct.data![index].id),
                                          activeColor: Colors.green,
                                          onChanged: (newValue) {
                                            if (selected_ids.contains(
                                                getAllProduct
                                                    .data![index].id)) {
                                              selected_ids.remove(getAllProduct
                                                  .data![index].id);
                                            } else {
                                              selected_ids.add(getAllProduct
                                                  .data![index].id);
                                            }
                                            setState(() {});
                                          }),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: getAllProduct!.data!.length,
                                itemBuilder: (context, index) {
                                  return getAllProduct!.data![index].campaign ==
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: ListTile(
                                            leading: Container(
                                              height: 8.h,
                                              width: 7.2.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${getAllProduct.data![index].thumbnailImg}",
                                                placeholder: (context, url) =>
                                                    Container(
                                                  color: Colors.white,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            title: Container(
                                              width: 20.w,
                                              height: 6.h,
                                              child: Text(
                                                '${getAllProduct.data![index].name}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Theme.of(context!)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ).translate(),
                                            ),
                                            trailing: Checkbox(
                                                checkColor: Colors.white,
                                                side: BorderSide(
                                                  color: Theme.of(context!)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                                value: selected_ids.contains(
                                                    getAllProduct
                                                        .data![index].id),
                                                activeColor: Colors.green,
                                                onChanged: (newValue) {
                                                  if (selected_ids.contains(
                                                      getAllProduct
                                                          .data![index].id)) {
                                                    selected_ids.remove(
                                                        getAllProduct
                                                            .data![index].id);
                                                  } else {
                                                    selected_ids.add(
                                                        getAllProduct
                                                            .data![index].id);
                                                  }
                                                  setState(() {});
                                                }),
                                          ),
                                        )
                                      : SizedBox();
                                },
                              ))
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              // GestureDetector(
              //   onTap: () async {
              //     if (widget.tag != 'update') {
              //       bool result =
              //           await DataProvider().add_new_campaign(object: {
              //         'name': '${nameController.text}',
              //         'discount': '${discountController.text}',
              //         'discount_type': '$dropdownvalue',
              //         'start_date': '${startDateController.text}',
              //         'end_date': '${endDateController.text}',
              //         'is_active': '1',
              //         'product_ids[]': '${selected_ids.join(',')}'
              //       });
              //       if (result == true) {
              //         Navigator.of(context).pop('add');
              //       }
              //     } else {
              //       bool result =
              //           await DataProvider().update_new_campaign(object: {
              //         'name': '${nameController.text}',
              //         'discount': '${discountController.text}',
              //         'discount_type': '$dropdownvalue',
              //         'start_date': '${startDateController.text}',
              //         'end_date': '${endDateController.text}',
              //         'is_active': '0',
              //         'product_ids[]': '${selected_ids.join(',')}',
              //         'remove_product_ids[]': '${deSelected_ids.join(',')}',
              //         'campaign_id': '${widget.campaignId}'
              //       });
              //       if (result == true) {
              //         Navigator.of(context).pop('update');
              //       }
              //     }
              //   },
              //   child: Container(
              //     height: 5.h,
              //     width: 90.w,
              //     decoration: BoxDecoration(
              //         color: Theme.of(context).brightness == Brightness.light
              //             ? blueGrey
              //             : AppColors.blackColor,
              //         boxShadow: [
              //           BoxShadow(
              //               color: blueGrey.withOpacity(0.1),
              //               offset: Offset(3, 3),
              //               blurRadius: 7,
              //               spreadRadius: 3),
              //           BoxShadow(
              //               color: blueGrey.withOpacity(0.1),
              //               offset: Offset(-1, -1))
              //         ],
              //         borderRadius: BorderRadius.circular(8)),
              //     child: Center(
              //       child: Text(
              //         widget.tag != 'update' ? 'ADD' : 'Update',
              //         style: TextStyle(
              //             color: Theme.of(context).brightness == Brightness.dark
              //                 ? Colors.black
              //                 : Colors.white,
              //             fontSize: 14.sp),
              //       ).translate(),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 6.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
