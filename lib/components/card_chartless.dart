import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class CardChartLess extends StatelessWidget {
  String image, desc, id;
  int totalbarang, totalbelanja;
  bool value;
  ValueChanged<bool> onChanged;
  Function onPluss;
  Function onMinus;
  Function onDelete;
  var arrayHarga = [];
  CardChartLess({
    Key? key,
    required this.id,
    required this.desc,
    required this.image,
    required this.totalbarang,
    required this.totalbelanja,
    required this.value,
    required this.onChanged,
    required this.onPluss,
    required this.onMinus,
    required this.onDelete,
  }) : super(key: key);

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
                        onChanged: (bool? newValue) {
                          onChanged(newValue!);
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
                                                        onMinus();
                                                      })
                                                  : Container(),
                                              Text(totalbarang.toString()),
                                              IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    onPluss();
                                                  }),
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    onDelete();
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
