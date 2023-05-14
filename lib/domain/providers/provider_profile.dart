import 'package:app/data/models/hive_models/user_model_hive.dart';
import 'package:app/data/models/profile_model.dart';
import 'package:app/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProvideProfile extends ChangeNotifier {
  ProfileRepository profileRepository = ProfileRepository();
  final _myBoxUser = Hive.box<UserModel>('user');

  bool _isLoadingCreate = true;

  bool get isLoadignCreate => _isLoadingCreate;

  Future<Profile> createProfile(String name) async {
    String idUser = _myBoxUser.get('userLogin')!.id;
    try {
      _isLoadingCreate = false;
      Map<String, dynamic> responseBody =
          await profileRepository.createProfile(name, idUser);
      Profile profile = Profile.fromJson(responseBody);
      _isLoadingCreate = true;
      notifyListeners();
      return profile;
    } catch (e) {
      _isLoadingCreate = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Profile>> getListProfile() async {
    String idUser = _myBoxUser.get('userLogin')!.id;
    try {
      _isLoadingCreate = false;
      List<dynamic> responseBody =
          await profileRepository.getListProfile(idUser);
      Iterable it = responseBody;
      List<Profile> list = it.map((e) => Profile.fromJson(e)).toList();
      _isLoadingCreate = true;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoadingCreate = true;
      notifyListeners();
      rethrow;
    }
  }
}
