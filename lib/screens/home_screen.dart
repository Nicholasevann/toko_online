import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toko_online/api/getdatauser.dart';
import 'package:toko_online/components/card_produk.dart';
import 'package:toko_online/components/header_home.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/database/mysql.dart';
import 'package:toko_online/routes/drawer_navigation.dart';
import 'package:toko_online/screens/detailhome_screen.dart';
import 'package:toko_online/screens/detailsearch_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  dynamic arrayData = [];
  Future<dynamic>? _future;
  Future connectToAPI() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getproduk/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/getproduk/");

    var hasilResponse = await http.get(url);
    var dataJSON = json.decode(hasilResponse.body);
    arrayData.addAll(dataJSON);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = connectToAPI();
  }

  Widget build(BuildContext context) {
    // arrayData.map((val) => print(val));

    return Scaffold(
      body: Container(
        color: whiteColor,
        child: ListView(
          children: [
            HeaderHome(),
            Container(
              padding: EdgeInsets.all(16),
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.data == []) {
                    return Text('Loading');
                  } else {
                    return Wrap(
                      children: List.generate(
                        arrayData.length,
                        (index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailHome(
                                            desc: arrayData[index]
                                                ['nama_produk'],
                                            image: arrayData[index]['gambar'],
                                            harga: arrayData[index]['harga'],
                                            stock: arrayData[index]['stok'],
                                            kategori: arrayData[index]
                                                ['nama_kategori'],
                                            berat: arrayData[index]['berat'],
                                            preorder: arrayData[index]
                                                ['preorder'],
                                            berbahaya: arrayData[index]
                                                ['berbahaya'],
                                            deskripsi: arrayData[index]
                                                ['deskripsi'],
                                            min_pemesanan: arrayData[index]
                                                ['min_pemesanan'])));
                              },
                              child: CardProduk(
                                desc: arrayData[index]['nama_produk'],
                                image: arrayData[index]['gambar'],
                                harga: arrayData[index]['harga'],
                                stok: arrayData[index]['stok'],
                                kategori: arrayData[index]['nama_kategori'],
                              ));
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
