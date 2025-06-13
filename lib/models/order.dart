class OrderData {
  final String invoice;
  final String customerName;
  final String deadline;
  final String status;
  final String productName;
  final String quantity;
  final List<String> details;

  OrderData({
    required this.invoice,
    required this.customerName,
    required this.deadline,
    required this.status,
    required this.productName,
    required this.quantity,
    required this.details,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      invoice: json['invoice'],
      customerName: json['customer_name'],
      deadline: json['deadline'],
      status: json['status'],
      productName: json['product_name'],
      quantity: json['quantity'],
      details: List<String>.from(json['details']),
    );
  }
}
