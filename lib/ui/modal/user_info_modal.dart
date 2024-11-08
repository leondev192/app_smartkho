import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInfoModal extends StatelessWidget {
  final String fullName;
  final String email;
  final String avatarUrl;
  final String phoneNumber;
  final String address;
  final String createdAt;

  const UserInfoModal({
    Key? key,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
  }) : super(key: key);

  String _formatDate(String dateString) {
    try {
      // Chuyển đổi chuỗi ngày thành đối tượng DateTime
      DateTime parsedDate = DateTime.parse(dateString);
      // Định dạng ngày theo kiểu dd/MM/yyyy
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      // Nếu có lỗi khi chuyển đổi, trả về chuỗi mặc định
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
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 50,
            ),
            const SizedBox(height: 10),
            Text(
              fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text('Số điện thoại'),
              subtitle: Text(phoneNumber.isNotEmpty ? phoneNumber : 'N/A'),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue),
              title: const Text('Địa chỉ'),
              subtitle: Text(address.isNotEmpty ? address : 'N/A'),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: const Text('Ngày tạo tài khoản'),
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
