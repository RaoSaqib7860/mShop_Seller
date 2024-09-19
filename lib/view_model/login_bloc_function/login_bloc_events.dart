abstract class LoginScreenEvents{
  const LoginScreenEvents();

}
class LoginEvent extends LoginScreenEvents{
  String? email;
  String? password;
  LoginEvent({this.email,this.password});

}