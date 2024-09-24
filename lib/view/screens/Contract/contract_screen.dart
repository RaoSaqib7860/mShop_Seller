import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/view/global_widgets/Sackbars.dart';

import '../../../model/Downloade/downloade_model.dart';
import '../../../utils_services/colors_util.dart';
import '../../../utils_services/global_variable.dart';
import '../../../utils_services/storage_util.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  DownloadModel? downloadModel;
  @override
  void initState() {
    apiCall();
    super.initState();
  }

  Future getFilePck() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );
    dio.FormData data = dio.FormData.fromMap({
      'document': await dio.MultipartFile.fromFile(
        '${result!.files[0].path!}',
        filename: '${result.files[0].name}',
      )
    });
    bool? v = await DataProvider().upLoad_user_documents(mapObject: data);
    if (v == true) {
      snackBarFailer('File Upload Successfully');
    }
    await DataProvider().loginFunction(
        Email: user_model.user!.email, Password: storage.read('user_password'));
  }

  apiCall() async {
    downloadModel = await DataProvider().get_download_product();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Seller Contract',
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppFonts.segoeui,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('01  Download Contract',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.segoeui)),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    height: 14.h,
                    width: 0.5.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: blueGrey),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1. Download Contract',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: AppFonts.segoeui)),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text('2. Sign/ Stamp The Contract',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: AppFonts.segoeui)),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () async {
                              File? file = await _downloadFile(
                                  url: '${downloadModel!.documentUrl}',
                                  filename: 'Mate_Contract.pdf');

                              if (file != null) {
                                print(file.path);
                                Share.shareXFiles([XFile(file.path)],
                                    text: 'Download Contract');
                                snackBarSuccess('File download successfully');
                              }
                            },
                            child: Container(
                              height: 5.h,
                              width: 50.w,
                              margin: EdgeInsets.only(left: 15),
                              child: Center(
                                  child: Text('Download Contract',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFonts.segoeui,
                                          color: Colors.white))),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: blueGrey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('02  Upload Contract',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.segoeui)),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    height: 10.h,
                    width: 0.5.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: blueGrey),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1. Upload Sign/ Stamped contract Contract',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: AppFonts.segoeui)),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          InkWell(
                            onTap: () async {
                              await getFilePck();
                              Navigator.of(context).pop('true');
                            },
                            child: Container(
                              height: 5.h,
                              width: 50.w,
                              margin: EdgeInsets.only(left: 15),
                              child: Center(
                                  child: Text('Upload Contract',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: AppFonts.segoeui,
                                          color: Colors.white))),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: blueGrey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static var httpClient = new HttpClient();
  Future<File?> _downloadFile({String? url, String? filename}) async {
    var request = await httpClient.getUrl(Uri.parse(url!));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      Directory? tempDir = await getTemporaryDirectory();
      File file = new File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      snackBarFailer('Storage Permission denied');
    }
    return null;
  }
}
