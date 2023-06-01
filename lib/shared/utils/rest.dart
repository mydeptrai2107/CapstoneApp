import 'dart:convert';

import 'package:http/http.dart' as http;

class Rest {
  static late String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7IkNvbXBhbnlJZCI6IjY0NmY2Y2QyZGJkYmY2NGJmNTkyZjAxNiIsImFjY291bnRJZCI6IjY0NmY2Y2QyZGJkYmY2NGJmNTkyZjAxOCIsImVtYWlsIjoiZnJlZW1pbmRAZ21haWwuY29tIn0sImlhdCI6MTY4NTExMjQ1MywiZXhwIjoxNjg1MTEzMDUzfQ.ETLXYANj3b-maIvehd2RmE10PrC0Kdo0s1Xkq9_e4fo';
  static Map<String, String> _setHeaders() {
    return {'Authorization': 'Bearer $token'};
  }

  static Future<dynamic> get(String url,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? params}) async {
    final uri = Uri.parse(url).replace(queryParameters: params);

    final response = await http.get(
      uri,
      headers: headers,
    );
    final res = jsonDecode(response.body);
    return res;
  }

  static Future<dynamic> post(String url,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? params}) async {
    final uri = Uri.parse(url).replace(queryParameters: params);

    final response =
        await http.post(uri, headers: headers ?? _setHeaders(), body: body);
    final res = jsonDecode(response.body);
    return res;
  }

  static Future<dynamic> update(String url,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, dynamic>? params}) async {
    final uri = Uri.parse(url).replace(queryParameters: params);

    final response =
        await http.put(uri, headers: headers ?? _setHeaders(), body: body);
    final res = jsonDecode(response.body);
    return res;
  }
}
