import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/presentations/views/cv_profile/widgets/information_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCVScreen extends StatefulWidget {
  const CreateCVScreen({super.key});

  @override
  State<CreateCVScreen> createState() => _CreateCVScreenState();
}

class _CreateCVScreenState extends State<CreateCVScreen> {
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo CV'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            //Note
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hướng dẫn',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(TextApp.guideline1),
                  SizedBox(
                    height: 7,
                  ),
                  Text(TextApp.guideline2),
                  SizedBox(
                    height: 7,
                  ),
                  Text(TextApp.guideline3),
                  SizedBox(
                    height: 7,
                  ),
                  Text(TextApp.guideline4),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),

            Container(
              height: 20.h,
              color: const Color.fromARGB(255, 219, 219, 219),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin bản thân',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InformationItem(
                    icon: ImageFactory.person,
                    title: 'Thông tin cá nhân',
                    onPress: () {
                      Modular.to.pushNamed(RoutePath.fillSecondInfoCV);
                    },
                  ),
                  InformationItem(
                    icon: ImageFactory.documentText,
                    title: 'giới thiệu tóm tắt',
                  ),
                  InformationItem(
                    icon: ImageFactory.start,
                    title: 'Kinh nghiệm làm việc',
                  ),
                  InformationItem(
                    icon: ImageFactory.barChart,
                    title: 'Kỹ năng',
                  ),
                  InformationItem(
                    icon: ImageFactory.school,
                    title: 'Học vấn',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
