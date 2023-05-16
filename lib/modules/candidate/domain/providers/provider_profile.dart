import 'package:app/modules/candidate/data/models/hive_models/user_model_hive.dart';
import 'package:app/modules/candidate/data/models/profile_model.dart';
import 'package:app/modules/candidate/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProvideProfile extends ChangeNotifier {
  ProfileRepository profileRepository = ProfileRepository();
  final _myBoxUser = Hive.box<UserModel>('user');

  bool _isLoadingCreate = true;
  bool get isLoadignCreate => _isLoadingCreate;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLoadingDelete = true;
  bool get isLoadingDelete => _isLoadingDelete;

  bool _isLoadingUpdateProfile = false;
  bool get isLoadingUpdateProfile => _isLoadingUpdateProfile;

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
      _isLoading = false;
      List<dynamic> responseBody =
          await profileRepository.getListProfile(idUser);
      Iterable it = responseBody;
      List<Profile> list = it.map((e) => Profile.fromJson(e)).toList();
      _isLoading = true;
      notifyListeners();
      return list;
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      rethrow;
    }
  }

  Future deleteProfile(String id) async {
    try {
      _isLoadingDelete = false;
      await profileRepository.deleteProfileById(id);
      _isLoadingDelete = true;
      notifyListeners();
    } catch (e) {
      _isLoadingDelete = true;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String id,
    required String name,
    required String pathCV,
  }) async {
    try {
      await profileRepository.updateUserProfile(id, name, pathCV);
      _isLoadingUpdateProfile = false;
      notifyListeners();
    } catch (e) {
      _isLoadingUpdateProfile = false;
      notifyListeners();
      rethrow;
    }
  }

  updateLoadingUpdateProfile(bool value) {
    _isLoadingUpdateProfile = value;
    notifyListeners();
  }
}
