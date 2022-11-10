import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteService {
  static getPosts() async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5640d00c8bad4178ba6c0f733d304a2a');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json;
    }
  }
}
