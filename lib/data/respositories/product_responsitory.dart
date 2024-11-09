// lib/data/repositories/product_repository.dart
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  final ProductService _productService = ProductService();

  Future<List<Product>?> getAllProducts() async {
    final productData = await _productService.getAllProducts();
    return productData?.map((json) => Product.fromJson(json)).toList();
  }
}
