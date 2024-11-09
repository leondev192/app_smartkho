// lib/utils/product_scanner.dart
import 'package:app_smartkho/data/models/product_model.dart';
import 'package:app_smartkho/data/respositories/product_responsitory.dart';
import 'package:app_smartkho/data/services/transaction_service.dart';
import 'package:app_smartkho/ui/modal/product_info_modal.dart';
import 'package:app_smartkho/ui/widgets/buttons/gradient_button.dart';
import 'package:app_smartkho/ui/widgets/inputs/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:app_smartkho/main.dart';

class ProductScanner {
  final ProductRepository _productRepository = ProductRepository();
  final TransactionService _transactionService = TransactionService();

  // Hàm quét mã và hiển thị thông tin sản phẩm
  Future<void> scanAndShowProductInfo() async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        final products = await _productRepository.getAllProducts();
        if (products == null) {
          _showErrorDialog("Không có sản phẩm nào.");
          return;
        }

        // Sử dụng firstWhere và trả về Product.empty() nếu không tìm thấy sản phẩm
        final product = products.firstWhere(
          (product) => product.sku == result.rawContent,
          orElse: () =>
              Product.empty(), // Trả về Product.empty() khi không tìm thấy
        );

        if (product.id.isNotEmpty) {
          _showProductInfoModal(product);
        } else {
          _showErrorDialog("Sản phẩm không tìm thấy.");
        }
      }
    } catch (e) {
      _showErrorDialog("Lỗi khi quét mã vạch.");
    }
  }

// Hàm quét mã và tạo giao dịch (nhập hàng hoặc xuất hàng)
  Future<void> scanAndCreateTransaction(String transactionType) async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.rawContent.isEmpty) {
        _showErrorDialog("Quét mã vạch không thành công.");
        return;
      }

      final products = await _productRepository.getAllProducts();
      final product = products?.firstWhere(
        (product) => product.sku == result.rawContent,
        orElse: () => Product.empty(), // Trả về Product rỗng khi không tìm thấy
      );

      if (product != null && product.id.isNotEmpty) {
        // Kiểm tra nếu product không phải là Product rỗng và không phải null
        _showTransactionForm(product.sku, transactionType);
      } else {
        _showErrorDialog("Sản phẩm không tìm thấy.");
      }
    } catch (e) {
      _showErrorDialog("Lỗi khi quét mã vạch.");
    }
  }

  // Hiển thị biểu mẫu giao dịch (số lượng, ghi chú)
  void _showTransactionForm(String sku, String transactionType) {
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController remarksController = TextEditingController();

    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                transactionType == "IN" ? "Nhập hàng" : "Xuất hàng",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CustomInputField(
                label: "Số lượng",
                controller: quantityController,
                prefixIcon: const Icon(Icons.confirmation_number),
                isError: quantityController.text.isEmpty,
              ),
              const SizedBox(height: 10),
              CustomInputField(
                label: "Ghi chú",
                controller: remarksController,
                prefixIcon: const Icon(Icons.note),
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: "Xác nhận",
                onPressed: () {
                  final quantity = int.tryParse(quantityController.text) ?? 0;
                  final remarks = remarksController.text;

                  if (quantity > 0) {
                    _showConfirmationDialog(
                      navigatorKey.currentContext!,
                      sku,
                      transactionType,
                      quantity,
                      remarks,
                    );
                  } else {
                    _showErrorDialog("Số lượng phải lớn hơn 0.");
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Hiển thị hộp thoại xác nhận trước khi gửi giao dịch
  void _showConfirmationDialog(
    BuildContext context,
    String sku,
    String transactionType,
    int quantity,
    String remarks,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xác nhận giao dịch"),
          content: const Text("Bạn có chắc chắn muốn tạo giao dịch này?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext); // Đóng hộp thoại xác nhận
                final success = await _submitTransaction(
                  sku,
                  transactionType,
                  quantity,
                  remarks,
                );
                if (success) {
                  _closeAllModals(); // Đóng tất cả các dialog khi thành công
                }
              },
              child: const Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }

  // Gửi dữ liệu giao dịch lên backend
  Future<bool> _submitTransaction(
    String sku,
    String transactionType,
    int quantity,
    String remarks,
  ) async {
    try {
      final response = await _transactionService.createTransaction({
        "sku": sku,
        "transactionType": transactionType,
        "quantity": quantity,
        "remarks": remarks,
      });
      if (response['status'] == 'success') {
        _showSuccessDialog("Giao dịch thành công.");
        return true;
      } else {
        _showErrorDialog("Không thể hoàn tất giao dịch.");
        return false;
      }
    } catch (e) {
      _showErrorDialog("Lỗi khi tạo giao dịch.");
      return false;
    }
  }

  // Đóng tất cả dialog/modals
  void _closeAllModals() {
    if (navigatorKey.currentContext != null) {
      Navigator.popUntil(
          navigatorKey.currentContext!, (route) => route.isFirst);
    }
  }

  // Hiển thị thông tin sản phẩm trong modal
  void _showProductInfoModal(Product product) {
    if (navigatorKey.currentContext == null) return;

    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ProductInfoModal(
          name: product.name,
          sku: product.sku,
          description: product.description,
          category: product.category,
          quantityInStock: product.quantityInStock,
          reorderLevel: product.reorderLevel,
          createdAt: product.createdAt,
        );
      },
    );
  }

  // Hộp thoại lỗi cho thông báo lỗi
  void _showErrorDialog(String message) {
    if (navigatorKey.currentContext == null) return;

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text("Thông báo"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Hộp thoại thành công cho giao dịch thành công
  void _showSuccessDialog(String message) {
    if (navigatorKey.currentContext == null) return;

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text("Thành công"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _closeAllModals(); // Đóng tất cả các modals sau khi thành công
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
