import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider
    extends ChangeNotifier {
  final ApiService _apiService =
      ApiService();

  List<UserModel> users = [];

  bool isLoading = false;

  int page = 1;

  int totalPages = 1;

  String selectedUser = "Selected User Name";

  Future<void> fetchUsers() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final result =
          await _apiService.getUsers(page);

      users.addAll(
          result['users']);

      totalPages =
          result['total_pages'];
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshUsers() async {
    users.clear();

    page = 1;

    await fetchUsers();
  }

  Future<void> loadMore() async {
    if (page >= totalPages) return;

    page++;

    await fetchUsers();
  }

  void setSelectedUser(
      String name) {
    selectedUser = name;
    notifyListeners();
  }
}