import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _id;
  String _email;
  String _name;
  String _profile;

  final String _idKey = 'userId';
  final String _emailKey = 'userEmail';
  final String _nameKey = 'userName';
  final String _profileKey = 'userProfile';

  String get id => _id;
  String get email => _email;
  String get name => _name;
  String get profile => _profile;

  UserProvider()
      : _id = '',
        _email = '',
        _name = '',
        _profile = '' {
    _loadUserData();
  }

  void setId(String id) {
    _id = id;
    _saveUserData();
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    _saveUserData();
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    _saveUserData();
    notifyListeners();
  }

  void setProfile(String profile) {
    _profile = profile;
    _saveUserData();
    notifyListeners();
  }

  void clear() {
    _id = '';
    _email = '';
    _name = '';
    _profile = '';
    _clearUserData();
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString(_idKey) ?? '';
    _email = prefs.getString(_emailKey) ?? '';
    _name = prefs.getString(_nameKey) ?? '';
    _profile = prefs.getString(_profileKey) ?? '';
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_idKey, _id);
    await prefs.setString(_emailKey, _email);
    await prefs.setString(_nameKey, _name);
    await prefs.setString(_profileKey, _profile);
  }

  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_idKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_profileKey);
  }
}
