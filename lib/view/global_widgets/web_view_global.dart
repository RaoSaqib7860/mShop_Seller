import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils_services/Loader.dart';
import 'AppSize.dart';
import 'Sackbars.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewGlobal extends StatefulWidget {
  final String? url;
  final String? title;
  const WebViewGlobal({super.key, this.url, this.title});

  @override
  State<WebViewGlobal> createState() => _WebViewGlobalState();
}

class _WebViewGlobalState extends State<WebViewGlobal> {
  late final WebViewController _controller;
  bool load = true;
  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            load = false;
            setState(() {});
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return DataLoading(
      isLoading: load,
      child: Scaffold(
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
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}

class DataLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final bool? use_opacity;
  const DataLoading(
      {Key? key,
      required this.child,
      required this.isLoading,
      this.use_opacity = true})
      : super(key: key);

  @override
  State<DataLoading> createState() => _DataLoadingState();
}

class _DataLoadingState extends State<DataLoading>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        widget.child,
        widget.isLoading
            ? Container(
                width: size.width,
                height: size.height,
                color:
                    !widget.use_opacity! ? null : Colors.white.withOpacity(0.2),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitThreeInOut(
                      color: Color(0xffFFCC1B),
                      size: 25.0,
                    )
                  ],
                ))
            : const SizedBox()
      ],
    );
  }
}

// class WebViewGlobal extends StatefulWidget {
//   final String? url;
//   final String? title;
//   const WebViewGlobal({
//     Key? key,
//     this.url,
//     this.title = 'Invoice',
//   }) : super(key: key);
//
//   @override
//   State<WebViewGlobal> createState() => _WebViewGlobalState();
// }
//
// class _WebViewGlobalState extends State<WebViewGlobal> {
//   @override
//   void initState() {
//     print('url  = ${widget.url}');
//     super.initState();
//   }
//
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//   bool load = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Text(widget.title!, style: TextStyle(color: Colors.black)),
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//             ),
//             actions: [
//               if (widget.title == 'Seller Contract')
//                 IconButton(
//                     onPressed: () async {
//                       File? file = await _downloadFile(
//                           url: '${widget.url}',
//                           filename: 'Seller Contract.pdf');
//                       if (file != null) {
//                         print(file.path);
//                         await Share.shareXFiles([XFile('${file.path}')]);
//                       }
//                     },
//                     icon: Icon(
//                       Icons.ios_share,
//                       color: Colors.black,
//                     ))
//             ]),
//         body: Container(
//           width: width,
//           height: height,
//           child: Stack(
//             children: [
//               WebView(
//                 initialUrl: Uri.parse('${widget.url}').toString(),
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onWebViewCreated: (WebViewController webViewController) {
//                   _controller.complete(webViewController);
//                 },
//                 onPageFinished: (v) {
//                   print('completed');
//                   load = true;
//                   setState(() {});
//                 },
//               ),
//               if (!load)
//                 Center(
//                   child: screenLoader(use_opacity: false),
//                 )
//             ],
//           ),
//         ));
//   }
//
var httpClient = new HttpClient();
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
