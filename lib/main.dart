import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_translator/google_translator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/providers/add_product_provider.dart';
import 'package:mShop_Seller/translator/translator.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/view/screens/SplashScreen/splash_screen.dart';
import 'extentions/common_localization.dart';
import 'model/login/login_model.dart';
import 'providers/profile_provider.dart';
import 'utils_services/storage_util.dart';
import 'view/global_widgets/StatusBarStyle.dart';
import 'view/screens/LoginPages/otp_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final ValueNotifier<LanguageModel> language = ValueNotifier<LanguageModel>(
    LanguageModel(fromLanguage: Locale('ar'), toLanguage: Locale('en')));
AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
void main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kIsWeb) {
    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   importance: Importance.high,
    // );
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // await flutterLocalNotificationsPlugin!
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel!);
    // var initializationSettingsAndroid =
    //     const AndroidInitializationSettings('@drawable/icon_menu_car_no');
    // var initializationSettingsIOs = const DarwinInitializationSettings();
    // var initSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    // flutterLocalNotificationsPlugin?.initialize(initSettings,
    //     onDidReceiveNotificationResponse: (payload) {
    //   print('onDidReceiveNotificationResponse = ${payload}');
    // }, onDidReceiveBackgroundNotificationResponse: (payload) {
    //   print('onDidReceiveBackgroundNotificationResponse = ${payload}');
    // });
  }
  if (storage.hasData('userData')) {
    user_model = LoginModel.fromJson(storage.read('userData'));
  }

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String apiKey = "AIzaSyCxVDrGwK3_-wlauORHJ1HuJkoZ5LNAdIQ";
  ThemeMode _themeMode = ThemeMode.light;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: language,
      builder: (context, value, child) {
        return GoogleTranslatorInit(
          apiKey,
          builder: () => Sizer(
            builder: (context, orientation, deviceType) {
              return MultiProvider(
                providers: [
                  ListenableProvider<ProfileProvider>(
                      create: (_) => ProfileProvider()),
                  ListenableProvider<AddProductProvider>(
                      create: (_) => AddProductProvider()),
                  ListenableProvider<OtpScreenProvider>(
                      create: (_) => OtpScreenProvider()),
                  // ListenableProvider<OtpScreenForResetProvider>(
                  //     create: (_) => OtpScreenForResetProvider()),
                ],
                child: GetMaterialApp(
                  translations: LocalString(),
                  // locale: Locale('en', 'US'),
                  useInheritedMediaQuery: true,
                  navigatorKey: navigatorKey,
                  //locale: DevicePreview.locale(context),
                  // builder: DevicePreview.appBuilder,
                  theme: ThemeData.light(),
                  // darkTheme: ThemeData.dark(),
                  themeMode: _themeMode,
                  darkTheme: ThemeData.light(),
                  home: statusBarStyle(child: SplashScreen()),
                  debugShowCheckedModeBanner: false,
                ),
              );
            },
          ),
          translateFrom: value.fromLanguage,
          translateTo: value.toLanguage,
        );
      },
    );
  }
}
