import 'dart:convert';

import 'package:app/data/models/province.dart';
import 'package:http/http.dart' as http;

class ReporitoryMap {
  Future getProvince() async {
    String uri = 'https://provinces.open-api.vn/api/';
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data;
        List<Province> list = it.map((e) => Province.fromJson(e)).toList();
        return list;
      }
      throw Error();
    } catch (e) {
      return e;
    }
  }
}
