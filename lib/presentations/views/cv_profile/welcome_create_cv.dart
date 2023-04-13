import 'package:app/configs/font_style_text.dart';
import 'package:app/configs/image_factory.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/presentations/views/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeCreateCV extends StatefulWidget {
  const WelcomeCreateCV({super.key});

  @override
  State<WelcomeCreateCV> createState() => _WelcomeCreateCVState();
}

class _WelcomeCreateCVState extends State<WelcomeCreateCV> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý CV',
          style: textStyleTitleAppBar,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              TextApp.createFirstCV,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              TextApp.createFirstCV,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 15),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              TextApp.letisCreateCvNow,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16),
            ),
            SizedBox(height: 20.h),
            ButtonApp(
              title: 'Tạo CV đầu tiên',
              paddingHorizontal: 50.w,
              onPress: () {},
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 300.h,
              width: 300.h,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(ImageFactory.editCV))),
            )
          ],
        ),
      ),
    );
  }
}
