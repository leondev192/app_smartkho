class SupplierModel {
  final String id;
  final String name;
  final String contactInfo;
  final String address;

  SupplierModel({
    required this.id,
    required this.name,
    required this.contactInfo,
    required this.address,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'],
      contactInfo: json['contactInfo'],
      address: json['address'],
    );
  }
}
