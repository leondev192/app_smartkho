import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductInfoModal extends StatelessWidget {
  final String name;
  final String sku;
  final String description;
  final String category;
  final int quantityInStock;
  final int reorderLevel;
  final String createdAt;

  const ProductInfoModal({
    super.key,
    required this.name,
    required this.sku,
    required this.description,
    required this.category,
    required this.quantityInStock,
    required this.reorderLevel,
    required this.createdAt,
  });

  String _formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'SKU: $sku',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.blue),
              title: const Text('Danh mục'),
              subtitle: Text(category),
            ),
            ListTile(
              leading: const Icon(Icons.inventory, color: Colors.blue),
              title: const Text('Số lượng trong kho'),
              subtitle: Text(quantityInStock.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.blue),
              title: const Text('Tồn kho tối thiểu'),
              subtitle: Text(reorderLevel.toString()),
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: const Text('Mô tả'),
              subtitle: Text(description),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: const Text('Ngày tạo'),
              subtitle: Text(_formatDate(createdAt)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng modal
              },
              child: const Text('Đóng', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
