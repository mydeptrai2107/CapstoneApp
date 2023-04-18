// ignore_for_file: deprecated_member_use

import 'package:app/configs/font_style_text.dart';
import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/presentations/themes/color.dart';
import 'package:app/presentations/views/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FillFirstInformationCV extends StatefulWidget {
  const FillFirstInformationCV({super.key});

  @override
  State<FillFirstInformationCV> createState() => _FillFirstInformationCVState();
}

class _FillFirstInformationCVState extends State<FillFirstInformationCV> {
  var languages = ['Tiếng Việt', 'Tiếng Anh'];
  List<String> exp = [
    'Chưa có kinh nghiệm',
    'Dưới 1 năm',
    '1 năm',
    '2 năm',
    '3 năm',
    '4 năm',
    '5 năm',
    'Trên 5 năm'
  ];

  List<String> status = ['Chưa có kinh nghiệm', 'Không có nhu cầu'];

  String selectLanguge = 'Tiếng Việt';
  String selectExp = 'Chưa có kinh nghiệm';
  String selectStatus = 'Không có nhu cầu';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      appBar: AppBar(
        title: const Text(
          'Tạo CV',
          style: textStyleTitleAppBar,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        color: Colors.white,
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageFactory.colorWand,
                  color: primaryColor,
                  width: 25,
                  height: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Text(
                  TextApp.fillInfor,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                )
              ],
            ),

            const Divider(
              thickness: 1,
            ),

            SizedBox(
              height: 20.h,
            ),

            //language
            const Text(
              'Ngôn ngữ CV',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectLanguge,
                    items: languages
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectLanguge = value!.toString();
                      });
                    }),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
            //language
            const Text(
              'Kinh Nghiệm',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectExp,
                    items: exp
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectExp = value!.toString();
                      });
                    }),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
            //status
            const Text(
              'Nhu cầu tìm việc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: true,
                    value: selectStatus,
                    items: status
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectStatus = value!.toString();
                      });
                    }),
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            Center(
              child: ButtonApp(
                paddingHorizontal: 50,
                title: 'Bắt đầu',
                onPress: () {
                  Modular.to.pushNamed(RoutePath.pdfPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
