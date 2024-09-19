abstract class SubCategoriesOfCategoriesScreenEvents{
  const SubCategoriesOfCategoriesScreenEvents();

}
class SubCategoriesOfCategoriesEvent extends SubCategoriesOfCategoriesScreenEvents{
  dynamic CategoryID;
  int? page;
  SubCategoriesOfCategoriesEvent({this.CategoryID,this.page});

}