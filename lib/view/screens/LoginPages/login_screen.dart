import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';
import 'package:mShop_Seller/utils_services/storage_util.dart';
import 'package:mShop_Seller/view/global_widgets/AppColors.dart';
import 'package:mShop_Seller/view/screens/LoginPages/send_otp_screen.dart';
import 'package:mShop_Seller/view/screens/LoginPages/sign_up.dart';
import 'package:mShop_Seller/view/screens/SplashScreen/splash_screen.dart';
import 'package:mShop_Seller/view_model/login_bloc_function/login_bloc.dart';

import '../../../view_model/login_bloc_function/login_bloc_events.dart';
import '../../../view_model/login_bloc_function/login_bloc_states.dart';
import '../../../view_model/login_bloc_function/login_repository.dart';
import '../../conectivity/connectivity.dart';
import '../../global_widgets/Sackbars.dart';
import '../../global_widgets/app_font.dart';
import '../../global_widgets/text_field.dart';
import '../Check app version/maintenance_screen.dart';
import '../bottom_sheet/bottom_sheet.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginRepository {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 15.0.h,
                ),
                Container(
                  height: 100,
                  child: Image.asset('assets/image/logo_circle.png'),
                ),
                SizedBox(
                  height: 7.0.h,
                ),
                CustomTextFields(
                  controller: emailController,
                  labelText: 'Email or 05X XXX XXXX'.tr,
                  validator: validate_email_phone,
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                CustomTextFields(
                  controller: passwordController,
                  labelText: 'Password'.tr,
                  visible: !isPasswordShow,
                  validator: validate_password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (isPasswordShow) {
                        isPasswordShow = false;
                      } else {
                        isPasswordShow = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !isPasswordShow ? Colors.grey[500] : blueGrey,
                    ),
                  ),
                ),
                Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendOtpScreen(),
                          ));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 10, left: 20),
                      child: Text(
                        'Forgot Password?'.tr,
                        style: TextStyle(
                            fontFamily: AppFonts.segoeui,
                            fontSize: 12,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff000000)
                                    : Colors.white
                            //color: const Color(0xff000000),
                            ),
                      ),
                    ),
                  ),
                ], mainAxisAlignment: MainAxisAlignment.end),
                SizedBox(
                  height: 6.0.h,
                ),
                InkWell(
                  onTap: () {
                    if(appVersionCheckModel!.data![3].value == '2'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceScreen(),));
                    }else{
                      if(InternetConnectivity.internet_available == true){
                        if (formKey.currentState!.validate()) {
                          loginBloc.add(LoginEvent(
                              email: emailController.text,
                              password: passwordController.text));
                        }
                      }else{
                        snackBarSuccess('Internet connection not available');
                      }
                    }


                  },
                  child: Container(
                    width: 250.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xff192129),
                    ),
                    child: BlocConsumer<LoginBloc, LoginScreenState>(
                      bloc: loginBloc,
                      listener: (context, state) {
                        if (state is LoginErrorState) {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(content: Text(state.error)));
                        } else if (state is LoginLoadedState) {
                          if (user_model.user!.phoneVerified == false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreens(
                                    password: storage.read('user_password'),
                                    email: user_model.user!.email,
                                    number: user_model.user!.phone,
                                  ),
                                ));
                          } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BottomSheetCustom()));
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return Center(
                              child: SpinKitPulse(
                            color: Colors.white,
                            size: 30.0,
                          ));
                        } else {
                          return Center(
                            child: Text(
                              'LOG IN'.tr,
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
                  height: 3.0.h,
                ),
                InkWell(
                  onTap: (){
                    if(appVersionCheckModel!.data![4].value == '2'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceScreen(),));
                    }else{
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (c) => SignUpScreen()));
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 12,
                          color: Theme.of(context).brightness == Brightness.light
                              ? Color(0xff000000)
                              : Colors.white
                          //color: const Color(0xff000000),
                          ),
                      children: [
                        TextSpan(
                          text: 'Do not have an Account?   '.tr,
                        ),
                        TextSpan(
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              if(appVersionCheckModel!.data![4].value == '2'){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MaintenanceScreen(),));
                              }else{
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (c) => SignUpScreen()));
                              }
                            },
                          text: 'Sign up'.tr,
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Color(0xff192129)
                                : Colors.white,
                            //color: const Color(0xff192129),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.segoeui,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
