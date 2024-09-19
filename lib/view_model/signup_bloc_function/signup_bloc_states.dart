abstract class SignUpScreenState{

}

class SignUpInitialState extends SignUpScreenState{

}
class SignUpLoadingState extends SignUpScreenState{

}
class SignUpLoadedState extends SignUpScreenState{
  bool? response;
  SignUpLoadedState({required this.response});
}
class SignUpErrorState extends SignUpScreenState{
  String error;
  SignUpErrorState({required this.error});
}