import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/modules/candidate/data/models/hive_models/experience_model.dart';
import 'package:app/modules/candidate/data/models/hive_models/school_model.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/widgets/information_item.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreateCVScreen extends StatefulWidget {
  const CreateCVScreen({super.key, required this.id, required this.name});

  final String id;
  final String name;

  @override
  State<CreateCVScreen> createState() => _CreateCVScreenState();
}

class _CreateCVScreenState extends State<CreateCVScreen> {
  final _box = Hive.box('info');
  final _experience = Hive.box<ExperienceModel>('Experience');
  final _school = Hive.box<SchoolModel>('school');
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    InformationItem(
                      icon: ImageFactory.person,
                      title: 'Thông tin cá nhân',
                      onPress: () {
                        Modular.to.pushNamed(RoutePath.fillSecondInfoCV,
                            arguments: [widget.id, widget.name]);
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.6), width: 1))),
          height: 130,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonApp(
                  onPress: () async {
                    Modular.to.pushNamed(RoutePath.previewCV, arguments: [
                      _box.get('name') ?? '',
                      _box.get('position') ?? '',
                      DateTime.now(),
                      _box.get('email') ?? '',
                      _box.get('phoneNumber') ?? '',
                      _box.get('link') ?? '',
                      _box.get('git') ?? '',
                      _box.get('address') ?? '',
                      _box.get('info') ?? '',
                      _experience.values.toList(),
                      _school.values.toList(),
                      widget.id,
                      widget.name
                    ]);
                  },
                  title: 'Xem CV',
                  paddingvertical: 15,
                ),
                ButtonOutline(
                  onPress: () {},
                  title: 'Quay Lại',
                  paddingvertical: 15,
                )
              ],
            ),
          ),
        ));
  }
}
