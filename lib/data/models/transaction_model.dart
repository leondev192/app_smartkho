class TransactionModel {
  final String id;
  final String productId;
  final String transactionType;
  final int quantity;
  final DateTime transactionDate;
  final bool approved;
  final String? approvedBy;
  final String createdBy;
  final String? remarks;
  final String productName;

  TransactionModel({
    required this.id,
    required this.productId,
    required this.transactionType,
    required this.quantity,
    required this.transactionDate,
    required this.approved,
    this.approvedBy,
    required this.createdBy,
    this.remarks,
    required this.productName,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      productId: json['productId'],
      transactionType: json['transactionType'],
      quantity: json['quantity'],
      transactionDate: DateTime.parse(json['transactionDate']),
      approved: json['approved'],
      approvedBy: json['approvedBy'],
      createdBy: json['createdBy'],
      remarks: json['remarks'],
      productName: json['product']['name'],
    );
  }
}
