import 'dart:convert';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  final String urlGetAllCompany = '${uriApiApp}api/company/';
  final String urlGetCompanyByName = '${uriApiApp}api/company/search/';
  static const  String urlAvatarCompany = '${uriApiApp}static/image/';


  Future<List<dynamic>> getListCompany() async {
    var url = Uri.parse(urlGetAllCompany);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<dynamic>> getListCompanyByName(String nameCompany) async {
    var url = Uri.parse(urlGetCompanyByName + nameCompany);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  static String getAvatar(String image) {
    return urlAvatarCompany + image;
  }
}
