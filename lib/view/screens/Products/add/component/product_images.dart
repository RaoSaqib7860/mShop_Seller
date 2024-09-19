import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../../../api_repo/basepath.dart';
import '../../../../../providers/add_product_provider.dart';
import '../../../../../utils_services/ShimmerEffect.dart';
import '../../../../../utils_services/app_font.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({Key? key}) : super(key: key);

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  @override
  Widget build(BuildContext context) {
    var productController = Provider.of<AddProductProvider>(context);
    return ExpansionTile(
      title: Text('Product Images'.tr,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontFamily: AppFonts.segoeui)),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 7),
            //   child: Text('Product Images'.tr,
            //       style: TextStyle(
            //           fontWeight: FontWeight.w600, fontFamily: AppFonts.segoeui)),
            // ),
            //SizedBox(height: 7, width: width),
            Card(
              color: Theme.of(context!).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Product Image'.tr),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        height: height - 100,
                                        width: width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Expanded(child: SizedBox()),
                                                Expanded(
                                                  child: Text('Add Product'.tr,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        child: Text('Done'.tr,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Image'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('name'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('Size'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Expanded(
                                                child: SingleChildScrollView(
                                              child: Column(
                                                children: productController
                                                    .productMedia.data!
                                                    .map((e) {
                                                  int index = productController
                                                      .productMedia.data!
                                                      .indexOf(e);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Checkbox(
                                                            value: productController
                                                                        .thumbnailImage ==
                                                                    null
                                                                ? false
                                                                : productController
                                                                        .thumbnailImage ==
                                                                    e,
                                                            onChanged: (v) {
                                                              if (v!) {
                                                                productController
                                                                    .thumbnailImage = e;
                                                              } else {
                                                                productController
                                                                        .thumbnailImage =
                                                                    null;
                                                              }
                                                              setState(() {});
                                                            }),
                                                        SizedBox(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${imageUrl}${e.fileName}",
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    ShimerEffect(
                                                              child: Container(
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                          height: 100,
                                                          width: 90,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child: SizedBox(
                                                              child: Text(
                                                                  '${e.fileName}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              width: 150),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text('${e.fileSize}',
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ))
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                });
                            Future.delayed(Duration(milliseconds: 100), () {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.blue,
                            )),
                            decoration: BoxDecoration(
                                color: Theme.of(context!).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                                border:
                                    Border.all(width: 0.5, color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await productController.getThumbnailImages();
                            productController.updateUI();
                            Future.delayed(Duration(milliseconds: 100), () {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Center(
                                child: Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    productController.thumbnailImage == null
                        ? SizedBox()
                        : Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: height * 0.080,
                                  width: width * 0.180,
                                  child: Image.network(
                                      '${imageUrl}${productController.thumbnailImage!.fileName}',
                                      fit: BoxFit.cover),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Gallery Images'.tr),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        height: height - 100,
                                        width: width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Expanded(child: SizedBox()),
                                                Expanded(
                                                  child: Text('Add Product'.tr,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        child: Text('Done'.tr,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Image'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('name'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('Size'.tr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Expanded(
                                                child: SingleChildScrollView(
                                              child: Column(
                                                children: productController
                                                    .productMedia.data!
                                                    .map((e) {
                                                  int index = productController
                                                      .productMedia.data!
                                                      .indexOf(e);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Checkbox(
                                                            value: productController
                                                                .list_of_selected_media
                                                                .contains(e),
                                                            onChanged: (v) {
                                                              if (v!) {
                                                                productController
                                                                    .list_of_selected_media
                                                                    .add(e);
                                                              } else {
                                                                productController
                                                                    .list_of_selected_media
                                                                    .remove(e);
                                                              }
                                                              setState(() {});
                                                            }),
                                                        SizedBox(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${imageUrl}${e.fileName}",
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    ShimerEffect(
                                                              child: Container(
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                          height: 100,
                                                          width: 90,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child: SizedBox(
                                                              child: Text(
                                                                      '${e.fileName}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12))
                                                                  .translate(),
                                                              width: 150),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text('${e.fileSize}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12))
                                                            .translate(),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ))
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                }).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.blue,
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await productController.getOtherFilesImage();
                            productController.updateUI();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Center(
                                child: Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    productController.list_of_selected_media.isEmpty
                        ? SizedBox()
                        : SizedBox(
                            width: width,
                            child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 2.0,
                                children: productController
                                    .list_of_selected_media
                                    .map((e) {
                                  int index = productController
                                      .list_of_selected_media
                                      .indexOf(e);
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        child: Container(
                                          height: height * 0.080,
                                          width: width * 0.180,
                                          child: Image.network(
                                              '${imageUrl}${e.fileName}',
                                              fit: BoxFit.cover),
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey[50],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      Positioned(
                                        child: InkWell(
                                            child: Icon(Icons.cancel),
                                            onTap: () {
                                              productController
                                                  .list_of_selected_media
                                                  .removeAt(index);
                                              productController.updateUI();
                                            }),
                                        right: 1,
                                        top: 1,
                                      )
                                    ],
                                  );
                                }).toList()),
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
