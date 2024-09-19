import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/view/global_widgets/AppSize.dart';
import 'package:mShop_Seller/view/global_widgets/snakbar.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc_events.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc_states.dart';

import '../../../view_model/signup_bloc_function/signup_repository.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/app_font.dart';
import '../../global_widgets/text_field.dart';
import '../../global_widgets/web_view_global.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignupRepository {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                            height: 180,
                            child: SvgPicture.asset('assets/svgs/app_logo.svg')),
                        CustomTextFields(
                          controller: nameController,
                          labelText: 'Full Name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter full name'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        CustomTextFields(
                          controller: shopNameController,
                          labelText: 'Shop Name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter shop name'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        CustomTextFields(
                          controller: emailController,
                          labelText: 'Email'.tr,
                          validator: (value) {
                            if (!EmailValidator.validate(value!))
                              return 'Enter Valid Email'.tr;
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        Row(
                          children: [
                            //SizedBox(width: 20),
                            // InkWell(
                            //   onTap: () {
                            //     // showCountryPicker(
                            //     //   context: context,
                            //     //   showPhoneCode: true,
                            //     //   onSelect: (Country country) {
                            //     //     seelected_phone = '${country.phoneCode}';
                            //     //     selected_imoji_flag = '${country.flagEmoji}';
                            //     //     setState(() {});
                            //     //   },
                            //     // );
                            //   },
                            //   child: Row(children: [
                            //     Text('+${seelected_phone}'),
                            //     SizedBox(width: 5),
                            //     Text('${selected_imoji_flag}',
                            //         style: TextStyle(fontSize: 30)),
                            //   ]),
                            // ),
                            Expanded(
                              child: CustomTextFields(
                                controller: phoneController,
                                labelText: '5X XXX XXXX',
                                keyboredType: TextInputType.number,
                                max_length: 9,
                                prefixIcon: Row(children: [
                                  Text('+${seelected_phone}'),
                                  SizedBox(width: 5),
                                ], mainAxisSize: MainAxisSize.min),
                                onchaged: (v) {
                                  if (v.length == 1 && v == '0') {
                                    phoneController.text = '';
                                  }
                                },
                                validator: (value) {
                                  print('${value!.length}');
                                  if (value.length == 9) {
                                    return null;
                                  } else {
                                    return 'Number should be 9 character'.tr;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        CustomTextFields(
                          controller: passwordController,
                          labelText: 'Password'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the password '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        CustomTextFields(
                          controller: confirmPasswordController,
                          labelText: 'Confirm Password'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the password '.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Container(
                          width: 35.h,
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                  fontFamily: AppFonts.segoeui,
                                  fontSize: 12,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xff000000)
                                      : Colors.white
                                  //color: const Color(0xff000000),
                                  ),
                              children: [
                                TextSpan(
                                  text:
                                      'By signup you are agree to the Housy,'.tr,
                                ),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebViewGlobal(
                                              url:
                                                  'https://housy.ae/pages/policies/privacy-policy/',
                                              title: 'Privacy Policy',
                                            ),
                                          ));
                                    },
                                  text: ' Privacy Policy'.tr,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color(0xff192129)
                                        : Colors.blue,
                                    // color: const Color(0xff192129),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                ),
                                TextSpan(text: ' and'),
                                TextSpan(
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebViewGlobal(
                                              url:
                                                  'https://housy.ae/pages/policies/terms-conditions/',
                                              title: 'Terms & Condition',
                                            ),
                                          ));
                                    },
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color(0xff192129)
                                        : Colors.blue,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppFonts.segoeui,
                                  ),
                                  text: ' Terms & Condition '.tr,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        InkWell(
                          onTap: () async {
                            if(InternetConnectivity.internet_available == true){
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  signUpBloc.add(SignUpEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      shop_name: shopNameController.text,
                                      context: context,
                                      confirmPassword:
                                      confirmPasswordController.text));
                                } else {
                                  snackBarFailer('Password did not match'.tr);
                                }
                              }
                            }else{
                              snackBarSuccess('Internet connection not available');
                            }

                          },
                          child: Container(
                            width: 250.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xff192129),
                            ),
                            child: BlocConsumer<SignUpBloc, SignUpScreenState>(
                              bloc: signUpBloc,
                              listener: (context, state) {
                                if (state is SignUpErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.error)));
                                }
                              },
                              builder: (context, state) {
                                if (state is SignUpLoadingState) {
                                  return Center(
                                      child: SpinKitPulse(
                                    color: Colors.white,
                                    size: 30.0,
                                  ));
                                } else {
                                  return Center(
                                    child: Text(
                                      'Sign UP'.tr,
                                      style: TextStyle(
                                        fontFamily: AppFonts.segoeui,
                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    shopNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
