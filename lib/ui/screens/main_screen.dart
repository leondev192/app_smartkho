import 'package:app_smartkho/ui/screens/main/history.dart';
import 'package:app_smartkho/ui/screens/main/home.dart';
import 'package:app_smartkho/ui/screens/main/account.dart';
import 'package:app_smartkho/ui/screens/main/product.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_smartkho/utils/product_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final ProductScanner _productScanner =
      ProductScanner(); // Initialize ProductScanner instance
  final List<Widget> _screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const ProductScreen(),
    const AccountScreen(),
  ];

  // Function to handle navigation tab taps
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Function to handle QR scan button press
  Future<void> _onQRScanPressed() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.qr_code),
                title: const Text("Quét xem thông tin sản phẩm"),
                onTap: () async {
                  Navigator.pop(context); // Close BottomSheet
                  await _productScanner.scanAndShowProductInfo();
                },
              ),
              ListTile(
                leading: const Icon(Icons.warehouse),
                title: const Text("Quét nhập kho"),
                onTap: () async {
                  Navigator.pop(context); // Close BottomSheet
                  await _productScanner.scanAndCreateTransaction("IN");
                },
              ),
              ListTile(
                leading: const Icon(Icons.outbox),
                title: const Text("Quét xuất kho"),
                onTap: () async {
                  Navigator.pop(context); // Close BottomSheet
                  await _productScanner.scanAndCreateTransaction("OUT");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: _onQRScanPressed,
          backgroundColor: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          clipBehavior: Clip.antiAlias,
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Tài khoản',
          ),
        ],
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
