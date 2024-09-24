import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils_services/Loader.dart';
import 'AppSize.dart';
import 'Sackbars.dart';

class WebViewGlobal extends StatefulWidget {
  final String? url;
  final String? title;
  const WebViewGlobal({
    Key? key,
    this.url,
    this.title = 'Invoice',
  }) : super(key: key);

  @override
  State<WebViewGlobal> createState() => _WebViewGlobalState();
}

class _WebViewGlobalState extends State<WebViewGlobal> {
  @override
  void initState() {
    print('url  = ${widget.url}');
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(widget.title!, style: TextStyle(color: Colors.black)),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: [
              if (widget.title == 'Seller Contract')
                IconButton(
                    onPressed: () async {
                      File? file = await _downloadFile(
                          url: '${widget.url}',
                          filename: 'Seller Contract.pdf');
                      if (file != null) {
                        print(file.path);
                        await Share.shareXFiles([XFile('${file.path}')]);
                      }
                    },
                    icon: Icon(
                      Icons.ios_share,
                      color: Colors.black,
                    ))
            ]),
        body: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              // WebView(
              //   initialUrl: Uri.parse('${widget.url}').toString(),
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onWebViewCreated: (WebViewController webViewController) {
              //     _controller.complete(webViewController);
              //   },
              //   onPageFinished: (v) {
              //     print('completed');
              //     load = true;
              //     setState(() {});
              //   },
              // ),
              if (!load)
                Center(
                  child: screenLoader(use_opacity: false),
                )
            ],
          ),
        ));
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
      Directory? tempDir = await getApplicationDocumentsDirectory();
      File file = new File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      snackBarFailer('Storage Permission denied');
    }
    return null;
  }
}
