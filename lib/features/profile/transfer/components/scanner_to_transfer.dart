import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/features/profile/transfer/components/custom_text_field.dart';
import 'package:finsec/features/profile/transfer/components/primary_btn.dart';
//import 'package:finsec/logic/repos/transaction_repo.dart' as transaction_repo;
import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//import '../../../../logic/repos/transaction_repo.dart';
import 'camera_borders.dart';
import 'qr.dart';
import 'receiver.dart';

class ScannerToTransfer extends StatefulWidget {
  const ScannerToTransfer({
    super.key,
    required this.id,
    required this.balance,
    required this.name,
    required this.photo,
  });
  final String name, id, photo;
  final double balance;

  @override
  State<ScannerToTransfer> createState() => _ScannerToTransferState();
}

class _ScannerToTransferState extends State<ScannerToTransfer>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey qrKey = GlobalKey(debugLabel: "qr");
  late QRViewController controller;
  bool controllerIsReady = false;
  List<String> scannedData = [];
  int? senderAccountId, receiverAccountId;

  String mode = "scan";
  double amountToTransfer = 0.0;

  String? uid;

  // Transaction Stuff
  // List<transaction_repo.Transaction> recents = [];

  final tabs = [
    const Tab(text: "Scan QR"),
    Tab(
      child: SizedBox(
        width: 100,
        child: Text("QR Code"),
      ),
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getTransactions();
    super.initState();
  }

  @override
  void dispose() {
    if (controllerIsReady) controller.dispose();
    super.dispose();
  }

  void onChanged(double money) {
    amountToTransfer = money;
  }

  void getTransactions() async {
    // recents = await TransactionRepo().loadAllTransactions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "QR Quick Transfer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              qrTabs(context),
              SizedBox(height: 40),
              if (mode == "scan") qrScanner(context),
              if (mode == "qr") QR(widget: widget),
              Container(
                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.6),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for a friend",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Recent Transactions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // transfer(context);
                            // transaction_repo.TransactionRepo().createTransaction(transaction_repo.Transaction(
                            //   id: Random().nextInt(100000).toString() + Random().nextInt(100000).toString(),
                            //   type: transaction_repo.TransactionType.onetime,
                            //   amount: amountToTransfer,
                            //   time: DateTime.now(),
                            //   uid: uid,
                            //   savingFine: amountToTransfer.toInt() - amountToTransfer,
                            // ));
                            AutoRouter.of(context).push(
                                EnterMoneyRoute(scannedData: scannedData));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Transaction Grid
                    // SizedBox(
                    //   // height: MediaQuery.of(context).size.height,
                    //   child: GridView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 5,
                    //       crossAxisSpacing: 10,
                    //       mainAxisSpacing: 10,
                    //     ),
                    //     itemCount: recents.length,
                    //     itemBuilder: (context, index) {
                    //       final transaction = recents[index];
                    //       if (transaction.merchant == null) return null;
                    //       return GestureDetector(
                    //         onTap: () {},
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(8),
                    //           child: Image.asset(transaction.merchant!.img!),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container qrTabs(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TabBar(
        onTap: (value) {
          setState(() {
            mode = value == 0 ? "scan" : "qr";
            if (mode == "qr") scannedData = [];
          });
          // futureIndices = fetchIndices(mode);
          // callStock();
        },
        controller: tabController,
        // indicator: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8.0),
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Theme.of(context).primaryColor,
        //       Theme.of(context).primaryColor.withOpacity(0.4),
        //     ],
        //   ),
        // ),
        labelColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: Colors.black,
        tabs: tabs,
      ),
    );
  }

  Expanded qrScanner(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CameraBorders(
                  top: 0,
                  left: 0,
                  right: null,
                  bottom: null,
                ),
                const CameraBorders(
                  top: 0,
                  left: null,
                  right: 0,
                  bottom: null,
                ),
                const CameraBorders(
                  top: null,
                  left: 0,
                  right: null,
                  bottom: 0,
                ),
                const CameraBorders(
                  top: null,
                  left: null,
                  right: 0,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: launchCamera(),
                    ),
                  ),
                ),
              ],
            ),
            if (scannedData.isEmpty)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Scanning for QR Code...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)
                ],
              ),
            if (scannedData.isNotEmpty && scannedData[2] == widget.id)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Self transfer is meaningless,\nPlease scan different QR Code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)
                ],
              ),
            if (scannedData.isNotEmpty && scannedData[2] != widget.id)
              Receiver(
                scannedData: scannedData,
                onTap: () => AutoRouter.of(context)
                    .push(EnterMoneyRoute(scannedData: scannedData)),
              ),
          ],
        ),
      ),
    );
  }

  QRView launchCamera() {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        this.controller = controller;
        controllerIsReady = true;
        // if (await Permission.camera.isDenied) {
        //   openAppSettings();
        // } else {
        controller.resumeCamera();
        controller.scannedDataStream.listen((scanData) {
          scanQRCode(scanData);
        });
        // }
      },
    );
  }

  void scanQRCode(Barcode scanData) {
    print("Scanned Data:");
    print(scanData.code!);
    setState(() {
      scannedData.add(scanData.code!.split(",").elementAt(0));
      scannedData.add(scanData.code!.split(",").elementAt(1));
      scannedData.add(scanData.code!.split(",").elementAt(2));
      scannedData.add(scanData.code!.split(",").elementAt(3));

      FirebaseFirestore.instance
          .collection("users")
          .doc(scannedData[2])
          .get()
          .then((value) {
        setState(() {
          scannedData = [];
          scannedData.add("300.0");
          scannedData.add(value.get("name"));
          scannedData.add(value.get("uid"));
          scannedData.add(value.get("photo_url"));

          uid = value.get("uid");
        });
      });

      if (scannedData[2] != widget.id) {
        controller.pauseCamera();
        AutoRouter.of(context).push(EnterMoneyRoute(scannedData: scannedData));
      }
    });
  }

  Future<dynamic> transfer(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Transfer money",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(onChanged: onChanged),
            SizedBox(height: 10),
            PrimaryBtn(
              primaryColor: Theme.of(context).primaryColor,
              secondaryColor: Theme.of(context).primaryColor.withOpacity(0.4),
              padding: 0,
              title: "Done",
              onTap: () {
                // todo
                print("Payment: $amountToTransfer");
                // transaction_repo.TransactionRepo().createTransaction(transaction_repo.Transaction(
                //   id: Random().nextInt(100000).toString() + Random().nextInt(100000).toString(),
                //   type: transaction_repo.TransactionType.onetime,
                //   amount: amountToTransfer,
                //   time: DateTime.now(),
                //   uid: uid,
                //   savingFine: amountToTransfer.toInt() - amountToTransfer,
                // ));
                Navigator.pop(context);
              },
              titleColor: const Color(0xffFCF7F8),
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
