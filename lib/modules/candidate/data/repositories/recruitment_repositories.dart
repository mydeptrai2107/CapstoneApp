import 'dart:convert';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class RecruitmentRepository {
  final String urlGetRecruitByCompany = '${uriApiApp}api/recruitment/';

  Future<List<dynamic>> getListRecruitByCompany(String id) async {
    var url = Uri.parse(urlGetRecruitByCompany + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }


}
