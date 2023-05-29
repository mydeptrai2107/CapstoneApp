import 'package:app/modules/candidate/data/models/user_model.dart';
import 'package:app/modules/candidate/data/repositories/authen_repositories.dart';
import 'package:app/modules/candidate/data/repositories/user_repositories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderAuth extends ChangeNotifier {
  final AuthenRepositoris authenRepositoris = AuthenRepositoris();
  final UserRepositories userRepositories = UserRepositories();

  late String _accessToken;
  late String _refreshToken;
  bool _isLoadingLogin = false;
  bool _isLogged = false;
  bool _isLoadingRegister = false;

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLogged => _isLogged;

  bool get isLoadingRegister => _isLoadingRegister;

  late User _user;
  User get user => _user;

  Future<void> register(String email, String password, String confirmPW,
      String firstName, String lastName) async {
    try {
      _isLoadingRegister = true;
      await authenRepositoris.register(
          email, password, confirmPW, firstName, lastName);
      _isLoadingRegister = false;
      notifyListeners();
    } catch (e) {
      _isLoadingRegister = false;
      notifyListeners();
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

      _isLoadingLogin = false;
      _isLogged = true;
      notifyListeners();
    } catch (e) {
      _isLoadingLogin = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<String> getNameUser() async {
    try {
      User user = await getUser();
      return '${user.firstName} ${user.lastName}';
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      await authenRepositoris.checkTokenExpiration();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken')!;
      Map<String, dynamic> responseBody =
          await authenRepositoris.getUser(accessToken);
      User user = User.fromJson(responseBody);
      notifyListeners();
      return user;
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
      return responseBody['avatar'] == null
          ? ''
          : userRepositories.getAvatar(responseBody['avatar']);
    } catch (e) {
      rethrow;
    }
  }

  void setLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }
}
