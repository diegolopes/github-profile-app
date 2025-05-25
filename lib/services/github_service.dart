import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';

class GithubService {
  Future<GithubUser> fetchUser(String username) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/users/$username'),
    );
    if (response.statusCode == 200) {
      return GithubUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Usuário não encontrado ou algum outro erro ocorreu.');
    }
  }
}