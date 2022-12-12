import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/card_chart.dart';
import 'package:toko_online/components/card_chartless.dart';
import 'package:toko_online/components/card_transaksi.dart';
import 'package:toko_online/constants/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool _isSelected = false;
  @override
  dynamic arrayData = [];
  dynamic arrayGagal = [];
  var arrayHarga = [];
  var total = 0;
  String dataId = '';
  Future<dynamic>? _future;

  Future connectToAPI() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/postcheckout/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/postcheckout/");

    var apiResult = await http.post(url, body: {"id_user": dataId});
    var arrayjson = json.decode(apiResult.body);
    arrayData.addAll(arrayjson['status']['data']);
  }

  Future deleteCheckout(id) async {
    Uri url = Uri.parse("http://localhost/backend-tokoonline/deletecheckout/");

    var apiResult = await http.post(url, body: {"id_checkout": id});
    var arrayjson = json.decode(apiResult.body);
    return arrayjson['status']['code'];
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

  Future deleteData(id) async {
    Uri url = Uri.parse("http://localhost/backend-tokoonline/postcheckout/");

    var apiResult = await http.post(url, body: {"id_checkout": id});
    var arrayjson = json.decode(apiResult.body);
    return arrayjson['status']['code'];
  }

  Widget build(BuildContext context) {
    double sum = arrayHarga
        .map((e) => double.parse(e['total']))
        .fold(0, (prev, amount) => prev + amount);
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
          backgroundColor: blackColor,
        ),
        body: Stack(children: [
          Container(
              color: whiteColor,
              margin: EdgeInsets.only(bottom: 100),
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.data == []) {
                    return Text('Loading');
                  } else {
                    return ListView.builder(
                        itemCount: arrayData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardChartLess(
                            id: arrayData[index]['id_checkout'],
                            desc: arrayData[index]['nama_barang'],
                            image: arrayData[index]['gambar'],
                            totalbarang: arrayData[index]['total_barang'],
                            totalbelanja: arrayData[index]['total_harga'],
                            value: arrayData[index]['checked'],
                            onChanged: (bool newValue) {
                              setState(() {
                                arrayData[index]['checked'] = newValue;
                              });
                              if (arrayData[index]['checked'] == true) {
                                arrayHarga.addAll({
                                  {
                                    'id': arrayData[index]['id_checkout'],
                                    'total': (arrayData[index]['total_harga'] *
                                            arrayData[index]['total_barang'])
                                        .toString()
                                  }
                                });
                              } else {
                                arrayHarga.removeWhere((item) =>
                                    item['id'] ==
                                    arrayData[index]['id_checkout']);
                              }
                            },
                            onMinus: (() {
                              if (arrayData[index]['checked'] == false) {
                                setState(() {
                                  arrayData[index]['total_barang']--;
                                });
                              }
                            }),
                            onPluss: (() {
                              if (arrayData[index]['checked'] == false) {
                                setState(() {
                                  arrayData[index]['total_barang']++;
                                });
                              }
                            }),
                            onDelete: (() {
                              deleteCheckout(arrayData[index]['id_checkout'])
                                  .then((value) {
                                if (value == 200) {
                                  print('berhasil');
                                } else {
                                  print(value);
                                }
                              });
                            }),
                          );
                        });
                  }
                },
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 10,
                child: Container(
                  color: whiteColor,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Belanja',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text('Rp. ' + sum.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))
                        ],
                      ),
                      InkWell(
                        splashColor: whiteColor,
                        child: SizedBox(
                            width: 150,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  print('checkout');
                                },
                                child: Text('Checkout'),
                                style: ElevatedButton.styleFrom(
                                    primary: blackColor),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ))
        ]));
  }
}
