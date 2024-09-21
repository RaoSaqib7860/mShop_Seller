import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api_repo/api_utils.dart';
import '../../../api_repo/basepath.dart';
import '../../../model/media/product_media.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/ShimmerEffect.dart';
import '../../../utils_services/app_font.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/AppSize.dart';
import '../../global_widgets/web_view_global.dart';
import 'Media_details.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  ProductMedia? productMedia;
  bool loading = true;
  StreamSubscription? subscription;
  @override
  void initState() {
    getProductMedia();
    subscription =
        InternetConnectivity.connectivity_stream.stream.listen((event) {
          if (event) {
            /// do api call
            print('call api');
            getProductMedia();
          } else {
            print('stop api');
          }
        });
    super.initState();
  }

  getProductMedia() async {
    productMedia = await DataProvider.product_media_api();
    productMedia!.data!.removeWhere((element) =>
        element.fileName!.contains('pdf') ||
        element.fileName!.contains('html'));
    loading = false;
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  Future getOtherFilesImage() async {
    List<XFile>? files = await _picker.pickMultiImage();
    for (var element in files) {
      dio.FormData data = dio.FormData.fromMap({
        'aiz_file': await dio.MultipartFile.fromFile(
          element.path,
          filename: '${element.name}',
        )
      });
      await DataProvider.uploadMedia_api(uploadMedia: data);
    }
    setState(() {
      upload = true;
    });
    print('files 2 = ${files.length}');
    setState(() {
      upload = false;
    });
    getProductMedia();
  }

  bool upload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'Gallery'.tr,
            style: TextStyle(
              fontFamily: AppFonts.segoeui,
              fontSize: 17,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                getOtherFilesImage();
              },
              child: Center(
                child: Text(
                  'Upload'.tr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          children: [
            if (loading)
              Center(
                child: Center(
                  child: spinKitGlobal(
                    size: 30.0,
                  ),
                ),
              )
            else if (productMedia!.data!.isEmpty)
              Center(
                child: Text('No Data'),
              )
            else
              Container(
                  height: height - 100,
                  width: width,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                              onTap: () {
                                if (productMedia!.data![index].fileName!
                                        .contains('pdf') ||
                                    productMedia!.data![index].fileName!
                                        .contains('html')) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewGlobal(
                                          url:
                                              "${imageUrl}${productMedia!.data![index].fileName}",
                                          title: 'Mate Seller',
                                        ),
                                      ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MediaDetails(
                                            index: index, media: productMedia),
                                      )).then((value) async {
                                    if (value == 'delete') {
                                      loading = true;
                                      setState(() {});
                                      productMedia = await DataProvider
                                          .product_media_api();
                                      productMedia!.data!.removeWhere(
                                          (element) =>
                                              element
                                                  .fileName!
                                                  .contains('pdf') ||
                                              element.fileName!
                                                  .contains('html'));
                                      loading = false;
                                      setState(() {});
                                    }
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //color: const Color(0xffF8F8F9),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade400
                                            .withOpacity(0.5),
                                        //color: const Color(0x290bab0d),
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    child: productMedia!.data![index].fileName!
                                                .contains('pdf') ||
                                            productMedia!.data![index].fileName!
                                                .contains('html')
                                        ? Center(
                                            child: Text('Document'),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "${imageUrl}${productMedia!.data![index].fileName}",
                                            placeholder: (context, url) =>
                                                ShimerEffect(
                                              child: Container(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) {
                                              return Icon(Icons.error);
                                            },
                                          ),
                                    height: 100,
                                    width: 90,
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: productMedia!.data!.length,
                        ),
                      )
                      // ...productMedia!.data!.map((e) {
                      //   int index = productMedia!.data!.indexOf(e);
                      //   return Padding(
                      //     padding: const EdgeInsets.all(5.0),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         //color: const Color(0xffF8F8F9),
                      //         color: Theme.of(context!).brightness ==
                      //                 Brightness.light
                      //             ? Colors.white
                      //             : Colors.black,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color:
                      //                 Colors.grey.shade400.withOpacity(0.5),
                      //             //color: const Color(0x290bab0d),
                      //             offset: Offset(0, 3),
                      //             blurRadius: 6,
                      //           ),
                      //         ],
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             child: CachedNetworkImage(
                      //               imageUrl: "${imageUrl}${e.fileName}",
                      //               placeholder: (context, url) =>
                      //                   ShimerEffect(
                      //                 child: Container(
                      //                   color: Colors.blue,
                      //                 ),
                      //               ),
                      //               errorWidget: (context, url, error) =>
                      //                   Icon(Icons.error),
                      //             ),
                      //             height: 100,
                      //             width: 90,
                      //           ),
                      //           SizedBox(width: 5),
                      //           Expanded(
                      //             child: Row(
                      //               children: [
                      //                 Expanded(
                      //                   child: SizedBox(
                      //                       child: Text('${e.fileName}',
                      //                           style:
                      //                               TextStyle(fontSize: 12)),
                      //                       width: 150),
                      //                 ),
                      //                 SizedBox(width: 5),
                      //                 InkWell(
                      //                     child: Icon(Icons.copy),
                      //                     onTap: () async {
                      //                       await Clipboard.setData(
                      //                           ClipboardData(
                      //                               text: '${e.fileName}'));
                      //                       snackBarSuccess('Copied'.tr);
                      //                     }),
                      //                 SizedBox(width: 10),
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(width: 5),
                      //           Text('${e.fileSize}',
                      //               style: TextStyle(fontSize: 12)),
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // }).toList()
                    ],
                  )),
            Visibility(
              child: Center(
                child: Center(
                  child: spinKitGlobal(
                    size: 30.0,
                  ),
                ),
              ),
              visible: upload,
            )
          ],
        ));
  }
}
