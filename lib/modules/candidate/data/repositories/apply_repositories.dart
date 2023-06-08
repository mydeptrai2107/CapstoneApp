import 'dart:convert';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class ApplyRepository {
  final String urlCreateApply = '${uriApiApp}api/apply';
  final String urlGetListApplyBuIdUser = '${uriApiApp}api/apply/uid/';

  Future<Map<String, dynamic>> createApply(
      String idProfile, String idRecruit, String comment) async {
    var url = Uri.parse(urlCreateApply);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_profile_id': idProfile,
          'recruitment_id': idRecruit,
          'comment': comment
        }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<dynamic>> getListApplyByIdUser(String id) async {
    var url = Uri.parse(urlGetListApplyBuIdUser + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.body;
    }
  }

  Future<Map<String, dynamic>> getApplyByID(String id) async {
    var url = Uri.parse('$urlCreateApply/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['userProfile'];
    } else {
      throw response.body;
    }
  }
}
