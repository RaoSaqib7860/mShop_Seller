import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';

import '../../../api_repo/api_utils.dart';
import '../../../utils_services/Loader.dart';
import '../../../utils_services/app_font.dart';

class BulkUpload extends StatefulWidget {
  const BulkUpload({Key? key}) : super(key: key);

  @override
  State<BulkUpload> createState() => _BulkUploadState();
}

class _BulkUploadState extends State<BulkUpload> {
  bool loading = false;
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20,color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Bulk Upload'.tr,
          style: TextStyle(
            fontFamily: AppFonts.segoeui,
            fontSize: 17,
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    'Download and save the sample file\n file should be .csv format\n You can copy image path from media section'.tr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  ByteData byteData =
                      await rootBundle.load('assets/csv/csv-bulk.csv');
                  final String path =
                      (await getApplicationDocumentsDirectory()).path;
                  final String filename = '$path/bulk_sample.csv';
                  final File file = File(filename);
                  File save_file = await file.writeAsBytes(byteData.buffer
                      .asUint8List(
                          byteData.offsetInBytes, byteData.lengthInBytes));
                  setState(() {
                    loading = false;
                  });
                  OpenFile.open(save_file.path);
                },
                child: Container(
                  child: Center(
                      child: Text(
                    'Download Sample File'.tr,
                    style: TextStyle(color: Colors.white),
                  )),
                  height: 40,
                  width: width / 2,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowMultiple: false,
                        allowedExtensions: ['csv'],
                      );
                      setState(() {});
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'Select File'.tr,
                        style: TextStyle(color: Colors.white),
                      )),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (result != null) {
                        setState(() {
                          loading = true;
                        });
                        dio.FormData data = dio.FormData.fromMap({
                          'bulk_file': await dio.MultipartFile.fromFile(
                            '${result!.files[0].path!}',
                            filename: '${result!.files[0].name}',
                          )
                        });
                        await DataProvider.process_bulk_upload_api(
                            uploadMedia: data);
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'Upload Sample File'.tr,
                        style: TextStyle(color: Colors.white),
                      )),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (result != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text('${result!.files[0].path}',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                  ),
                )
            ], crossAxisAlignment: CrossAxisAlignment.center),
          ),
          Visibility(
            child: Center(
              child: Center(
                child: spinKitGlobal(
                  size: 30.0,
                ),
              ),
            ),
            visible: loading,
          )
        ],
      ),
    );
  }
}
