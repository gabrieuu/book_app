class ListPrice{
  double amount;
  String currencyCode;

  ListPrice({required this.amount, required this.currencyCode});

  factory ListPrice.fromJson(Map<String, dynamic> json){
    return ListPrice(
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode']
    );
  }
}