import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResult {
  String id, name, job, created;

  PostResult({
    required this.id,
    required this.name,
    required this.job,
    required this.created,
  });

  static connectToAPI(String name, String job) async {
    Uri apiURL = Uri.parse("https://reqres.in/api/users");

    var apiResult = await http.post(apiURL, body: {"name": name, "job": job});
    var jsonObject = jsonDecode(apiResult.body);

    return PostResult(
        id: jsonObject["id"],
        name: jsonObject["name"],
        job: jsonObject["job"],
        created: jsonObject["createdAt"]);
  }
}
