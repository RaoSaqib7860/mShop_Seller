import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/model/App%20Check%20Virsion/app_check_version.dart';
import 'package:mShop_Seller/model/login/login_model.dart';
import 'package:mShop_Seller/utils_services/storage_util.dart';
import 'package:mShop_Seller/view/screens/bottom_sheet/bottom_sheet.dart';
import 'dart:io' show Platform;
import '../../../main.dart';
import '../../../model/Notification/notification_payload..dart';
import '../../../utils_services/GooogleMapSearchAddress.dart';
import '../../../utils_services/global_variable.dart';
import '../../conectivity/connectivity.dart';
import '../LoginPages/login_screen.dart';
import '../orders/order_detail.dart';
AppVersionCheckModel? appVersionCheckModel;
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('Clicked notification ');
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  print('Clicked notification 3');
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool active_noti_route = false;

  appVersionCheck(BuildContext? context) async {
    appVersionCheckModel = await DataProvider.verify_app_selles_version();
    versionCheckApi(context);
     print('app check version ${appVersionCheckModel!.toJson()}');
    setState(() {});
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  String? version;

  versionCheckApi(BuildContext? context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    print('object app version ${version}');

    String v1 =Platform.isAndroid?
    '${appVersionCheckModel!.data![7].value}':
    '${appVersionCheckModel!.data![1].value}',
    // '${appVersionCheckModel!.data![4].value}'.length == 3
    //     ? '${appVersionCheckModel!.data![4].value}.0'
    //     : '${appVersionCheckModel!.data![4].value}',
        v2 = '${version}';
    int v1Number = getExtendedVersionNumber(v1);
    int v2Number = getExtendedVersionNumber(v2);
    if (v1Number > v2Number && v1Number != v2Number) {
      if (Platform.isAndroid?
      appVersionCheckModel!.data![8].value == '1':
      appVersionCheckModel!.data![2].value == '1') {
        InternetConnectivity().check_connection_stream();
       // FlutterNativeSplash.remove();
        oneSignalNotificationConfigration().then((value) {
          show_Dialog(context!);
        });
        Navigator.of(context!).pop();
      } else {
        InternetConnectivity().check_connection_stream();
        //FlutterNativeSplash.remove();
        oneSignalNotificationConfigration().then((value) {
          show_Dialog_Splash(context!);
        });
        Navigator.of(context!).pop();
      }
    }
    else {
      print('call second object');
      InternetConnectivity().check_connection_stream();
      //FlutterNativeSplash.remove();
      oneSignalNotificationConfigration().then((value) {
        if (storage.hasData('userData')) {
          user_model = LoginModel.fromJson(storage.read('userData'));
          print('userData = ${user_model.toJson()}');
          Timer(Duration(seconds: 3), () {
            if (!active_noti_route) {
              Navigator.of(context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => BottomSheetCustom()));
            }
          });
        } else {
          Timer(Duration(seconds: 3), () {
            if (!active_noti_route) {
              Navigator.of(context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            }
          });
        }
      });
    }
  }

  show_Dialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "Please Update",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
              content: new Text(
                  "We have launched new app with bug fixes and performance improvements.",
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("UPDATE", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      String? url =
                          '${appVersionCheckModel!.data![6].value}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    } else if (Platform.isIOS) {
                      String? url =
                          '${appVersionCheckModel!.data![5].value}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    }
                  },
                ),
                CupertinoDialogAction(
                  child: Text("LATER", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    oneSignalNotificationConfigration().then((value) {
                      if (storage.hasData('userData')) {
                        user_model = LoginModel.fromJson(storage.read('userData'));
                        print('userData = ${user_model.toJson()}');
                        Timer(Duration(seconds: 3), () {
                          if (!active_noti_route) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => BottomSheetCustom()));
                          }
                        });
                      }
                      else {
                        Timer(Duration(seconds: 3), () {
                          if (!active_noti_route) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => LoginScreen()));
                          }
                        });
                      }
                    });

                    //Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  show_Dialog_Splash(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "Please Update",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
              content: new Text(
                  "We have launched new app with major bug fixes and performance improvements.",
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("UPDATE", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      String? url =
                          '${appVersionCheckModel!.data![6].value}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    } else if (Platform.isIOS) {
                      String? url =
                          '${appVersionCheckModel!.data![5].value}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    getLocation();
    appVersionCheck(context);
    InternetConnectivity().check_connection_stream();
    super.initState();
    // oneSignalNotificationConfigration().then((value) {
    //   if (storage.hasData('userData')) {
    //     user_model = LoginModel.fromJson(storage.read('userData'));
    //     print('userData = ${user_model.toJson()}');
    //     Timer(Duration(seconds: 3), () {
    //       if (!active_noti_route) {
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //             builder: (BuildContext context) => BottomSheetCustom()));
    //       }
    //     });
    //   } else {
    //     Timer(Duration(seconds: 3), () {
    //       if (!active_noti_route) {
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //             builder: (BuildContext context) => LoginScreen()));
    //       }
    //     });
    //   }
    // });
  }

  Future oneSignalNotificationConfigration() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(true);
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      /// jab hmari app background pa ho aur ham notification pa click kre
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      print(
          "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      Map<String, dynamic> map =
          jsonDecode(result.notification.jsonRepresentation());
      NotificationPayload payload = NotificationPayload.fromJson(map);
      bool isLogin = false;
      if (user_model.accessToken != null) {
        isLogin = true;
      }

      if (isLogin) {
        active_noti_route = true;
        if (payload.custom!.a!.action == 'order_detail') {
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => OrderDetail(
                      Id: payload.custom!.a!.orderId.toString(),
                      link: '',
                      boyName: 'boy name',
                      wareHouseName: 'Dubai Store')));
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print('jab hmari app on hoti ha ${event}');
      event.complete(null);
      print(
          "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      Map<String, dynamic> map =
          jsonDecode(event.notification.jsonRepresentation());
      print('this is eencoded string = $map');
      NotificationPayload payload = NotificationPayload.fromJson(map);
      var rng = Random();
      flutterLocalNotificationsPlugin!.show(
          rng.nextInt(100),
          '${payload.aps!.alert!.title}',
          '${payload.aps!.alert!.body}',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'channel.id',
              'channel.name',
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: event.notification.jsonRepresentation());
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      print(
          "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    OneSignal.shared
        .setSMSSubscriptionObserver((OSSMSSubscriptionStateChanges changes) {
      print("SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
      print("ON WILL DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDisplayInAppMessageHandler((message) {
      print("ON DID DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnWillDismissInAppMessageHandler((message) {
      print("ON WILL DISMISS IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
      print("ON DID DISMISS IN APP MESSAGE ${message.messageId}");
    });
    //ee51973c-8598-4461-88bb-08ad9f1b96a9 staging environments
    //597385b5-be97-4d21-bab6-36da07326eff live environments
    OneSignal.shared.setAppId("597385b5-be97-4d21-bab6-36da07326eff");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    // OneSignal.shared.setLaunchURLsInApp(false);
    Future.delayed(
      Duration(seconds: 2),
      () {
        _handleConsent();
      },
    );
    Future.delayed(
      Duration(seconds: 4),
      () {
        _handlePromptForPushPermission();
      },
    );
  }

  void _handlePromptForPushPermission() {
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  void _handleConsent() {
    OneSignal.shared.consentGranted(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
            height: 15.h,
            child: Image.asset(
              'assets/image/splash_logo.png',
            )),
      ),
    );
  }
}
