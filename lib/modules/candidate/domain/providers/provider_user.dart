import 'dart:io';

import 'package:app/modules/candidate/data/repositories/user_repositories.dart';
import 'package:flutter/material.dart';

class ProviderUser extends ChangeNotifier {
  UserRepositories userRepositories = UserRepositories();

  bool _isLoadingUpdateUser = true;

  bool get isLoadingUpdateUser => _isLoadingUpdateUser;

  Future<void> updateUser(
      {required String firsName,
      required String lastName,
      required String? phone,
      required String? gender,
      File? avatar,
      required String id}) async {
    try {
      await userRepositories.updateUser(
          firsName: firsName,
          lastName: lastName,
          phone: phone,
          gender: gender,
          avatar: avatar,
          id: id);
      _isLoadingUpdateUser = false;
      notifyListeners();
    } catch (e) {
      _isLoadingUpdateUser = false;
      notifyListeners();
      rethrow;
    }
  }
}
