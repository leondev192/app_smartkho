import 'package:app_smartkho/data/services/product_service.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService _productService = ProductService();
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (!_isRefreshing) {
      setState(() {
        _isLoading = true;
      });
    }
    final products = await _productService.getAllProducts();
    setState(() {
      _products = products ?? [];
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _isRefreshing = true;
    });
    await _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Danh sách sản phẩm",
            style: TextStyle(
              fontSize: AppFonts.large,
              color: AppColors.textColorBold,
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading && !_isRefreshing
          ? const CustomLoading(width: 80, height: 80)
          : RefreshIndicator(
              onRefresh: _refreshProducts,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return _buildProductCard(product);
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product['name'] ?? "Tên sản phẩm",
              style: const TextStyle(
                fontSize: AppFonts.medium,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              product['description'] ?? "Mô tả sản phẩm",
              style: const TextStyle(
                fontSize: AppFonts.small,
                color: AppColors.textColorBold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.category,
                    color: AppColors.iconColor, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    product['category'] ?? "Danh mục",
                    style: const TextStyle(
                      fontSize: AppFonts.small,
                      color: AppColors.textColorBold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.inventory,
                    color: AppColors.iconColor, size: 16),
                const SizedBox(width: 5),
                Text(
                  "Kho: ${product['quantityInStock'] ?? 0}",
                  style: const TextStyle(
                    fontSize: AppFonts.small,
                    color: AppColors.textColorBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.warning, color: AppColors.iconColor, size: 16),
                const SizedBox(width: 5),
                Text(
                  "SLTK tối thiểu: ${product['reorderLevel'] ?? 0}",
                  style: const TextStyle(
                    fontSize: AppFonts.small,
                    color: AppColors.textColorBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
