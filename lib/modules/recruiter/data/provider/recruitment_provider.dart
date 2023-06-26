import 'dart:convert';
import 'dart:developer';
import 'package:app/modules/recruiter/data/provider/recruiter_provider.dart';
import 'package:app/configs/uri.dart';
import 'package:app/modules/candidate/data/models/apply_model.dart';
import 'package:app/modules/recruiter/data/repositories/recruitment_repository.dart';
import 'package:app/modules/recruiter/presentations/views/recruitment/widgets/filter_cv.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/shared/provider/provider_apply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecruitmentProvider extends ChangeNotifier {
  List<Recruitment> get listRecruitment => _listRecruitment;
  List<Recruitment> _listRecruitment = [];
  List<Recruitment> _listRecruitmentAll = [];
  int get totalShow => _totalShow;
  int _totalShow = 0;

  List<Apply> get listApply => _listApply;
  List<Apply> _listApply = [];
  Recruitment? get recentlyCreatedR => _recentlyCreatedR;
  Recruitment? _recentlyCreatedR;

  Recruitment? get showDetailRecruitment => _showDetailRecruitment;
  Recruitment? _showDetailRecruitment;
  Apply? get applyRecently => _applyRecently;
  Apply? _applyRecently;
  Tag? _tag;
  var listApplyAll = <Apply>[];
  Future getRecruitments(String id) async {
    try {
      final res = await RecruitmentService.getRecruitments(id);
      _listRecruitmentAll = res;
      _totalShow = _listRecruitmentAll
          .where((element) => element.statusShow == true)
          .toList()
          .length;
      await recentlyCreated();
      notifyListeners();

      await getAllCv();
    } on Exception catch (e, x) {
      log('Stack trace : $x');
    }
  }

  Future recentlyCreated() async {
    _listRecruitmentAll.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    _recentlyCreatedR = _listRecruitmentAll.last;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final res = prefs.getString(kSaveRecently);
    if (res != null) {
      _applyRecently = Apply.fromJson(jsonDecode(res) as Map<String, dynamic>);
    }
  }

  Future showListByStatus([Tag? tag]) async {
    _tag = tag;
    switch (tag) {
      case Tag.all:
        _listRecruitment = _listRecruitmentAll;
        break;
      case Tag.show:
        _listRecruitment =
            _listRecruitmentAll.where((e) => e.statusShow == true).toList();
        break;
      case Tag.hidden:
        _listRecruitment =
            _listRecruitmentAll.where((e) => e.statusShow == false).toList();
        break;
      default:
        _listRecruitment = _listRecruitmentAll;
    }
    notifyListeners();
  }

  Future createRecruitment(Recruitment recruitment) async {
    try {
      final res = await RecruitmentService.createRecruitment(recruitment);
      _recentlyCreatedR = res;
      _listRecruitment.add(res);
      _totalShow++;
      notifyListeners();
      Modular.to.pop();
    } catch (e) {
      log(e.toString());
    }
  }

  Future showDetail(Recruitment recruitment) async {
    _showDetailRecruitment = recruitment;
    notifyListeners();
  }

  Future getAllCv() async {
    listApplyAll.clear();
    final ids = _listRecruitmentAll.map((e) => e.id).toList();
    for (var id in ids) {
      final res = await ProviderApply().getListApplyByRecruitment(id!);
      listApplyAll = [...listApplyAll, ...res];
    }
    _listApply =
        listApplyAll.where((element) => element.statusApply != 0).toList();
    notifyListeners();
  }

  Future searchListCV(String value) async {
    if (value.isEmpty) {
      _listApply = listApplyAll;
    } else {
      _listApply = _listApply
          .where((e) => (e.comment).toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  Future updateRecruitment(Recruitment recruitment) async {
    try {
      final res = await RecruitmentService.updateRecruitment(recruitment);
      _listRecruitment[_listRecruitment
          .indexWhere((element) => element.id == recruitment.id)] = res;
      _showDetailRecruitment = res;
      ScaffoldMessenger.of(Modular.routerDelegate.navigatorKey.currentContext!)
          .showSnackBar(const SnackBar(content: Text('Tin đã được cập nhật')));
      notifyListeners();
      Modular.to.pop(res);
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateStatus(Recruitment recruitment) async {
    try {
      recruitment.statusShow = !recruitment.statusShow!;
      final res = await RecruitmentService.updateRecruitment(recruitment);
      _listRecruitment[_listRecruitment
          .indexWhere((element) => element.id == recruitment.id)] = res;
      _showDetailRecruitment = res;
      await showListByStatus(_tag);
      ScaffoldMessenger.of(Modular.routerDelegate.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(
              content: Text('Tin đã được ${res.statusShow! ? 'bật' : 'tắt'}')));
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future searchList(String value) async {
    if (value.isEmpty) {
      _listRecruitment = _listRecruitmentAll;
    } else {
      _listRecruitment = _listRecruitment
          .where((e) =>
              (e.title ?? '').toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  Future deleteRecruitment(String id) async {
    try {
      await RecruitmentService.deleteRecruitment(id);
      final recruiter = Modular.get<RecruiterProvider>().recruiter;
      await getRecruitments(recruiter.id);
      await showListByStatus(_tag);
      Modular.to.pop();
      ScaffoldMessenger.of(Modular.routerDelegate.navigatorKey.currentContext!)
          .showSnackBar(const SnackBar(content: Text('Tin đã được xoá')));
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
