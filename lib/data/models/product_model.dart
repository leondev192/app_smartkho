class Product {
  final String id;
  final String sku;
  final String name;
  final String description;
  final String category;
  final int quantityInStock;
  final int reorderLevel;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.description,
    required this.category,
    required this.quantityInStock,
    required this.reorderLevel,
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
    );
  }
}
