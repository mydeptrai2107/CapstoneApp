import 'dart:convert';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final String urlCreateCV = '${uriApiApp}api/user/';

  Future<Map<String, dynamic>> createProfile(String name, String idUser) async {
    var url = Uri.parse('$urlCreateCV$idUser/profile');
    final reponse = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}));

    if (reponse.statusCode == 200) {
      final reponseBody = jsonDecode(reponse.body);
      return reponseBody;
    } else {
      throw reponse.body;
    }
  }

  Future<List<dynamic>> getListProfile(String idUser) async {
    var url = Uri.parse('$urlCreateCV$idUser/profiles');
    final reponse = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (reponse.statusCode == 200) {
      final reponseBody = jsonDecode(reponse.body);
      return reponseBody;
    } else {
      throw reponse.body;
    }
  }
}
