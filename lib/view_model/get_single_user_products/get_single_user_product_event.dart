abstract class GetSingleUserProductEvents{
  const GetSingleUserProductEvents();
}
class SingleUserProductEvent extends GetSingleUserProductEvents{
  String? Id;
  SingleUserProductEvent({this.Id});
}
