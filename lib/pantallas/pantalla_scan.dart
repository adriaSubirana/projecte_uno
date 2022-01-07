import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projecte_uno/pantallas/desp_qr.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? _qrCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            qrScan();
          },
          child: Text("QR Scan")),
    ));
  }

  Future<void> qrScan() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        _qrCode = qrCode;
      });

      if (_qrCode != '-1')
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => desp_qr(partidaa: _qrCode)));
    } on PlatformException {
      _qrCode = "Fail";
    }
  }
}
