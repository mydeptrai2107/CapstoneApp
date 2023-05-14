// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/domain/providers/provider_auth.dart';
import 'package:app/presentations/themes/color.dart';
import 'package:app/presentations/views/profile/account_screen.dart';
import 'package:app/presentations/views/cv_profile/welcome_create_cv.dart';
import 'package:app/presentations/views/home/home_screen.dart';
import 'package:app/presentations/views/profile/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobCVHomeScreen extends StatefulWidget {
  const JobCVHomeScreen({super.key});

  @override
  State<JobCVHomeScreen> createState() => _JobCVHomeScreenState();
}

class _JobCVHomeScreenState extends State<JobCVHomeScreen> {
  int _currentIndex = 0;
  String a = 'sa';

  @override
  Widget build(BuildContext context) {
    final providerAuth = context.watch<ProviderAuth>();
    final tabs = [
      const HomeScreen(),
      const WelcomeCreateCV(),
      const Center(
        child: Text('Chat'),
      ),
      const Center(
        child: Text('Notification'),
      ),
      AccountScreen(avatar: a)
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        selectedItemColor: primaryColor,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageFactory.home,
              width: 25,
              height: 25,
              color: _currentIndex == 0 ? primaryColor : Colors.grey,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageFactory.reader,
              width: 25,
              height: 25,
              color: _currentIndex == 1 ? primaryColor : Colors.grey,
            ),
            label: 'CV & Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageFactory.chatbubbles,
              width: 25,
              height: 25,
              color: _currentIndex == 2 ? primaryColor : Colors.grey,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageFactory.notification,
              width: 25,
              height: 25,
              color: _currentIndex == 3 ? primaryColor : Colors.grey,
            ),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageFactory.person,
              width: 25,
              height: 25,
              color: _currentIndex == 4 ? primaryColor : Colors.grey,
            ),
            label: 'Tài khoản',
          ),
        ],
        onTap: (value) async {
          if (value == 4) {
            a = await providerAuth.getAvatar();
          }
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
