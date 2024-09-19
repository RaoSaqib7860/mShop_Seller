import 'package:mShop_Seller/model/add_product/attribute.dart' as attr;

class SelectedAttributeAndTheirValues {
  attr.Data? selected_attr;
  bool? variation;
  List<attr.Values>? list_selected_attr_values;
  attr.Values? selected_attr_value;
  SelectedAttributeAndTheirValues(
      {this.list_selected_attr_values, this.selected_attr, this.variation,this.selected_attr_value});
}
