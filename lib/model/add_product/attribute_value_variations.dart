class AttributeValuesVariations {
  String? name;
  String? price;
  String? sku;
  String? quantity;
  List<String>? photos;
  AttributeValuesVariations(
      {required this.name,
      this.sku = '',
      this.price = '',
      this.quantity = '',
      required this.photos});
}
