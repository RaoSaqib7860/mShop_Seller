class SaleReportYearModel {
  bool? result;
  String? reportUrl;
  Data? data;

  SaleReportYearModel({this.result, this.reportUrl, this.data});

  SaleReportYearModel.fromJson(Map<String, dynamic> json) {
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
  double? adminCommission;
  double? salesProfit;
  double? salesExpense;
  MonthWiseSales? monthWiseSales;
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
      this.monthWiseSales,
      this.storeName,
      this.storePhone});

  Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
    adminCommission = double.parse('${json['admin_commission']}');
    salesProfit = double.parse('${json['sales_profit']}');
    salesExpense = double.parse('${json['sales_expense']}');
    monthWiseSales = json['month_wise_sales'] != null
        ? json['month_wise_sales'] is List
            ? MonthWiseSales()
            : MonthWiseSales.fromJson(json['month_wise_sales'])
        : null;
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
    if (this.monthWiseSales != null) {
      data['month_wise_sales'] = this.monthWiseSales!.toJson();
    }
    data['store_name'] = this.storeName;
    data['store_phone'] = this.storePhone;
    return data;
  }
}

class MonthWiseSales {
  Apr2023? apr2023;
  May2023? may2023;

  MonthWiseSales({this.apr2023, this.may2023});

  MonthWiseSales.fromJson(Map<String, dynamic> json) {
    apr2023 = json['Apr 2023'] != null
        ? new Apr2023.fromJson(json['Apr 2023'])
        : null;
    may2023 = json['May 2023'] != null
        ? new May2023.fromJson(json['May 2023'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apr2023 != null) {
      data['Apr 2023'] = this.apr2023!.toJson();
    }
    if (this.may2023 != null) {
      data['May 2023'] = this.may2023!.toJson();
    }
    return data;
  }
}

class Apr2023 {
  int? numOfSales;
  dynamic deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;

  Apr2023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  Apr2023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'] is String
        ? int.parse(json['delivery_company_charges'])
        : json['delivery_company_charges'];
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

class May2023 {
  int? numOfSales;
  String? deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;

  May2023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  May2023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'].toString();
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
