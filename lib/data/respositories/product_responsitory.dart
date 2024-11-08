import 'package:app_smartkho/data/services/product_service.dart';

class ProductRepository {
  final ProductService _productService = ProductService();

  Future<Map<String, dynamic>?> getProductBySKU(String sku) async {
    final products = await _productService.getAllProducts();
    if (products != null) {
      return products.firstWhere(
        (product) => product['sku'] == sku,
      );
    }
    return null;
  }
}
