import 'package:app/modules/candidate/data/models/apply_model.dart';
import 'package:app/modules/candidate/data/models/profile_model.dart';
import 'package:app/modules/candidate/data/models/user_model.dart';
import 'package:app/modules/candidate/data/repositories/apply_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:flutter/material.dart';

class ProviderApply extends ChangeNotifier {
  final ApplyRepository _applyRepository = ApplyRepository();
  ProviderAuth providerAuth = ProviderAuth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Apply> createApply(
      String idProfile, String idRecruit, String comment) async {
    try {
      _isLoading = true;
      notifyListeners();
      Map<String, dynamic> responseBody =
          await _applyRepository.createApply(idProfile, idRecruit, comment);
      Apply apply = Apply.fromJson(responseBody);
      _isLoading = false;
      notifyListeners();
      return apply;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Apply>> getListApply(String idUser) async {
    try {
      List<dynamic> responseBody =
          await _applyRepository.getListApplyByIdUser(idUser);
      Iterable it = responseBody;
      List<Apply> list = it.map((e) => Apply.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkRecruitmentApplied(String rid, String idUser) async {
    try {
      List<Apply> listApply = await getListApply(idUser);
      List<String> listIdRecuitmentApplied = [];
      listApply.map((e) {
        listIdRecuitmentApplied.add(e.recruitmentId);
      }).toList();
      bool check = listIdRecuitmentApplied.contains(rid);
      return check;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCountApply() async {
    try {
      User user = await providerAuth.getUser();

      List<Apply> list = await getListApply(user.userId);
      notifyListeners();
      return list.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Apply>> getListApply7Day(String idUser) async {
    try {
      _isLoading = true;
      notifyListeners();
      List<Apply> listApply = await getListApply(idUser);
      List<Apply> list = [];
      listApply.map((e) {
        if (DateTime.now().difference(e.createdAt).inDays >= 0 &&
            DateTime.now().difference(e.createdAt).inDays <= 7) {
          list.add(e);
        }
      }).toList();
      _isLoading = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Apply>> getListApply30Day(String idUser) async {
    try {
      _isLoading = true;
      notifyListeners();
      List<Apply> listApply = await getListApply(idUser);
      List<Apply> list = [];
      listApply.map((e) {
        if (DateTime.now().difference(e.createdAt).inDays >= 7 &&
            DateTime.now().difference(e.createdAt).inDays <= 30) {
          list.add(e);
        }
      }).toList();
      _isLoading = false;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<Profile> getProfileApplied(String idApply) async {
    try {
      _isLoading = true;
      Map<String, dynamic> responseBody =
          await _applyRepository.getApplyByID(idApply);
      Profile profile = Profile.fromJson(responseBody);
      _isLoading = false;
      notifyListeners();
      return profile;
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      rethrow;
    }
  }
}
