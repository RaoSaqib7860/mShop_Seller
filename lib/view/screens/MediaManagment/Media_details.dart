import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';

import '../../../api_repo/basepath.dart';
import '../../../model/media/product_media.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/ShimmerEffect.dart';
import '../../global_widgets/AppSize.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/custom_dropdown.dart';

class MediaDetails extends StatefulWidget {
  final ProductMedia? media;
  final int? index;
  const MediaDetails({Key? key, this.media, this.index}) : super(key: key);

  @override
  State<MediaDetails> createState() => _MediaDetailsState();
}

class _MediaDetailsState extends State<MediaDetails> {
  bool loader = false;

  static var httpClient = new HttpClient();
  Future<File?> _downloadFile({String? url, String? filename}) async {
    var request = await httpClient.getUrl(Uri.parse(url!));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      Directory? tempDir = await getApplicationDocumentsDirectory();
      File file = new File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      snackBarFailer('Storage Permission denied'.tr);
    }
    return null;
  }

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
        actions: [
          Center(
            child: CustomDropdownButton2(
              buttonDecoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              dropdownWidth: 31.w,
              icon: Icon(Icons.more_vert, size: 22),
              hint: '',
              dropdownItems: ['Copy', 'Delete', 'Download'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('$value'),
                );
              }).toList(),
              onChanged: (newValue) async {
                print('$newValue');
                if (newValue == 'Copy') {
                  print('${widget.media!.data![widget.index!].fileName}');
                  await Clipboard.setData(ClipboardData(
                      text: '${widget.media!.data![widget.index!].fileName}'));
                  snackBarSuccess('Copied'.tr);
                } else if (newValue == 'Delete') {
                  loader = true;
                  setState(() {});
                  await DataProvider.deleteMedia(
                      id: '${widget.media!.data![widget.index!].id}');
                  loader = false;
                  setState(() {});
                  Navigator.of(context).pop('delete');
                } else {
                  File? file = await _downloadFile(
                      url:
                          "${imageUrl}${widget.media!.data![widget.index!].fileName}",
                      filename: '${widget.media!.data![widget.index!].fileName}'
                          .split('/')
                          .last);
                  if (file != null) {
                    print(file.path);
                    // snackBarSuccess(
                    //     'File download successfully'.tr);
                    await Share.shareFiles(['${file.path}'], text: 'Report');
                  }
                }
              },
            ),
          ),
          // Center(
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton(
          //       //value: 'Copy',
          //       icon: const Icon(Icons.more_vert),
          //       items: ['Copy', 'Delete', 'Download'].map((String items) {
          //         return DropdownMenuItem(
          //           value: items,
          //           child: Text(items),
          //         );
          //       }).toList(),
          //       onChanged: (newValue) async {
          //         print('$newValue');
          //         if (newValue == 'Copy') {
          //         } else if (newValue == 'Delete') {
          //           loader = true;
          //           setState(() {});
          //           await DataProvider.deleteMedia(
          //               id: '${widget.media!.data![widget.index!].id}');
          //           loader = false;
          //           setState(() {});
          //           Navigator.of(context).pop('delete');
          //         } else {}
          //       },
          //       isDense: true,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 20,
          // )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "${imageUrl}${widget.media!.data![widget.index!].fileName}",
                  placeholder: (context, url) => ShimerEffect(
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                ),
              ],
            ),
          ),
          if (loader)
            Visibility(
              child: Center(
                child: Center(
                  child: spinKitGlobal(
                    size: 30.0,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
