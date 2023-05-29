import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:flutter/material.dart';

class ProviderCompany extends ChangeNotifier {
  CompanyRepository companyRepository = CompanyRepository();

  bool _isLoadingGetList = false;
  bool get isLoadingGetList => _isLoadingGetList;

  bool _isLoadingSearch = false;
  bool get isLoadingSearch => _isLoadingSearch;

  Future<List<Company>> getListCompany() async {
    try {
      _isLoadingGetList = true;
      List<dynamic> responseBody = await companyRepository.getListCompany();
      Iterable it = responseBody;
      List<Company> listCompany = it.map((e) => Company.fromJson(e)).toList();
      _isLoadingGetList = false;
      notifyListeners();
      return listCompany;
    } catch (e) {
      _isLoadingGetList = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Company>> getCompanyByName(String name) async {
    try {
      _isLoadingSearch = true;
      List<dynamic> responseBody =
          await companyRepository.getListCompanyByName(name);
      Iterable it = responseBody;
      List<Company> listCompany = it.map((e) => Company.fromJson(e)).toList();
      _isLoadingSearch = false;
      notifyListeners();
      return listCompany;
    } catch (e) {
      _isLoadingSearch = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<Company> getCompanyById(String id) async {
    try {
      Map<String, dynamic> responseBody =
          await companyRepository.getCompanyById(id);
      notifyListeners();
      return Company.fromJson(responseBody['company']);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getQuantityCompany() async {
    try {
      List<dynamic> responseBody = await companyRepository.getListCompany();
      notifyListeners();
      return responseBody.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Company>> getListCompanyPaging(int number) async {
    try {
      _isLoadingGetList = true;
      List<dynamic> responseBody = await companyRepository.getListCompany();
      Iterable it = responseBody;
      List<Company> listCompany = it.map((e) => Company.fromJson(e)).toList();
      List<Company> listPaging = [];
      if (8 * number < listCompany.length) {
        listPaging = listCompany.sublist(8 * (number - 1), 8 * number);
      } else {
        listPaging = listCompany.sublist(8 * (number - 1));
      }
      notifyListeners();
      return listPaging;
    } catch (e) {
      _isLoadingGetList = true;
      notifyListeners();
      rethrow;
    }
  }
}
