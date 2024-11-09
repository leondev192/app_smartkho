import 'package:flutter/material.dart';
import 'package:app_smartkho/data/respositories/product_responsitory.dart';
import 'package:app_smartkho/data/models/product_model.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading.dart';
import 'package:app_smartkho/ui/widgets/cards/product_card.dart'; // Import ProductCard

import '../../themes/colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> _products = [];
  bool _isLoading = true;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (!_isRefreshing) {
      setState(() => _isLoading = true);
    }
    final products = await _productRepository.getAllProducts();
    setState(() {
      _products = products ?? [];
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  Future<void> _refreshProducts() async {
    setState(() => _isRefreshing = true);
    await _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm",
            style: TextStyle(color: AppColors.textColorBold)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading && !_isRefreshing
          ? const CustomLoading(width: 80, height: 80)
          : RefreshIndicator(
              onRefresh: _refreshProducts,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) => ProductCard(
                  product: _products[index],
                ),
              ),
            ),
    );
  }
}
