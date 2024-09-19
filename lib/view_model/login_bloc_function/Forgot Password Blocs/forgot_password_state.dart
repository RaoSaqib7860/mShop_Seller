abstract class ForgotScreenState{

}

class ForgotInitialState extends ForgotScreenState{

}
class ForgotLoadingState extends ForgotScreenState{

}
class ForgotLoadedState extends ForgotScreenState{
  bool? response;
  ForgotLoadedState({required this.response});
}
class ForgotErrorState extends ForgotScreenState{
  String error;
  ForgotErrorState({required this.error});
}