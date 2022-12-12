import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class CardChart extends StatefulWidget {
  final String desc, image, id;
  final int totalbarang, totalbelanja;
  final bool value;
  final ValueChanged<bool> onChanged;
  const CardChart({
    Key? key,
    required this.id,
    required this.desc,
    required this.image,
    required this.totalbarang,
    required this.totalbelanja,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CardChart> createState() => _CardChartState(
        this.id,
        this.desc,
        this.image,
        this.totalbarang,
        this.totalbelanja,
        this.value,
        this.onChanged,
      );
}

class _CardChartState extends State<CardChart> {
  _CardChartState(
    this.id,
    this.desc,
    this.image,
    this.totalbarang,
    this.totalbelanja,
    this.value,
    this.onChanged,
  );
  final String image, desc, id;
  int totalbarang, totalbelanja;
  bool value;
  final ValueChanged<bool> onChanged;
  var arrayHarga = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: blackColor,
                        value: value,
                        onChanged: (newValue) {
                          setState(() {
                            value = newValue!;
                            if (value == true) {
                              arrayHarga.addAll({
                                {'id': id, 'total': totalbelanja * totalbarang}
                              });
                            } else {
                              arrayHarga
                                  .removeWhere((item) => item['id'] == id);
                            }
                          });
                        },
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 80,
                                          height: 80,
                                          child: Image.network(image))),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              desc,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: blackColor),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Total Barang : ' +
                                                totalbarang.toString() +
                                                ' barang',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              totalbarang != 1
                                                  ? IconButton(
                                                      icon: Icon(Icons.remove),
                                                      onPressed: () {
                                                        setState(() {
                                                          totalbarang--;
                                                        });
                                                      })
                                                  : Container(),
                                              Text(totalbarang.toString()),
                                              IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    setState(() {
                                                      totalbarang++;
                                                    });
                                                  })
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Total Harga',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: blackColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Rp. ' + (totalbelanja * totalbarang).toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: blackColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
