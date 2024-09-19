import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';

import '../../../utils_services/colors_util.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/forgot_password_bloc.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/forgot_password_event.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/forgot_password_state.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/AppSize.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/text_field.dart';
import 'Otp_screen_for_reset_password.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  TextEditingController phoneController = TextEditingController();
  ForgotBloc forgotBloc = ForgotBloc(ForgotInitialState());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: height / 30,
                            ),
                            RichText(
                              text: new TextSpan(
                                  text: 'Forgot'.tr,
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 1,
                                      fontFamily: AppFonts.segoeui,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    new TextSpan(
                                      text: ' your '.tr,
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () => print('Tap Here onTap'),
                                    ),
                                    new TextSpan(
                                      text: 'password '.tr,
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () => print('Tap Here onTap'),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            Text(
                              'Enter your number below and we will send you a otp to reset your password.'
                                  .tr,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black54
                                    : Colors.white54,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.segoeui,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomTextFields(
                              controller: phoneController,
                              labelText: '5X XXX XXXX',
                              keyboredType: TextInputType.number,
                              max_length: 9,
                              padding: 0,
                              prefixIcon: Row(children: [
                                Text('+971'),
                                SizedBox(width: 5),
                              ], mainAxisSize: MainAxisSize.min),
                              validator: (value) {
                                print('${value!.length}');
                                if (value.length == 9) {
                                  return null;
                                } else {
                                  return 'Number should be 9 character'.tr;
                                }
                              },
                            ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(5.0),
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5.0),
                            //       color: Theme.of(context).brightness ==
                            //               Brightness.light
                            //           ? Colors.grey[100]
                            //           : Colors.black,
                            //       //Colors.grey[100],
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.grey[400]!,
                            //           offset: Offset(0.0, 1.0), //(x,y)
                            //           blurRadius: 6.0,
                            //         ),
                            //       ],
                            //     ),
                            //     child: TextFormField(
                            //       cursorColor: Colors.black,
                            //       keyboardType: TextInputType.text,
                            //       controller: phoneController,
                            //       decoration: new InputDecoration(
                            //           prefixIcon: Text('+971'),
                            //           border: InputBorder.none,
                            //           focusedBorder: InputBorder.none,
                            //           enabledBorder: InputBorder.none,
                            //           errorBorder: InputBorder.none,
                            //           disabledBorder: InputBorder.none,
                            //           contentPadding: EdgeInsets.only(
                            //               left: 15,
                            //               bottom: 11,
                            //               top: 15,
                            //               right: 15),
                            //           hintStyle: TextStyle(
                            //               color: Theme.of(context).brightness ==
                            //                       Brightness.light
                            //                   ? Colors.black26
                            //                   : Colors.white54,
                            //               fontSize: 14,
                            //               fontFamily: AppFonts.segoeui),
                            //           hintText: "Phone Number"),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: height / 40,
                            ),
                            InkWell(
                              onTap: () async {
                                if (InternetConnectivity.internet_available ==
                                    true) {
                                  if (formKey.currentState!.validate()) {
                                    forgotBloc.add(ForgotEvent(
                                        phone: phoneController.text));
                                  }
                                }else{
                                  snackBarSuccess('Internet connection not available');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: height / 19,
                                decoration: BoxDecoration(color: blueGrey),
                                child:
                                    BlocConsumer<ForgotBloc, ForgotScreenState>(
                                  bloc: forgotBloc,
                                  listener: (context, state) {
                                    if (state is ForgotErrorState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(state.error)));
                                    } else if (state is ForgotLoadedState) {
                                      // Get.offAll(OtpScreenForResetPassword());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OtpScreenForResetPassword(
                                                    number:
                                                        phoneController.text),
                                          ));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is ForgotLoadingState) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return Center(
                                        child: Text(
                                          "SEND".tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppFonts.segoeui),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Obx(() => controller.loading.value == true
            //     ? InkWell(
            //         onTap: () {
            //           controller.loading.value = false;
            //         },
            //         child: Container(
            //           height: height,
            //           width: width,
            //           child: Center(
            //             child: SpinKitPulse(
            //               color: Colors.white,
            //               size: 80.0,
            //             ),
            //           ),
            //           decoration:
            //               BoxDecoration(color: Colors.black.withOpacity(0.5)),
            //         ),
            //       )
            //     : SizedBox())
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }
}
