import 'package:flutter/material.dart';
import 'package:app_smartkho/data/models/product_model.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
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
              product.description,
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
                const Icon(Icons.qr_code, size: 16, color: AppColors.iconColor),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    product.sku,
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
            Row(
              children: [
                const Icon(Icons.category,
                    size: 16, color: AppColors.iconColor),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    product.category,
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
            Row(
              children: [
                const Icon(Icons.inventory,
                    size: 16, color: AppColors.iconColor),
                const SizedBox(width: 5),
                Text(
                  "Kho: ${product.quantityInStock}",
                  style: const TextStyle(
                    fontSize: AppFonts.small,
                    color: AppColors.textColorBold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.warning, size: 16, color: AppColors.iconColor),
                const SizedBox(width: 5),
                Text(
                  "SL tối thiểu: ${product.reorderLevel}",
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
