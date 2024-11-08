import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '';
  String fullName = '';
  String avatarUrl = '';
  String phoneNumber = '';
  String address = '';

  @override
  void initState() {
    // TODO: implement initState
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '$avatarUrl',
                        ),
                        radius: 20,
                        backgroundColor: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Xin chào 👋 ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: AppFonts.small,
                                color: AppColors.textColorBold),
                          ),
                          Text(
                            '$fullName',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: AppFonts.small,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.primaryColor,
                        ),
                        iconSize: 24,
                        color: AppColors.iconColor,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_rounded,
                          color: AppColors.primaryColor,
                        ),
                        iconSize: 24,
                        color: AppColors.iconColor,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        body: Container(
          color: AppColors.borderColor,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10),
                  ),
                  border: Border.all(color: AppColors.borderColor, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        '$avatarUrl',
                      ),
                      radius: 40,
                      backgroundColor: AppColors.whiteColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Xin chào 👋 , $fullName',
                              maxLines: 1, // Giới hạn số dòng là 1
                              overflow: TextOverflow
                                  .ellipsis, // Thêm dấu '...' nếu văn bản quá dài
                              style: const TextStyle(
                                  fontSize: 16), // Tùy chỉnh kiểu chữ (nếu cần)
                            ),
                            const Text('Chào mừng bạn đã quay trở lại!')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
