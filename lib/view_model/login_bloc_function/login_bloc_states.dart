

abstract class LoginScreenState{

}

class LoginInitialState extends LoginScreenState{

}
class LoginLoadingState extends LoginScreenState{

}
class LoginLoadedState extends LoginScreenState{
bool? response;
LoginLoadedState({required this.response});
}
class LoginErrorState extends LoginScreenState{
  String error;
  LoginErrorState({required this.error});
}