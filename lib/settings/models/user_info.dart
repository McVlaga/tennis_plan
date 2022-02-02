import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../services/storage_manager.dart';

class UserInfo with ChangeNotifier {
  String? _firstName;
  String? _lastName;
  Country? _country;

  UserInfo();

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  Country? get country => _country;

  Future<void> loadUserInfo() async {
    _firstName = await StorageManager.readData('firstName');
    _lastName = await StorageManager.readData('lastName');
    notifyListeners();
  }

  void setFirstName(String firstName) async {
    _firstName = firstName;
    StorageManager.saveData('firstName', _firstName);
    notifyListeners();
  }

  void setLastName(String lastName) async {
    _lastName = lastName;
    StorageManager.saveData('lastName', _lastName);
    notifyListeners();
  }
}
