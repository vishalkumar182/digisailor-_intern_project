import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/auth/login_model.dart';

class LoginService {
  static final Map<String, String> _dummyUser = {
    'name': 'Vishal Kumar',
    'id': 'SVP-1001',
    'email': 'supervisor@example.com',
    'firstName': 'Vishal',
    'lastName': 'Kumar',
    'dob': '1990-01-01',
    'position': 'Supervisor',
    'country': 'India',
    'state': 'Jharkhand',
    'city': 'Dumka',
    'photo': '', // Store image path
  };

  // Dummy address data: Country -> States -> Cities
  static final Map<String, Map<String, List<String>>> _addressData = {
    'India': {
      'Jharkhand': ['Dumka', 'Ranchi', 'Jamshedpur'],
      'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    },
    'USA': {
      'California': ['Los Angeles', 'San Francisco', 'San Diego'],
      'New York': ['New York City', 'Buffalo', 'Albany'],
    },
    'UK': {
      'England': ['London', 'Manchester', 'Birmingham'],
      'Scotland': ['Edinburgh', 'Glasgow', 'Aberdeen'],
    },
    'Canada': {
      'Ontario': ['Toronto', 'Ottawa', 'Mississauga'],
      'British Columbia': ['Vancouver', 'Victoria', 'Kelowna'],
    },
    'Australia': {
      'New South Wales': ['Sydney', 'Newcastle', 'Wollongong'],
      'Victoria': ['Melbourne', 'Geelong', 'Ballarat'],
    },
  };

  Future<LoginModel?> loginUser(LoginModel loginModel) async {
    await Future.delayed(const Duration(seconds: 2));
    if (loginModel.email == 'supervisor@example.com' &&
        loginModel.password == '123456') {
      _dummyUser.addAll({
        'name': 'Vishal Kumar',
        'id': 'SVP-1001',
        'email': loginModel.email,
        'firstName': 'Vishal',
        'lastName': 'Kumar',
        'dob': '1990-01-01',
        'position': 'Supervisor',
        'country': 'India',
        'state': 'Jharkhand',
        'city': 'Dumka',
        'photo': '',
      });
      debugPrint('User logged in: $_dummyUser');
      return LoginModel(
        email: loginModel.email,
        password: loginModel.password,
        userType: 'supervisor',
      );
    }
    return null;
  }

  Map<String, String> getDummyUser() => Map.unmodifiable(_dummyUser);

  void clearDummyUser() {
    debugPrint('Clearing user data: $_dummyUser');
    _dummyUser.clear();
  }

  void updatePersonalDetails({
    required String firstName,
    String? lastName,
    required String dob,
    required String position,
    String? photo,
  }) {
    _dummyUser.addAll({
      'firstName': firstName,
      'lastName': lastName ?? '',
      'dob': dob,
      'position': position,
      'name': '$firstName ${lastName ?? ''}'.trim(),
      if (photo != null) 'photo': photo,
    });
    debugPrint('Updated personal details: $_dummyUser');
  }

  void updateAddress({
    required String country,
    required String state,
    required String city,
  }) {
    _dummyUser.addAll({'country': country, 'state': state, 'city': city});
    debugPrint('Updated address: $_dummyUser');
  }

  List<String> getCountries() => _addressData.keys.toList();

  List<String> getStates(String country) =>
      _addressData[country]?.keys.toList() ?? [];

  List<String> getCities(String country, String state) =>
      _addressData[country]?[state] ?? [];
}
