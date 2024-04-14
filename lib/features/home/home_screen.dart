import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/features/home/weekly_chart.dart';
import 'package:finsec/features/home/widgets/top_info_section.dart';
import 'package:finsec/logic/stores/state_store.dart';
//import 'package:finsec/logic/repos/transaction_repo.dart' as TransactionRepo;
import 'package:finsec/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<TransactionRepo.Transaction> transctions = [];
  String _userName = "Prerak";
  final List<Map<String, dynamic>> stocks = [
    {'name': 'AAPL', 'gain': 150.0},
    {'name': 'GOOGL', 'gain': -50.0},
    {'name': 'TSLA', 'gain': 300.0},
  ];

  final List<Map<String, dynamic>> familyMembers = [
    {
      'name': 'Arnav Deo',
      'transactions': [
        {'description': 'Bought Juice', 'amount': -150.0},
        {'description': 'Sold GOOGL', 'amount': 50.0},
        // add more transactions as needed
      ],
    },
    {
      'name': 'Prinkal Doshi',
      'transactions': [
        {'description': 'Bought Starbucks', 'amount': -300.0},
        {'description': 'Auto Fare', 'amount': -200.0},
        // add more transactions as needed
      ],
    },
    // add more family members as needed
  ];

  // init
  @override
  void initState() {
    // upon notification while app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Token: $message");
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      print("Token: $message");
    });
    getName();
    loadTransactions();

    super.initState();
  }

  Future<void> getName() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final String name = userDoc.get('name');
    logger.d(name);
    setState(() {
      _userName = name;
    });
  }

  double balance = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: GestureDetector(
        //     onTap: () => AutoRouter.of(context).push(TestingRoute()),
        //     child: const Text('Testing'),
        //   ),
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome,",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(_userName),
                      ],
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        //AutoRouter.of(context).push(NotificationRoute()),
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) AutoRouter.of(context).replaceAll([const SplashRoute()]);
                        //StateStore().getInvestments();
                      },
                      child: const Icon(
                        Icons.logout,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: 150,
                  width: 370,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      List<String> imageUrls = [
                        'https://i.pinimg.com/originals/13/7a/76/137a764bdefb43d428576829595fc69d.png',
                        'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/generic-car-insurance-advertising-dark-and-li-design-template-01f0bbd05a744f8069f2f1debb907aad_screen.jpg?ts=1621196529',
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRns73ybPUEC7bN75tcbvB9GwGBVkFvig8_vw&usqp=CAU'
                      ];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    itemCount: 3,
                    autoplayDelay: 5,
                  ),
                ),
              ),
              Stack(
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(left: Random().nextInt(300).toDouble(), top: Random().nextInt(80).toDouble()),
                  //   color: Colors.red,
                  //   width: Random().nextInt(100).toDouble(),
                  //   height: Random().nextInt(100).toDouble(),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(left: Random().nextInt(300).toDouble(), top: Random().nextInt(80).toDouble()),
                  //   color: Colors.yellow,
                  //   width: Random().nextInt(100).toDouble(),
                  //   height: Random().nextInt(100).toDouble(),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(left: Random().nextInt(300).toDouble(), top: Random().nextInt(80).toDouble()),
                  //   color: Colors.purple,
                  //   width: Random().nextInt(100).toDouble(),
                  //   height: Random().nextInt(100).toDouble(),
                  // ),
                  TopInfoSection(),
                ],
              ),
              const SizedBox(height: 16),
              // Container(
              //   width: 370,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     gradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         Palette.primary.withOpacity(0.4),
              //         Palette.primary,
              //       ],
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text("Balance"),
              //                 Text(
              //                   "₹${balance.toStringAsFixed(2)}",
              //                   style: const TextStyle(
              //                     color: Palette.white,
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 )
              //               ],
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text("Buffer balance"),
              //                 Text(
              //                   // subtract 45% of balance
              //                   "₹${(balance * 0.45).toStringAsFixed(2)}",
              //                   style: const TextStyle(
              //                     color: Colors.greenAccent,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 10),
              //         Container(
              //           height: 50,
              //           decoration: BoxDecoration(
              //             color: Palette.scaffold.withOpacity(0.4),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               const SizedBox(width: 10),
              //               const BalanceCard(title: "Credit", value: 1783),
              //               Container(width: 1, height: 30, color: Palette.grey),
              //               const BalanceCard(
              //                 title: "Debit",
              //                 value: 2365,
              //               ),
              //               Container(width: 1, height: 30, color: Palette.grey),
              //               const BalanceCard(title: "Transactions", value: 12),
              //               const SizedBox(width: 10),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       WeeklyUsageSnippet(),
              //       SizedBox(width: 20),
              //       Expanded(
              //         child: GlassContainer(
              //           height: 200,
              //           child: Padding(
              //             padding: const EdgeInsets.all(10),
              //             child: Column(
              //               children: [
              //                 GlassContainerSecondary(
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         decoration: BoxDecoration(
              //                           color: Colors.white.withOpacity(0.9),
              //                           borderRadius: BorderRadius.circular(8),
              //                         ),
              //                         // child: Padding(
              //                         //   padding: EdgeInsets.all(2),
              //                         //   child: Image.asset(
              //                         //     "assets/images/superman.png",
              //                         //     width: 36,
              //                         //   ),
              //                         // ),
              //                       ),
              //                       const SizedBox(width: 8),
              //                       const Expanded(
              //                         child: Text(
              //                           "Application Stats",
              //                           style: TextStyle(
              //                             fontSize: 14,
              //                             color: Palette.white,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 const SizedBox(height: 8),
              //                 AplicationData(title: "Total Applied", value: "100"),
              //                 AplicationData(title: "Accepted", value: "20"),
              //                 AplicationData(title: "Under Review", value: "30"),
              //                 AplicationData(title: "Unreviewed", value: "10"),
              //                 AplicationData(title: "Rejected", value: "40"),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 230,
                      decoration: BoxDecoration(
                        color: const Color(0xff15D7D7).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff15D7D7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.home_outlined),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: Text(
                                    "This week you spend",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const StylishRupees(
                              amount: 30500,
                              size1: 16,
                              size2: 22,
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: WeeklyChart(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      width: 170,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Palette.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.home),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: Text(
                                    "Recent transactions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return RecentTransactionItem(
                                    index: index,
                                    length: 2,
                                    title: "Individual Payment",
                                    amount: "₹200",
                                    icon: Icons.person,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              // stockdata
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   height: 240,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Palette.white.withOpacity(0.6), width: 0.4),
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10.0),
              //     child: CandleSticks(code: "LICI", name: "LIC India"),
              //   ),
              // ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 126,
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Income -",
                                style: TextStyle(
                                  color: Palette.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$1,783.24",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 63,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 60,
                                height: 113,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Palette.primary.withOpacity(0.75),
                                      Palette.primary.withOpacity(0.35),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Savings -",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Palette.white.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        "\$254,352",
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Palette.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 360,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/home_gain_bg.png"), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Overall gain:",
                                  style: TextStyle(
                                    color: Palette.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "₹1250.71",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Palette.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Portfolio market value - ₹${500.71}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Palette.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                    Text(
                                      "₹1783",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                    Text(
                                      "500",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                    Text(
                                      "234",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "My Assets",
                          style: TextStyle(
                            fontSize: 17,
                            color: Palette.white,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: stocks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                stocks[index]['name'],
                                style: TextStyle(color: Palette.white, fontSize: 14),
                              ),
                              trailing: Text(
                                '₹${stocks[index]['gain'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: stocks[index]['gain'] >= 0 ? Colors.green : Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: familyMembers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          familyMembers[index]['name'],
                          style: TextStyle(color: Palette.white, fontSize: 14),
                        ),
                        children: familyMembers[index]['transactions'].map<Widget>((transaction) {
                          print(transaction);
                          return ListTile(
                            title: Text(
                              transaction['description'],
                              style: TextStyle(color: Palette.white, fontSize: 14),
                            ),
                            trailing: Text(
                              transaction['amount'].toString(),
                              style: TextStyle(
                                color: transaction['amount'] >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 160),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadTransactions() async {
    // transactions =
    //     await TransactionRepo.TransactionRepo().loadAllTransactions();

    // // sort by newest
    // transactions.sort((a, b) => b.time.compareTo(a.time));

    // load balance from firestore
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        // get bank_accounts
        // balance = value.data()!["bank_accounts"][0]["balance"];
        // balance = balance + value.data()!["bank_accounts"][1]["balance"];
        balance = 500;

        print("Balance: $balance");
      });
    });
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Palette.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        Text(
          title == "Transactions" ? "${value.round()}" : "\$$value",
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ActiveLoan extends StatelessWidget {
  const ActiveLoan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Palette.grey.withOpacity(0.10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shopping",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "\$ 2000",
                      style: TextStyle(
                        color: Palette.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircleViews(
                  size: 35,
                  hasTitle: false,
                  title: "Shopping",
                  iconPath: "assets/svgs/moneysend.svg",
                  onTap: () {},
                ),
              ],
            ),
            const Text(
              "View >",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Palette.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StylishRupees extends StatelessWidget {
  const StylishRupees({
    super.key,
    required this.amount,
    required this.size1,
    required this.size2,
  });

  final double amount;
  final double size1, size2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          // "\$",
          "₹",
          style: TextStyle(
            fontSize: size1,
            color: Palette.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          amount.toString(),
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: size2,
            letterSpacing: 1.2,
            color: Palette.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class RecentTransactionItem extends StatelessWidget {
  final int index, length;
  final String title;
  final String amount;
  final IconData icon;

  const RecentTransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              icon,
              color: Palette.white,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              amount.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CircleViews extends StatelessWidget {
  const CircleViews({
    super.key,
    required this.size,
    required this.hasTitle,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  final double size;
  final bool hasTitle;
  final String iconPath, title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.white,
              ),
              child: Center(
                child: SvgPicture.asset(iconPath),
              ),
            ),
          ),
          if (hasTitle) const SizedBox(height: 5),
          if (hasTitle)
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class AplicationData extends StatelessWidget {
  const AplicationData({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
