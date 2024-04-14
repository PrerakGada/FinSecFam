import 'package:auto_route/auto_route.dart';
import 'package:finsec/features/profile/transfer/components/scanner_to_transfer.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransferScreen extends StatelessWidget {
  const TransferScreen({
    super.key,
    required this.id,
    required this.balance,
    required this.name,
    required this.photo,
  });
  final String name, id, photo;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScannerToTransfer(
        name: name,
        id: id,
        photo: photo,
        balance: balance,
      ),
    );
  }
}
