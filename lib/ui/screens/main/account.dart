import 'package:app_smartkho/logic/providers/auth_provider.dart';
import 'package:app_smartkho/ui/modal/user_info_modal.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String email = '';
  String fullName = '';
  String avatarUrl = '';
  String phoneNumber = '';
  String address = '';
  String createdAt = '';

  @override
  void initState() {
    super.initState();
    _loadInformation();
  }

  Future<void> _loadInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'no have';
      fullName = prefs.getString('fullName') ?? 'no have';
      avatarUrl = prefs.getString('avatarUrl') ?? 'no have';
      phoneNumber = prefs.getString('phoneNumber') ?? 'no have';
      address = prefs.getString('address') ?? '';
      createdAt = prefs.getString('createdAt') ?? '';
    });
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận đăng xuất"),
          content: const Text("Bạn có chắc chắn muốn đăng xuất?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text("Không"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng dialog
                // Thực hiện đăng xuất
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                // Điều hướng đến màn hình đăng nhập
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                "Có",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUserInfoModal() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return UserInfoModal(
          fullName: fullName,
          email: email,
          avatarUrl: avatarUrl,
          phoneNumber: phoneNumber,
          address: address,
          createdAt: createdAt,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: AppColors.primaryColor,
          child: Stack(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: screenHeight * 0.75,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$fullName',
                                  style: const TextStyle(
                                      fontSize: AppFonts.xLarge,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                                ),
                                Text(
                                  '$email',
                                  style:
                                      const TextStyle(fontSize: AppFonts.small),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 30)),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Tài khoản',
                              style: TextStyle(
                                fontSize: AppFonts.large,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            _showUserInfoModal();
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: AppColors.iconColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Thông tin tài khoản',
                                      style: TextStyle(
                                          fontSize: AppFonts.medium,
                                          color: AppColors.textColorBold),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: AppColors.iconColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: const Divider(
                                thickness: 1,
                                color: AppColors.borderColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Trợ giúp và hỗ trợ',
                              style: TextStyle(
                                fontSize: AppFonts.large,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {},
                          child: const SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: AppColors.iconColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Trung tâm hỗ trợ ',
                                      style: TextStyle(
                                          fontSize: AppFonts.medium,
                                          color: AppColors.textColorBold),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: AppColors.iconColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {},
                          child: const SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.contact_support,
                                      color: AppColors.iconColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Liên hệ SmartKho',
                                      style: TextStyle(
                                          fontSize: AppFonts.medium,
                                          color: AppColors.textColorBold),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: AppColors.iconColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {},
                          child: const SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.priority_high,
                                      color: AppColors.iconColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Báo lỗi',
                                      style: TextStyle(
                                          fontSize: AppFonts.medium,
                                          color: AppColors.textColorBold),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: AppColors.iconColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: const Divider(
                                thickness: 1,
                                color: AppColors.borderColor,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () async {
                            _showLogoutDialog(context);
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Đăng xuất',
                                      style: TextStyle(
                                          fontSize: AppFonts.medium,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: screenHeight * 0.10,
                left: screenWidth * 0.07,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('$avatarUrl'),
                  backgroundColor: AppColors.whiteColor,
                  radius: 60,
                ),
              ),
            ],
          )),
    );
  }
}
