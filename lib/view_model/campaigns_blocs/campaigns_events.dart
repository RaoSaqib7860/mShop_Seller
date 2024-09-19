abstract class MyCompaignsEvents{
  const MyCompaignsEvents();

}
class MyCompaignsEvent extends MyCompaignsEvents {
int? count;
int? page;
  MyCompaignsEvent({this.count,this.page});

}