class TotalSaleModel {
  bool? result;
  String? reportUrl;
  Data? data;

  TotalSaleModel({this.result, this.reportUrl, this.data});

  TotalSaleModel.fromJson(Map<String, dynamic> json) {
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
  int? numOfSales;
  dynamic deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;
  DateWiseSales? dateWiseSales;
  String? storeName;
  dynamic storePhone;
  String? day;
  String? month;
  String? year;

  Data(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense,
      this.dateWiseSales,
      this.storeName,
      this.storePhone,
      this.day,
      this.month,
      this.year});

  Data.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
    adminCommission = json['admin_commission'];
    salesProfit = json['sales_profit'];
    salesExpense = json['sales_expense'];
    dateWiseSales = json['date_wise_sales'] != null &&
            json['date_wise_sales'] is Map<String, dynamic>
        ? new DateWiseSales.fromJson(json['date_wise_sales'])
        : null;
    storeName = json['store_name'];
    storePhone = json['store_phone'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_of_sales'] = this.numOfSales;
    data['delivery_company_charges'] = this.deliveryCompanyCharges;
    data['admin_commission'] = this.adminCommission;
    data['sales_profit'] = this.salesProfit;
    data['sales_expense'] = this.salesExpense;
    if (this.dateWiseSales != null) {
      data['date_wise_sales'] = this.dateWiseSales!.toJson();
    }
    data['store_name'] = this.storeName;
    data['store_phone'] = this.storePhone;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    return data;
  }
}

class DateWiseSales {
  Apr062023? apr062023;
  Apr072023? apr072023;
  Apr062023? apr082023;
  Apr092023? apr092023;
  Apr092023? apr112023;
  Apr072023? apr122023;
  Apr062023? apr152023;
  Apr072023? apr162023;
  May172023? may172023;
  Apr092023? may182023;
  Apr092023? may192023;

  DateWiseSales(
      {this.apr062023,
      this.apr072023,
      this.apr082023,
      this.apr092023,
      this.apr112023,
      this.apr122023,
      this.apr152023,
      this.apr162023,
      this.may172023,
      this.may182023,
      this.may192023});

  DateWiseSales.fromJson(Map<String, dynamic> json) {
    apr062023 = json['Apr 06 2023'] != null
        ? new Apr062023.fromJson(json['Apr 06 2023'])
        : null;
    apr072023 = json['Apr 07 2023'] != null
        ? new Apr072023.fromJson(json['Apr 07 2023'])
        : null;
    apr082023 = json['Apr 08 2023'] != null
        ? new Apr062023.fromJson(json['Apr 08 2023'])
        : null;
    apr092023 = json['Apr 09 2023'] != null
        ? new Apr092023.fromJson(json['Apr 09 2023'])
        : null;
    apr112023 = json['Apr 11 2023'] != null
        ? new Apr092023.fromJson(json['Apr 11 2023'])
        : null;
    apr122023 = json['Apr 12 2023'] != null
        ? new Apr072023.fromJson(json['Apr 12 2023'])
        : null;
    apr152023 = json['Apr 15 2023'] != null
        ? new Apr062023.fromJson(json['Apr 15 2023'])
        : null;
    apr162023 = json['Apr 16 2023'] != null
        ? new Apr072023.fromJson(json['Apr 16 2023'])
        : null;
    may172023 = json['May 17 2023'] != null
        ? new May172023.fromJson(json['May 17 2023'])
        : null;
    may182023 = json['May 18 2023'] != null
        ? new Apr092023.fromJson(json['May 18 2023'])
        : null;
    may192023 = json['May 19 2023'] != null
        ? new Apr092023.fromJson(json['May 19 2023'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apr062023 != null) {
      data['Apr 06 2023'] = this.apr062023!.toJson();
    }
    if (this.apr072023 != null) {
      data['Apr 07 2023'] = this.apr072023!.toJson();
    }
    if (this.apr082023 != null) {
      data['Apr 08 2023'] = this.apr082023!.toJson();
    }
    if (this.apr092023 != null) {
      data['Apr 09 2023'] = this.apr092023!.toJson();
    }
    if (this.apr112023 != null) {
      data['Apr 11 2023'] = this.apr112023!.toJson();
    }
    if (this.apr122023 != null) {
      data['Apr 12 2023'] = this.apr122023!.toJson();
    }
    if (this.apr152023 != null) {
      data['Apr 15 2023'] = this.apr152023!.toJson();
    }
    if (this.apr162023 != null) {
      data['Apr 16 2023'] = this.apr162023!.toJson();
    }
    if (this.may172023 != null) {
      data['May 17 2023'] = this.may172023!.toJson();
    }
    if (this.may182023 != null) {
      data['May 18 2023'] = this.may182023!.toJson();
    }
    if (this.may192023 != null) {
      data['May 19 2023'] = this.may192023!.toJson();
    }
    return data;
  }
}

class Apr062023 {
  int? numOfSales;
  dynamic deliveryCompanyCharges;
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
    deliveryCompanyCharges = json['delivery_company_charges'];
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

class Apr072023 {
  int? numOfSales;
  int? deliveryCompanyCharges;
  double? adminCommission;
  double? salesProfit;
  double? salesExpense;

  Apr072023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  Apr072023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
    adminCommission = double.parse('${json['admin_commission'] ?? 0}');
    salesProfit = double.parse('${json['sales_profit'] ?? 0}');
    salesExpense = double.parse('${json['sales_expense'] ?? 0}');
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

class Apr092023 {
  int? numOfSales;
  dynamic deliveryCompanyCharges;
  dynamic adminCommission;
  dynamic salesProfit;
  dynamic salesExpense;

  Apr092023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  Apr092023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
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

class May172023 {
  int? numOfSales;
  String? deliveryCompanyCharges;
  int? adminCommission;
  int? salesProfit;
  int? salesExpense;

  May172023(
      {this.numOfSales,
      this.deliveryCompanyCharges,
      this.adminCommission,
      this.salesProfit,
      this.salesExpense});

  May172023.fromJson(Map<String, dynamic> json) {
    numOfSales = json['num_of_sales'];
    deliveryCompanyCharges = json['delivery_company_charges'];
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
