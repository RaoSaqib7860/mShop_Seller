abstract class MyWareHouseListEvents{
  const MyWareHouseListEvents();

}
class MyWareHouseListEvent extends MyWareHouseListEvents {
int? page;
int? count;
  MyWareHouseListEvent({this.page,this.count});

}