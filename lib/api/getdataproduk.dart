import 'dart:convert';

import 'package:http/http.dart' as http;

class GetDataProduk {
  String id, name, email, password;
  GetDataProduk(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
  static connectToAPI(String id) async {
    Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getdataproduk/");

    var hasilResponse = await http.get(url);
    var data = json.decode(hasilResponse.body);
    return GetDataProduk(
        id: data["id_produk"].toString(),
        name: data["nama_produk"],
        email: data["email"],
        password: data["password"]);
  }
}
