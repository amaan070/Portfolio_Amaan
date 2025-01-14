import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _data;
  List<dynamic>? _repositories;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get data => _data;
  List<dynamic>? get repositories => _repositories;

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    //fetch User Profile
    http.Response response;
    response =
        await http.get(Uri.parse("https://api.github.com/users/amaan070"));

    if (response.statusCode == 200) {
      final dataMap = jsonDecode(response.body);
      _data = dataMap;
    } else {
      _data = null;
    }

    //fetch User Repos
    http.Response reposResponse;
    reposResponse = await http
        .get(Uri.parse("https://api.github.com/users/amaan070/repos"));

    if (reposResponse.statusCode == 200) {
      final reposList = jsonDecode(reposResponse.body);
      _repositories = reposList;
    } else {
      _repositories = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
