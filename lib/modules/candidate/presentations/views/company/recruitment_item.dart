import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/models/recruitment_model.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/tag_recuitment_item.dart';
import 'package:app/shared/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecruitmentItem extends StatefulWidget {
  const RecruitmentItem(
      {super.key, required this.recruitment, required this.company});

  final Recruitment recruitment;
  final Company company;

  @override
  State<RecruitmentItem> createState() => _RecruitmentItemState();
}

class _RecruitmentItemState extends State<RecruitmentItem> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(RoutePath.detailRecruitment,
            arguments: [widget.recruitment, widget.company]);
      },
      child: Container(
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
            Text(
              '${widget.recruitment.title} - ${widget.recruitment.address}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    TagRecuitmentItem(
                      icon: ImageFactory.clock,
                      title: Format.formatDateTimeToYYYYmmdd(
                          widget.recruitment.deadline),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TagRecuitmentItem(
                      icon: ImageFactory.location,
                      title: widget.recruitment.address,
                    )
                  ],
                ),
                TagRecuitmentItem(
                    title: widget.recruitment.salary, icon: ImageFactory.dollar)
              ],
            )
          ],
        ),
      ),
    );
  }
}
