abstract class resetPasswordConfirmedScreenState{

}

class resetPasswordConfirmedInitialState extends resetPasswordConfirmedScreenState{

}
class resetPasswordConfirmedLoadingState extends resetPasswordConfirmedScreenState{

}
class resetPasswordConfirmedLoadedState extends resetPasswordConfirmedScreenState{
  bool? response;
  resetPasswordConfirmedLoadedState({required this.response});
}
class resetPasswordConfirmedErrorState extends resetPasswordConfirmedScreenState{
  String error;
  resetPasswordConfirmedErrorState({required this.error});
}