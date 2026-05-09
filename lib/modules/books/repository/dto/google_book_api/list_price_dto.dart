class GoogleBookListPrice{
  double amount;
  String currencyCode;

  GoogleBookListPrice({required this.amount, required this.currencyCode});

  factory GoogleBookListPrice.fromJson(Map<String, dynamic> json){
    return GoogleBookListPrice(
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode']
    );
  }
}