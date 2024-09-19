class MonthlySaleModel {
  bool? result;
  String? reportUrl;
  Data? data;

  MonthlySaleModel({this.result, this.reportUrl, this.data});

  MonthlySaleModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    reportUrl = json['report_url'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['report_url'] = this.reportUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? month;
  String? year;
  int? numOfSales;
  dynamic deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;
  List<DateWiseSales>? dateWiseSales=[];
  String? storeName;
  dynamic storePhone;

  Data(
      {this.month,
      this.year,
      this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense,
      this.dateWiseSales,
      this.storeName,
      this.storePhone});

  Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
    adminCommission = json['admin_commission'];
    salesProfit = json['sales_profit'];
    salesExpense = json['sales_expense'];
    if (json['date_wise_sales'] is Map) {
      Map map = json['date_wise_sales'];
      dateWiseSales = map.entries.map((e) {
        return DateWiseSales(
            name: '${e.key}', months_data: Apr062023.fromJson(e.value));
      }).toList();
    }
    storeName = json['store_name'];
    storePhone = json['store_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['num_of_sales'] = this.numOfSales;
    data['delivery_company_charges'] = this.deliveryCompanyCharges;
    data['admin_commission'] = this.adminCommission;
    data['sales_profit'] = this.salesProfit;
    data['sales_expense'] = this.salesExpense;
    data['store_name'] = this.storeName;
    data['store_phone'] = this.storePhone;
    return data;
  }
}

class DateWiseSales {
  String? name;
  Apr062023? months_data;

  DateWiseSales({this.name, this.months_data});

  DateWiseSales.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    months_data = json['May 17 2023'] != null
        ? new Apr062023.fromJson(json['May 17 2023'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.months_data != null) {
      data['May 17 2023'] = this.months_data!.toJson();
    }
    return data;
  }
}

class Apr062023 {
  int? numOfSales;
  int? deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;

  Apr062023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  Apr062023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = int.parse('${json['delivery_company_charges']}');
    adminCommission = json['admin_commission'];
    salesProfit = json['sales_profit'];
    salesExpense = json['sales_expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_of_sales'] = this.numOfSales;
    data['delivery_company_charges'] = this.deliveryCompanyCharges;
    data['admin_commission'] = this.adminCommission;
    data['sales_profit'] = this.salesProfit;
    data['sales_expense'] = this.salesExpense;
    return data;
  }
}
