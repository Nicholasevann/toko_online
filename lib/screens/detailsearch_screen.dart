import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/card_search.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/routes/bottom_navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/detailhome_screen.dart';

class DetailSearch extends StatefulWidget {
  const DetailSearch({Key? key}) : super(key: key);

  @override
  State<DetailSearch> createState() => _DetailSearchState();
}

class _DetailSearchState extends State<DetailSearch> {
  dynamic arrayData = [];
  Future<dynamic>? _future;
  Future connectToAPI() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getproduk/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/getproduk/");

    var hasilResponse = await http.get(url);
    var dataJSON = json.decode(hasilResponse.body);
    arrayData.addAll(dataJSON);
  }

  List searchResult = [];
  void searchProduct(String query) {
    searchResult.clear();
    final product = arrayData.map((val) {
      final titleLower = val['nama_produk'].toLowerCase();
      final searchLower = query.toLowerCase();
      if (titleLower.contains(searchLower)) {
        searchResult.add(val);
      }
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = connectToAPI();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: whiteColor,
          child: ListView(
            children: [
              Material(
                elevation: 3,
                child: Container(
                  color: whiteColor,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BottomNavigation();
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/back.png'))),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            print('Search Tap!');
                          },
                          child: Container(
                            height: 50,
                            child: TextField(
                              autofocus: true,
                              onChanged: searchProduct,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: blackColor, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: darkGreyColor, width: 1.0),
                                ),
                                hintText: 'Search Product ...',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Align(
                    child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.data == []) {
                      return Text('Loading');
                    } else {
                      return Wrap(
                        children: List.generate(
                          searchResult.length,
                          (index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailHome(
                                              desc: searchResult[index]
                                                  ['nama_produk'],
                                              image: searchResult[index]
                                                  ['gambar'],
                                              harga: searchResult[index]
                                                  ['harga'],
                                              stock: searchResult[index]
                                                  ['stok'],
                                              kategori: searchResult[index]
                                                  ['nama_kategori'],
                                              berat: searchResult[index]
                                                  ['berat'],
                                              preorder: searchResult[index]
                                                  ['preorder'],
                                              berbahaya: searchResult[index]
                                                  ['berbahaya'],
                                              deskripsi: searchResult[index]
                                                  ['deskripsi'],
                                              min_pemesanan: searchResult[index]
                                                  ['min_pemesanan'])));
                                },
                                child: CardSearch(
                                  desc: searchResult[index]['nama_produk'],
                                  image: searchResult[index]['gambar'],
                                  harga: searchResult[index]['harga'],
                                ));
                          },
                        ),
                      );
                    }
                  },
                )),
              ),
            ],
          )),
    );
  }
}
