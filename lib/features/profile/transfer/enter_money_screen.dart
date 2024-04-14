import 'dart:convert';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finsec/features/profile/transfer/family_sheets/papa_sheet_1.dart';
import 'package:finsec/utils/const.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
//import 'package:finsec/logic/repos/transaction_repo.dart' as transaction_repo;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'family_sheets/mom_sheet_1.dart';
import 'family_sheets/mom_sheet_2.dart';

@RoutePage()
class EnterMoneyScreen extends StatelessWidget {
  EnterMoneyScreen({super.key, required this.scannedData});

  final List<String> scannedData;
  final double amountToTransfer = 0.0;
  String? uid = '';
  TextEditingController amountController = TextEditingController();

  void onTap() {
    print("Payment: $amountToTransfer");
    // transaction_repo.TransactionRepo().createTransaction(transaction_repo.Transaction(
    //   id: Random().nextInt(100000).toString() + Random().nextInt(100000).toString(),
    //   type: transaction_repo.TransactionType.onetime,
    //   amount: amountToTransfer,
    //   time: DateTime.now(),
    //   uid: uid,
    //   savingFine: amountToTransfer.toInt() - amountToTransfer,
    // ));
  }

  // data: "${widget.balance},${widget.name},${widget.id},${widget.photo}",

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Money'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: 'https://source.unsplash.com/random/100x100',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(scannedData[1]),
            ),
            const Text('Enter the amount you want to pay'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (int.parse(amountController.text) > 5000)
                  showModalBottomSheet(
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    context: context,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: TransactionBottomSheet(),
                    ),
                  );
                else
                  showDialog(
                    context: context,
                    builder: (context) {
                      print(scannedData);
                      return Dialog(
                        child: Lottie.asset('assets/logos/celebration.json', onLoaded: (composition) async {
                          var response = await http.get(
                            Uri.parse('$backendUrl/auth/users'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          var users = jsonDecode(response.body);
                          var user = users.firstWhere((user) => user['name'] == scannedData[2], orElse: () => "FSEOM9fFBiO52PdOpnWtM81ZGm42");

                          response = await http.post(
                            Uri.parse('$backendUrl/notifications'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, dynamic>{
                              'userIds': [user['id']],
                              'notifTitle': 'You\'ve received money!',
                              'data': {
                                'test': '123a',
                              },
                              'notifBody': 'You received ${amountController.text} from ${scannedData[2]}',
                            }),
                          );
                          logger.d(response.body);
                          Future.delayed(composition.duration, () {
                            Navigator.of(context).pop();
                            AutoRouter.of(context).push(MainScaffoldRoute());
                          });
                        }),
                      );
                    },
                  );
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionBottomSheet extends StatefulWidget {
  const TransactionBottomSheet({
    super.key,
  });

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        //PapaSheet(),
        MomSheet1(pageController: pageController),
        MomSheet2(pageController: pageController),
      ],
    );
  }
}
