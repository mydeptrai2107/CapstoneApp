import 'package:app/modules/recruiter/presentations/views/recruitment/widgets/filter_cv.dart';
import 'package:app/modules/recruiter/presentations/widgets/search_box.dart';
import 'package:flutter/material.dart';

import 'widgets/list_recruitment.dart';

class RecruitmentScreen extends StatelessWidget {
  const RecruitmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: const [
          FilterCv(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: SearchBox(
              hinText: 'Tìm kiếm theo tiêu đề, mã tin',
            ),
          ),
          Expanded(child: ListRecruitment())
        ],
      ),
    );
  }
}
