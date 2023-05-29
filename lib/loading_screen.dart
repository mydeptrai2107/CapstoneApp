import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLogined = false;

  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogined = prefs.getString('refreshToken') != null;
    await Future.delayed(
        const Duration(seconds: 2),
        () => isLogined
            ? Modular.to.navigate(RoutePath.home)
            : Modular.to.navigate(RoutePath.login));
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'JobCV',
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Text('Tìm kiếm, kết nối, xây dựng thành công',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
