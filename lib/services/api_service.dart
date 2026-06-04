import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class ApiService {
  static const String apiKey =
      "free_user_3Efox9HiYC6Q96aR4HHYTILQlic";

  Future<Map<String, dynamic>> getUsers(
      int page) async {
    final response = await http.get(
      Uri.parse(
          'https://reqres.in/api/users?page=$page&per_page=10'),
      headers: {
        'x-api-key': apiKey,
      },
    );

    final json =
        jsonDecode(response.body);

    List<UserModel> users =
        (json['data'] as List)
            .map(
              (e) =>
                  UserModel.fromJson(e),
            )
            .toList();

    return {
      'users': users,
      'total_pages':
          json['total_pages'],
    };
  }
}