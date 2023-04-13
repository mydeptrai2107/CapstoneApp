import 'package:app/configs/image_factory.dart';
import 'package:app/presentations/views/company/widgets/tag_recuitment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recruitment extends StatefulWidget {
  const Recruitment({super.key});

  @override
  State<Recruitment> createState() => _RecruitmentState();
}

class _RecruitmentState extends State<Recruitment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
      child: ListView(
        children: [
          Container(
            width: size.width,
            height: 130.h,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(width: 0.05, color: Colors.black),
                boxShadow: const [
                  BoxShadow(offset: Offset(0.5, 1), color: Colors.black)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Application Developer - DaNang',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const TagRecuitmentItem(
                          icon: ImageFactory.clock,
                          title: '27/07/2022',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const TagRecuitmentItem(
                          icon: ImageFactory.location,
                          title: 'Hồ Chí Minh',
                        )
                      ],
                    ),
                    const TagRecuitmentItem(
                        title: '10 - 15 Triệu', icon: ImageFactory.dollar)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
