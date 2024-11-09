class Product {
  final String id;
  final String sku;
  final String name;
  final String description;
  final String category;
  final int quantityInStock;
  final int reorderLevel;
  final String createdAt;
  final String updatedAt;
  final String supplierId;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.description,
    required this.category,
    required this.quantityInStock,
    required this.reorderLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.supplierId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sku: json['sku'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      quantityInStock: json['quantityInStock'],
      reorderLevel: json['reorderLevel'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      supplierId: json['supplierId'],
    );
  }

  // Constructor for creating an empty Product object
  factory Product.empty() {
    return Product(
      id: '',
      sku: '',
      name: '',
      description: '',
      category: '',
      quantityInStock: 0,
      reorderLevel: 0,
      createdAt: '',
      updatedAt: '',
      supplierId: '',
    );
  }
}
