import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/view/global_widgets/Sackbars.dart';

import '../../../utils_services/colors_util.dart';
import '../bottom_sheet/bottom_sheet.dart';

class OtpScreens extends StatefulWidget {
  final String? email;
  final String? number;
  final String? password;
  final bool? send_otp;

  OtpScreens({
    Key? key,
    this.email,
    this.password,
    this.number,
    this.send_otp = false,
  }) : super(key: key);

  @override
  _OtpScreensState createState() => _OtpScreensState();
}

class _OtpScreensState extends State<OtpScreens> {
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  bool isotp = false;

  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  int second = 30;

  void startTimer() {
    const onesec = Duration(seconds: 1);
    _timer = Timer.periodic(onesec, (timer) {
      setState(() {
        if (second < 1) {
          isotp = false;
          second = 30;
          _timer!.cancel();
        } else {
          second = second - 1;
          if (isotp == false) {
            isotp = true;
          }
        }
      });
    });
  }

  @override
  void initState() {
    if (widget.send_otp!) {
      DataProvider.auth_resend_code({'phone': widget.number});
    }
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<OtpScreenProvider>(context);
    var height = Get.height;
    var width = Get.width;
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.only(left: width / 15, right: width / 15),
              child: ListView(
                children: [
                  SizedBox(
                    height: height / 7,
                  ),
                  Center(
                      child: Text(
                    'Verify Code'.tr,
                    style: TextStyle(
                        fontSize: 19,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600),
                  )),
                  SizedBox(
                    height: height / 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: width / 1.4,
                      child: Column(
                        children: [
                          Text(
                            'Enter verification code we sent at +971${widget.number}'
                                .tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          length: 6,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(6),
                          ],
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 5) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            inactiveColor: offBlackAvatr,
                            inactiveFillColor: offBlackAvatr,
                            fieldHeight: 50,
                            activeColor: offBlackAvatr,
                            fieldWidth: 40,
                            selectedFillColor: blueGrey,
                            activeFillColor: Colors.white,
                            selectedColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? blueGrey
                                    : Colors.black,
                            // selectedFillColor: Theme.of(context).brightness ==
                            //         Brightness.light
                            //     ? Colors.white
                            //     : Colors.black
                            // activeFillColor: hasError ? Colors.black : Colors.white,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          // backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          onCompleted: (v) async {
                            _provider.setloading(true);
                            bool result = await DataProvider.verify_Otp({
                              'verification_code': textEditingController.text,
                            });
                            if (result) {
                              await DataProvider().loginFunction(
                                  Email: widget.email,
                                  Password: widget.password);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BottomSheetCustom()));
                              snackBarSuccess('Verify Successfully'.tr);
                            }
                            _provider.setloading(false);
                          },
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                          appContext: context,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError
                          ? "Please fill up all the cells properly".tr
                          : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  InkWell(
                    child: Center(
                        child: Text(
                      'Clear Text'.tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    )),
                    onTap: () {
                      textEditingController.clear();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Didn\'t receive the code? '.tr,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black54
                                    : Colors.white,
                            fontSize: 13),
                      ),
                      InkWell(
                        onTap: () async {
                          if (isotp == false) {
                            _provider.setloading(true);
                            startTimer();
                            await DataProvider.auth_resend_code(
                                {'phone': widget.number});
                            _provider.setloading(false);
                            snackBarSuccess('Otp sent to the mobile');
                          }
                        },
                        child: Text(
                            isotp == false
                                ? 'RESEND'.tr
                                : 'Wait 30 seconds = '.tr,
                            style: TextStyle(
                                color:
                                    isotp == false ? blueGrey : Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ),
                      Text(isotp == false ? '' : '00:$second',
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? offBlackAvatr
                                  : Colors.white,
                              //color: offBlackAvatr,
                              fontWeight: FontWeight.w500,
                              fontSize: 14))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
            _provider.loading == true
                ? InkWell(
                    onTap: () {
                      _provider.setloading(false);
                    },
                    child: Container(
                      height: height,
                      width: width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class OtpScreenProvider extends ChangeNotifier {
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    _phoneController.dispose();
  }
  TextEditingController get phoneController => _phoneController;
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool v) {
    _loading = v;
    notifyListeners();
  }
}
