import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mShop_Seller/model/login/login_model.dart';
import 'package:mShop_Seller/utils_services/storage_util.dart';
import 'package:mShop_Seller/view/screens/bottom_sheet/bottom_sheet.dart';
import 'dart:io' show Platform;
import '../../../api_repo/basepath.dart';
import '../../../main.dart';
import '../../../model/Notification/notification_payload..dart';
import '../../../utils_services/GooogleMapSearchAddress.dart';
import '../../../utils_services/global_variable.dart';
import '../../conectivity/connectivity.dart';
import '../Check app version/maintenance_screen.dart';
import '../LoginPages/login_screen.dart';
import '../orders/order_detail.dart';

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

  appVersionCheck(BuildContext context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 0),
    ));
    await remoteConfig.fetchAndActivate();
    versionCheckApi(context);
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  String? version;
  versionCheckApi(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    final remoteConfig = FirebaseRemoteConfig.instance;
    baseURL = await remoteConfig.getString('base_url');
    var data = await remoteConfig
        .getString(Platform.isAndroid ? 'android_version' : 'ios_version');
    String v1 = '${data}', v2 = '${version}';
    print('versions = $v1 and $v2');
    int v1Number = getExtendedVersionNumber(v1);
    int v2Number = getExtendedVersionNumber(v2);
    print(
        'ios_match_version... ${await remoteConfig.getBool(Platform.isAndroid ? 'android_match_version' : 'ios_match_version')}');
    if (v1Number > v2Number && v1Number != v2Number) {
      if (await remoteConfig.getBool(Platform.isAndroid
              ? 'android_match_version'
              : 'ios_match_version') ==
          true) {
        InternetConnectivity().check_connection_stream();
        oneSignalNotificationConfigration().then((value) {
          show_Dialog_Splash(context);
        });
      } else {
        InternetConnectivity().check_connection_stream();
        oneSignalNotificationConfigration().then((value) {
          show_Dialog(context);
        });
        Navigator.of(context).pop();
      }
    } else {
      print('call second object');
      InternetConnectivity().check_connection_stream();
      oneSignalNotificationConfigration().then((value) async {
        if (await remoteConfig.getBool(Platform.isAndroid
            ? 'android_app_on_maintenance'
            : 'ios_app_on_maintenance')) {
          print('on mainntanncae');
          Future.delayed(Duration(milliseconds: 3000), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MaintenanceScreen()));
          });
        } else {
          if (storage.hasData('userData')) {
            user_model = LoginModel.fromJson(storage.read('userData'));
            print('userData = ${user_model.toJson()}');
            Timer(Duration(seconds: 3), () {
              if (!active_noti_route) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => BottomSheetCustom()));
              }
            });
          } else {
            Timer(Duration(seconds: 3), () {
              if (!active_noti_route) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              }
            });
          }
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
                    final remoteConfig = FirebaseRemoteConfig.instance;
                    if (Platform.isAndroid) {
                      String? url =
                          await remoteConfig.getString('android_app_url');
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    } else if (Platform.isIOS) {
                      String? url = await remoteConfig.getString('ios_app_url');
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    }
                  },
                ),
                CupertinoDialogAction(
                  child: Text("LATER", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    oneSignalNotificationConfigration().then((value) {
                      if (storage.hasData('userData')) {
                        user_model =
                            LoginModel.fromJson(storage.read('userData'));
                        print('userData = ${user_model.toJson()}');
                        Timer(Duration(seconds: 3), () {
                          if (!active_noti_route) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomSheetCustom()));
                          }
                        });
                      } else {
                        Timer(Duration(seconds: 3), () {
                          if (!active_noti_route) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginScreen()));
                          }
                        });
                      }
                    });
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
                    final remoteConfig = FirebaseRemoteConfig.instance;
                    if (Platform.isAndroid) {
                      String? url =
                          await remoteConfig.getString('android_app_url');
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    } else if (Platform.isIOS) {
                      String? url = await remoteConfig.getString('ios_app_url');
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
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
