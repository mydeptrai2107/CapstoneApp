import 'package:app/modules/candidate/data/models/hive_models/user_model_hive.dart';
import 'package:app/modules/candidate/data/models/user_model.dart';
import 'package:app/modules/candidate/data/repositories/authen_repositories.dart';
import 'package:app/modules/candidate/data/repositories/user_repositories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProviderAuth extends ChangeNotifier {
  final AuthenRepositoris authenRepositoris = AuthenRepositoris();
  final UserRepositories userRepositories = UserRepositories();
  final _myBoxUser = Hive.box<UserModel>('user');

  late String _accessToken;
  late String _refreshToken;
  bool _isLoadingLogin = false;
  bool _isLogged = false;
  bool _isLoadingRegister = false;
  bool _isRegistered = false;

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLogged => _isLogged;

  bool get isLoadingRegister => _isLoadingRegister;
  bool get isRegistered => _isRegistered;

  late User _user;
  User get user => _user;

  Future<void> register(String email, String password, String confirmPW,
      String firstName, String lastName) async {
    try {
      bool reponseBody = await authenRepositoris.register(
          email, password, confirmPW, firstName, lastName);
      _isLoadingRegister = false;
      if (reponseBody) _isRegistered = true;
    } catch (e) {
      _isLoadingLogin = false;
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Map<String, dynamic> responseBody =
          await authenRepositoris.login(email, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', responseBody['accessToken']);
      await prefs.setString('refreshToken', responseBody['refreshToken']);

      _accessToken = responseBody['accessToken'];
      _refreshToken = responseBody['refreshToken'];
      getUser();
      _isLoadingLogin = false;
      _isLogged = true;
      notifyListeners();
    } catch (e) {
      _isLoadingLogin = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken')!;
      Map<String, dynamic> responseBody =
          await authenRepositoris.getUser(accessToken);
      _myBoxUser.put(
          'userLogin',
          UserModel(
              firstName: responseBody['first_name'] ?? '',
              lastName: responseBody['last_name'] ?? '',
              phone: responseBody['phone'] ?? '',
              id: responseBody['id'],
              gender: responseBody['gender'],
              avatar: responseBody['avatar'] ?? ''));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAvatar() async {
    try {
      await authenRepositoris.checkTokenExpiration();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken')!;
      Map<String, dynamic> responseBody =
          await authenRepositoris.getUser(accessToken);
      return responseBody['avatar'] != ''
          ? userRepositories.getAvatar(responseBody['avatar'])
          : '';
    } catch (e) {
      rethrow;
    }
  }

  void setLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  void setLoadingRegister(bool value) {
    _isRegistered = value;
    notifyListeners();
  }
}
