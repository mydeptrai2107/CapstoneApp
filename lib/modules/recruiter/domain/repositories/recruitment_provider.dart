import 'dart:developer';

import 'package:app/modules/recruiter/data/services/recruitment_service.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:flutter/material.dart';

class RecruitmentProvider extends ChangeNotifier {
  List<Recruitment> get listRecruitment => _listRecruitment;
  List<Recruitment> _listRecruitment = [];

  final RecruitmentService _recruitmentService = RecruitmentService();

  Future getRecruitments() async {
    try {
      final res =
          await _recruitmentService.getRecruitments('646b912feedac50c5059e247');
      _listRecruitment = res;
    } catch (e) {
      log(e.toString());
    }
  }

  Future createRecruitment(Recruitment recruitment) async {
    try {
      final res = await _recruitmentService.createRecruitment(recruitment);
      _listRecruitment.add(res);
    } catch (e) {
      log(e.toString());
    }
  }
}
