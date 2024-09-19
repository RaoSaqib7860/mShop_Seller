abstract class SubCategoriesScreenEvents{
  const SubCategoriesScreenEvents();

}
class SubCategoriesEvent extends SubCategoriesScreenEvents{
  dynamic ID;
  dynamic catId;
  int? page;
  final bool? has_sub_cat;
  SubCategoriesEvent( {this.ID,this.catId,this.page,required this.has_sub_cat});

}