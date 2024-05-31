import 'package:flutter/material.dart';
import 'package:spsp_desktop/models/qr_table/qr_table.dart';
import 'package:spsp_desktop/providers/cart_provider.dart';
import 'package:spsp_desktop/widgets/qr_table_screen.dart';

class QRTableDialog extends StatelessWidget {
  final List<QRTable> qrTableList;
  final CartProvider cartProvider;
  final void Function(VoidCallback) setState;

  const QRTableDialog({
    super.key,
    required this.qrTableList,
    required this.cartProvider,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ŠANK',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -90 * 3.1415926535 / 180,
                    child: const Text(
                      'PROZORI',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(width: 25),
                  TableWidget(
                    qrTableList: qrTableList,
                    onTap: (tableNumber) {
                      setState(() {
                        cartProvider?.cart.qrTable = qrTableList[tableNumber - 1];
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 25),
                  Transform.rotate(
                    angle: 90 * 3.1415926535 / 180,
                    child: const Text(
                      'TOALET',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text("Zatvori"),
                )
              ])
            ],
          ),
        ),
      );
}
