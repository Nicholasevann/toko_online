import 'dart:convert';

import 'package:http/http.dart' as http;

class GetResult {
  static connectToAPI() async {
    Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getuser/");

    var hasilResponse = await http.get(url);
    var dataJSON = json.decode(hasilResponse.body.toString());

    return dataJSON;
  }
}
