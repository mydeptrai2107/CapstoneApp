// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/data/repositories/authen_repositories.dart';
import 'package:app/presentations/themes/color.dart';
import 'package:app/presentations/views/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassWord = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250.w,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageFactory.logo), fit: BoxFit.fill)),
            ),
            const Text(
              'Đăng nhập',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            //email
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: SvgPicture.asset(
                      ImageFactory.mail,
                      width: 25,
                      height: 25,
                      color: Colors.grey,
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
            ),

            //password
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                obscureText: showPassWord,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: SvgPicture.asset(
                      ImageFactory.lockClose,
                      width: 25,
                      height: 25,
                      color: Colors.grey,
                    ),
                    hintText: 'Nhập mật khẩu',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassWord = !showPassWord;
                        });
                      },
                      child: Icon(
                        showPassWord
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                      ),
                    )),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ButtonApp(
              onPress: () {},
              title: 'Đăng nhập',
              width: size.width,
            ),

            SizedBox(
              height: 20.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1,
                  width: size.width / 5,
                  color: Colors.grey,
                ),
                const Text('Hoặc đăng nhập bằng'),
                Container(
                  height: 1,
                  width: size.width / 5,
                  color: Colors.grey,
                ),
              ],
            ),

            SizedBox(
              height: 10.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    AuthenRepositories().signIn();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: SvgPicture.asset(
                        ImageFactory.facebookIcon,
                        width: 35,
                        height: 35,
                      )),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: SvgPicture.asset(
                      ImageFactory.googleIcon,
                      width: 35,
                      height: 35,
                    )),
              ],
            ),

            Expanded(child: Container()),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bạn chưa có tài khoản?'),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    ' Đăng ký ngay',
                    style: TextStyle(color: primaryColor),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
