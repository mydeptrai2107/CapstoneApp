import 'package:app/modules/recruiter/presentations/views/home/widgets/recruitment_efficiency.dart';
import 'package:flutter/material.dart';

import 'widgets/add_recruitment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              RecruitmentEfficiency(),
              AddRecruitment(),
            ],
          ),
        ),
      ),
    );
  }
}
