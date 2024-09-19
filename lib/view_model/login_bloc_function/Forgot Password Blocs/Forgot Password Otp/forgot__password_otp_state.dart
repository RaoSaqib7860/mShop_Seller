import '../../../../model/password_reset/confirm_reset.dart';

abstract class ForgotPasswordOtpScreenState{

}

class ForgotPasswordOtpInitialState extends ForgotPasswordOtpScreenState{

}
class ForgotPasswordOtpLoadingState extends ForgotPasswordOtpScreenState{

}
class ForgotPasswordOtpLoadedState extends ForgotPasswordOtpScreenState{
  ConfirmReset? response;
  bool? res;
  ForgotPasswordOtpLoadedState({required this.response,this.res});
}
class ForgotPasswordOtpErrorState extends ForgotPasswordOtpScreenState{
  String error;
  ForgotPasswordOtpErrorState({required this.error});
}