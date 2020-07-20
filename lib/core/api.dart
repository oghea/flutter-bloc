import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final baseUrl = 'https://gorest.co.in/public-api';
  final auth = '_format=json&access-token=9JzTOr3Fkqm9iIQ5xoVoe5FQu0fzEw3y9nqZ';

  Future<List<dynamic>> fetchUser(page) async {
    final response = await client
        .get("$baseUrl/users?page=$page&$auth");
    final results = json.decode(response.body);
    print('hello1');
    if (response.statusCode == 200) {
      return results['result'];
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<dynamic>> searchUser(val) async {
    final response = await client
        .get("$baseUrl/users?first_name=$val&$auth");
    final results = json.decode(response.body);
    print('hello2');
    if (response.statusCode == 200) {
      return results['result'];
    } else {
      throw Exception('Failed to load post');
    }
  }
}