import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';

import '../../../utils_services/colors_util.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/Forgot Password Otp/forgot__password_otp_bloc.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/Forgot Password Otp/forgot__password_otp_event.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/Forgot Password Otp/forgot__password_otp_state.dart';

class OtpScreenForResetPassword extends StatefulWidget {
  final String? number;

  OtpScreenForResetPassword({
    Key? key,
    this.number,
  }) : super(key: key);

  @override
  _OtpScreenForResetPasswordState createState() =>
      _OtpScreenForResetPasswordState();
}

class _OtpScreenForResetPasswordState extends State<OtpScreenForResetPassword> {
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  ForgotPasswordOtpBloc forgotPasswordOtpBloc =
      ForgotPasswordOtpBloc(ForgotPasswordOtpInitialState());

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
    //final _provider = Provider.of<OtpScreenForResetProvider>(context);
    var height = Get.height;
    var width = Get.width;
    return SafeArea(
      child: Listener(
        onPointerDown: (PointerDownEvent event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
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
                              'Enter the verification code we just sent you at'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400),
                            ).translate(),
                            Text(
                              '+971${widget.number}'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400),
                            ).translate(),
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
                              selectedColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? blueGrey
                                  : Colors.black,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: Colors.white,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            onCompleted: (v) async {
                              forgotPasswordOtpBloc.add(ForgotPasswordOtpEvent(
                                  phone: textEditingController.text,
                                  number: widget.number,
                                  context: context));
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
                          color: Colors.black,
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
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        InkWell(
                          onTap: () async {
                            startTimer();
                            await DataProvider.auth_resend_phone_code({
                              'phone': widget.number,
                            });
                          },
                          child: Text(
                              isotp == false
                                  ? 'RESEND'.tr
                                  : 'Wait 30 seconds = '.tr,
                              style: TextStyle(
                                  color: isotp == false
                                      ? blueGrey
                                      : Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                        Text(isotp == false ? '' : '00:$second',
                            style: TextStyle(
                                color: offBlackAvatr,
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
              // _provider.loading == true
              //     ? InkWell(
              //         onTap: () {
              //           _provider.setloading(false);
              //         },
              //         child: Container(
              //           height: height,
              //           width: width,
              //           child: Center(
              //             child: CircularProgressIndicator(),
              //           ),
              //           decoration:
              //               BoxDecoration(color: Colors.black.withOpacity(0.5)),
              //         ),
              //       )
              //     : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
//
// class OtpScreenForResetProvider extends ChangeNotifier {
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController get phoneController => _phoneController;
//   bool _loading = false;
//   bool get loading => _loading;
//   setloading(bool v) {
//     _loading = v;
//     notifyListeners();
//   }
// }
