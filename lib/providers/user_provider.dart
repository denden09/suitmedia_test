import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasError = false;

  int page = 1;
  int totalPages = 1;

  String selectedUser = "No User Selected";

  Future<void> fetchUsers() async {
    if (isLoading) return;

    isLoading = true;
    hasError = false;

    notifyListeners();

    try {
      final result =
          await _apiService.getUsers(page);

      users.addAll(result['users']);

      filteredUsers =
          List.from(users);

      totalPages =
          result['total_pages'];
    } catch (e) {
      hasError = true;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshUsers() async {
    users.clear();
    filteredUsers.clear();

    page = 1;

    await fetchUsers();
  }

  Future<void> loadMore() async {
    if (page >= totalPages) return;

    isLoadingMore = true;
    notifyListeners();

    page++;

    try {
      final result =
          await _apiService.getUsers(page);

      users.addAll(result['users']);

      filteredUsers =
          List.from(users);
    } catch (_) {}

    isLoadingMore = false;
    notifyListeners();
  }

  void searchUser(String query) {
    if (query.isEmpty) {
      filteredUsers =
          List.from(users);
    } else {
      filteredUsers = users
          .where(
            (user) => user.fullName
                .toLowerCase()
                .contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }

    notifyListeners();
  }

  void setSelectedUser(
      String name) {
    selectedUser = name;
    notifyListeners();
  }
}