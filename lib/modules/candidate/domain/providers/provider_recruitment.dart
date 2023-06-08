import 'package:app/modules/candidate/data/models/action_recruitment_model.dart';
import 'package:app/modules/candidate/data/repositories/recruitment_repositories.dart';
import 'package:app/shared/models/recruitment_like_model.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:flutter/material.dart';

class ProviderRecruitment extends ChangeNotifier {
  RecruitmentRepository recruitmentRepository = RecruitmentRepository();

  bool _isLoadingGetListRecruit = false;
  bool get isLoadingGetListRecruit => _isLoadingGetListRecruit;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<RecruitmentLike>> getListRecruitByCompany(
      String idCompany) async {
    try {
      _isLoadingGetListRecruit = true;
      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitByCompany(idCompany);
      Iterable it = responseBody;
      List<RecruitmentLike> list =
          it.map((e) => RecruitmentLike.fromJson(e)).toList();
      _isLoadingGetListRecruit = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoadingGetListRecruit = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<RecruitmentLike> getRecruitById(String id) async {
    try {
      _isLoadingGetListRecruit = true;
      Map<String, dynamic> responseBody =
          await recruitmentRepository.getRecruitById(id);
      RecruitmentLike recruitment = RecruitmentLike.fromJson(responseBody);
      _isLoadingGetListRecruit = false;
      notifyListeners();
      return recruitment;
    } catch (e) {
      _isLoadingGetListRecruit = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<RecruitmentLike>> getListRecruitByName(String name) async {
    try {
      _isLoadingGetListRecruit = true;

      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitmentByName(name);
      Iterable it = responseBody;
      List<RecruitmentLike> list =
          it.map((e) => RecruitmentLike.fromJson(e)).toList();
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

  Future<List<RecruitmentLike>> getListRecruitment() async {
    try {
      _isLoadingGetListRecruit = true;

      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitment();
      Iterable it = responseBody;
      List<RecruitmentLike> list =
          it.map((e) => RecruitmentLike.fromJson(e)).toList();
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

  Future<ActionRecruitmentModel> actionSave(
      String rid, String userId, bool save) async {
    try {
      _isLoading = true;
      Map<String, dynamic> responseBody =
          await recruitmentRepository.actionSaveRecruitment(rid, userId, save);
      ActionRecruitmentModel action =
          ActionRecruitmentModel.fromJson(responseBody);
      _isLoading = false;
      notifyListeners();
      return action;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<String>> getListIdRecruitmentSaved(String userId) async {
    try {
      _isLoading = true;
      List<dynamic> responseBody =
          await recruitmentRepository.getListIdRecruitmentSaved(userId);
      Iterable it = responseBody;
      List<String> list = it.map((e) => e.toString()).toList();
      _isLoading = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<int> getCountRecruitmentSaved(String userId) async {
    try {
      _isLoading = true;
      List<String> list = await getListIdRecruitmentSaved(userId);
      _isLoading = false;
      notifyListeners();
      return list.length;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Recruitment>> getListRecruitmentSaved(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();
      List<dynamic> responseBody =
          await recruitmentRepository.getListRecruitmentSaved(userId);
      Iterable it = responseBody;
      List<Recruitment> list = it.map((e) => Recruitment.fromJson(e)).toList();
      _isLoading = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
