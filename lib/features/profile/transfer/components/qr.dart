import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'scanner_to_transfer.dart';

class QR extends StatelessWidget {
  QR({
    super.key,
    required this.widget,
  });

  final ScannerToTransfer widget;
  Image? QRCode;
  int? accId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          getQRCode(context),
          SizedBox(height: 20),
          Text(
            "Ask your friend to scan this QR code",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            "\u{20B9} ${widget.balance}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "My balance",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 20,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Container getQRCode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: generateQRCode(context),
      ),
    );
  }

  QrImageView generateQRCode(BuildContext context) {
    return QrImageView(
      data: "${widget.balance},${widget.name},${widget.id},${widget.photo}",
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.02),
      foregroundColor: Colors.white,
      size: 200,
    );
  }
}
