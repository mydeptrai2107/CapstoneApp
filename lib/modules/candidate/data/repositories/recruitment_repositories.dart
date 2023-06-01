import 'dart:convert';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class RecruitmentRepository {
  final String urlGetRecruitByCompany = '${uriApiApp}api/recruitment/comid/';
  final String urlGetRecruitByName = '${uriApiApp}api/recruitment/search/';
  final String urlGetRecruitment = '${uriApiApp}api/recruitment/getAll';
  final String urlGetRecruitmentById = '${uriApiApp}api/recruitment/recrid/';

  Future<Map<String, dynamic>> getRecruitById(String id) async {
    var url = Uri.parse(urlGetRecruitmentById + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<dynamic>> getListRecruitByCompany(String id) async {
    var url = Uri.parse(urlGetRecruitByCompany + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<dynamic>> getListRecruitmentByName(String name) async {
    var url = Uri.parse(urlGetRecruitByName + name);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<dynamic>> getListRecruitment() async {
    var url = Uri.parse(urlGetRecruitment);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }
}
