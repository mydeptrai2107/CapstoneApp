import 'dart:io';

import 'package:app/configs/uri.dart';
import 'package:http/http.dart' as http;

class UserRepositories {
  final String urlUpdateUser = '${uriApiApp}api/user/';
  final String urlAvatar = '${uriApiApp}static/cv/';

  Future<void> updateUser(
      {required String firsName,
      required String lastName,
      required String? phone,
      required String? gender,
      required File? avatar,
      required String id}) async {
    var url = Uri.parse(urlUpdateUser + id);
    final request = http.MultipartRequest('PUT', url);

    request.fields['first_name'] = firsName;
    request.fields['last_name'] = lastName;
    request.fields['phone'] = phone ?? '';
    request.fields['gender'] = gender ?? '';
    if (avatar != null) {
      File imageFile = File(avatar.path);
      final multipartFile =
          await http.MultipartFile.fromPath('avatar', imageFile.path);
      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode != 200) {
      throw response.statusCode;
    }
  }

  String getAvatar(String image) {
    return urlAvatar + image;
  }
}
