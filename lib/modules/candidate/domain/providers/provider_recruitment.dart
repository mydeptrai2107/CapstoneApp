import 'package:app/modules/candidate/data/models/recruitment_model.dart';
import 'package:app/modules/candidate/data/repositories/recruitment_repositories.dart';
import 'package:flutter/material.dart';

class ProviderRecruitment extends ChangeNotifier {
  RecruitmentRepository recruitmentRepository = RecruitmentRepository();

  bool _isLoadingGetListRecruit = false;
  bool get isLoadingGetListRecruit => _isLoadingGetListRecruit;

  Future<List<Recruitment>> getListRecruitByCompany(String idCompany) async {
    try {
      _isLoadingGetListRecruit = true;

      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitByCompany(idCompany);
      Iterable it = responseBody;
      List<Recruitment> list = it.map((e) => Recruitment.fromJson(e)).toList();
      _isLoadingGetListRecruit = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoadingGetListRecruit = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Recruitment>> getListRecruitByName(String name) async {
    try {
      _isLoadingGetListRecruit = true;

      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitmentByName(name);
      Iterable it = responseBody;
      List<Recruitment> list = it.map((e) => Recruitment.fromJson(e)).toList();
      _isLoadingGetListRecruit = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoadingGetListRecruit = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<int> getQuantityRecruitByCompany(String idCompany) async {
    try {
      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitByCompany(idCompany);
      notifyListeners();
      return responseBody.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Recruitment>> getListRecruitment() async {
    try {
      _isLoadingGetListRecruit = true;

      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitment();
      Iterable it = responseBody;
      List<Recruitment> list = it.map((e) => Recruitment.fromJson(e)).toList();
      // list.sort(
      //   (a, b) => a.salary!.compareTo(b.salary!),
      // );
      _isLoadingGetListRecruit = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoadingGetListRecruit = false;
      notifyListeners();
      rethrow;
    }
  }
}
