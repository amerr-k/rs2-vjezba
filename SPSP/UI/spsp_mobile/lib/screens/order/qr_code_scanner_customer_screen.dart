import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:spsp_mobile/screens/order/order_list_check_out_customer_screen.dart';

class QRCodeScannerCustomerScreen extends StatefulWidget {
  @override
  _QRCodeScannerCustomerScreenState createState() => _QRCodeScannerCustomerScreenState();
}

class _QRCodeScannerCustomerScreenState extends State<QRCodeScannerCustomerScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Skenirajte kod na Vašem stolu.'),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            _buildQrView(context),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: buildResult(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildResult() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration:
            BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: barcode != null
            ? ElevatedButton(
                onPressed: () {
                  if (barcode != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderListCheckOutCustomerScreen(qrTableId: barcode!.code),
                      ),
                    );
                  }
                },
                child: Text('Pogledaj narudžbu'),
              )
            : Center(child: Text('Skenirajte vaš QR kod na stolu', maxLines: 3)));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this._controller = controller;
    });

    _controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
