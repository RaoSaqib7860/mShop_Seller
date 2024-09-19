import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';

import '../../../view_model/login_bloc_function/Forgot Password Blocs/Reset Password Confirmed/reset_password_confirmed_bloc.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/Reset Password Confirmed/reset_password_confirmed_events.dart';
import '../../../view_model/login_bloc_function/Forgot Password Blocs/Reset Password Confirmed/reset_password_confirmed_states.dart';
import '../../../view_model/login_bloc_function/login_bloc.dart';
import '../../../view_model/login_bloc_function/login_bloc_states.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/AppSize.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/text_field.dart';

class PasswordResetScreen extends StatefulWidget {
  final String? user_id;
  final String? number;

  const PasswordResetScreen({Key? key, this.user_id, this.number})
      : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  resetPasswordConfirmedBloc resetPasswordBloc =
      resetPasswordConfirmedBloc(resetPasswordConfirmedInitialState());
  TextEditingController p1Con = TextEditingController();
  TextEditingController p2Con = TextEditingController();
  LoginBloc loginBloc = LoginBloc(LoginInitialState());

  @override
  void initState() {
    print('user id is = ${widget.user_id}');
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CreatePasswordController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.020,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Confirm your password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w400),
                          ).translate(),
                          //RichText(
                          //  text: new TextSpan(
                          //      text: 'Confirm'.tr,
                          //      style: TextStyle(
                          //          color: Colors.black,
                          //          fontSize: 22,
                          //          fontWeight: FontWeight.w400),
                          //      children: [
                          //        new TextSpan(
                          //          text: ' your'.tr,
                          //          style: TextStyle(color: Colors.black),
                          //          recognizer: new TapGestureRecognizer()
                          //            ..onTap = () => print('Tap Here onTap'),
                          //        ),
                          //        new TextSpan(
                          //          text: ' password'.tr,
                          //          recognizer: new TapGestureRecognizer()
                          //            ..onTap = () => print('Tap Here onTap'),
                          //        ),
                          //        new TextSpan(
                          //          style: TextStyle(color: Colors.black),
                          //          text: ''.tr,
                          //          recognizer: new TapGestureRecognizer()
                          //            ..onTap = () => print('Tap Here onTap'),
                          //        )
                          //      ]),
                          //),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please enter the new password.'.tr,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ).translate(),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextFields(
                            controller: p1Con,
                            padding: 0,
                            labelText: 'Password'.tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the password '.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(5.0),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5.0),
                          //       color: Colors.grey[100],
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.grey[400]!,
                          //           offset: Offset(0.0, 1.0),
                          //           blurRadius: 6.0,
                          //         ),
                          //       ],
                          //     ),
                          //     child: TextFormField(
                          //       controller: p1Con,
                          //       cursorColor: Colors.black,
                          //       keyboardType: TextInputType.text,
                          //       decoration: new InputDecoration(
                          //           prefixIcon: Icon(
                          //             Icons.lock_outline,
                          //             color: Colors.black26,
                          //           ),
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.only(
                          //               left: 15, bottom: 11, top: 11, right: 15),
                          //           hintStyle: TextStyle(
                          //               color: Colors.black26, fontSize: 12),
                          //           hintText: "New Password".tr),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFields(
                            controller: p2Con,
                            labelText: 'New Password'.tr,
                            padding: 0,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the password '.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(5.0),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5.0),
                          //       color: Colors.grey[100],
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.grey[400]!,
                          //           offset: Offset(0.0, 1.0),
                          //           blurRadius: 6.0,
                          //         ),
                          //       ],
                          //     ),
                          //     child: TextFormField(
                          //       controller: p2Con,
                          //       cursorColor: Colors.black,
                          //       keyboardType: TextInputType.text,
                          //       decoration: new InputDecoration(
                          //           prefixIcon: Icon(
                          //             Icons.lock_outline,
                          //             color: Colors.black26,
                          //           ),
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.only(
                          //               left: 15, bottom: 11, top: 11, right: 15),
                          //           hintStyle: TextStyle(
                          //               color: Colors.black26, fontSize: 14),
                          //           hintText: "Confirm Password".tr),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (InternetConnectivity.internet_available ==
                                  true) {
                                if (formKey.currentState!.validate()) {
                                  if (p1Con.text == p2Con.text) {
                                    resetPasswordBloc.add(
                                        resetPasswordConfirmedEvent(
                                            userId: widget.user_id,
                                            password: p1Con.text,
                                            number: widget.number,
                                            context: context,
                                            confirmed_password: p2Con.text));
                                  } else {
                                    snackBarFailer('Password did not match'.tr);
                                  }
                                }
                              }else{
                                snackBarSuccess('Internet connection not available');
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              color: blueGrey,
                              child: BlocConsumer<resetPasswordConfirmedBloc,
                                  resetPasswordConfirmedScreenState>(
                                bloc: resetPasswordBloc,
                                listener: (context, state) {
                                  if (state
                                      is resetPasswordConfirmedErrorState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.error)));
                                  } else if (state
                                      is resetPasswordConfirmedLoadedState) {
                                    // Get.offAll(OtpScreenForResetPassword());
                                  }
                                },
                                builder: (context, state) {
                                  if (state
                                      is resetPasswordConfirmedLoadingState) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Center(
                                      child: Text(
                                        "SUBMIT".tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    p1Con.dispose();
    p2Con.dispose();
  }
}

// class CreatePasswordController extends GetxController {
//   TextEditingController p1Con = TextEditingController();
//   TextEditingController p2Con = TextEditingController();
//   TextEditingController otpCon = TextEditingController();
//
//   var absecuretext = false.obs;
//   var absecureotp = false.obs;
//   var loading = false.obs;
// }
