import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';

import '../../global_widgets/AppSize.dart';
import '../../global_widgets/snakbar.dart';

class ViewContract extends StatefulWidget {
  const ViewContract({Key? key}) : super(key: key);

  @override
  State<ViewContract> createState() => _ViewContractState();
}

class _ViewContractState extends State<ViewContract> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Seller contract is under review',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: AppFonts.segoeui,
                        color: Colors.black)),
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                  onTap: () async {
                    loading = true;
                    setState(() {});
                    print('contractLink = ${user_model.user!.contractLink}');
                    File? file = await _downloadFile(
                        url: '${user_model.user!.contractLink}',
                        filename: 'Mate_Contract.pdf');
                    if (file != null) {
                      print(file.path);
                      OpenFile.open(file.path);
                    }
                    loading = false;
                    setState(() {});
                  },
                  child: Container(
                    height: 5.h,
                    width: 50.w,
                    child: Center(
                        child: Text(
                      'View Contract',
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        color: blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          if (loading) Center(child: CircularProgressIndicator())
        ],
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
