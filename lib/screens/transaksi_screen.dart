import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/card_transaksi.dart';
import 'package:toko_online/components/header_home.dart';
import 'package:toko_online/constants/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  @override
  dynamic arrayData = [];
  Future<dynamic>? _future;
  String dataId = '';
  Future connectToAPI() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/gettransaksi/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/gettransaksi/");

    var hasilResponse = await http.get(url);
    var dataJSON = json.decode(hasilResponse.body);
    arrayData.addAll(dataJSON);
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataId = (prefs.getString('dataId') ?? '');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter().whenComplete(() {
      _future = connectToAPI();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: ListView(
          children: [
            HeaderHome(),
            FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.data == []) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: arrayData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardTransaksi(
                          desc: arrayData[index]['nama_produk'],
                          image: arrayData[index]['gambar'],
                          inv: arrayData[index]['invoice'],
                          date: arrayData[index]['tanggal_pembelian'],
                          totalbarang: arrayData[index]['qty'],
                          totalbelanja: arrayData[index]['total'],
                        );
                      });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
