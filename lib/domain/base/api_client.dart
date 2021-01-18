import 'dart:convert';

import 'package:http/http.dart';

class ApiClient {
  static ApiClient _instance;

  Client http;

  ApiClient._();

  factory ApiClient() {
    if (_instance == null) {
      _instance = ApiClient._();
      _instance.http = new Client();
    }

    return _instance;
  }

  Future<dynamic> get(String url) async {
    final finalUrl = 'https://mangamint.kaedenoki.net/api/' + url;
    print(finalUrl);
    final Response response = await http.get(finalUrl);
    return json.decode(response.body);
  }
}
