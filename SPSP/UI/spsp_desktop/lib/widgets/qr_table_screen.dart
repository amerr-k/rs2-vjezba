import 'package:flutter/material.dart';
import 'package:spsp_desktop/models/qr_table/qr_table.dart';

class TableWidget extends StatelessWidget {
  final List<QRTable> qrTableList;
  final Function(int) onTap;

  TableWidget({required this.qrTableList, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: List.generate(
          qrTableList.length,
          (index) {
            // bool isTaken = qrTableList[index].isTaken;
            int tableNumber = index + 1;
            return GestureDetector(
              onTap: () {
                onTap(tableNumber);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(120.0),
                ),
                margin: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Sto $tableNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
