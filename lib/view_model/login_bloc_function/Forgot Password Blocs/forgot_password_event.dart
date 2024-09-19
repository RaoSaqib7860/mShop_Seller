abstract class ForgotScreenEvents{
  const ForgotScreenEvents();

}
class ForgotEvent extends ForgotScreenEvents{
  String? phone;
  ForgotEvent({this.phone});

}