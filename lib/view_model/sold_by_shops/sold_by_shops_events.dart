abstract class ShopProductEvents {
  const ShopProductEvents();
}

class ShopProductEvent extends ShopProductEvents {
  String? Id;
  bool? is_brand;
  bool? is_stages;
  ShopProductEvent({this.Id, this.is_brand = false, this.is_stages = false});
}
