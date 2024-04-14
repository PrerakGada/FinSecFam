import 'package:auto_route/auto_route.dart';
import 'package:finsec/features/sni/finsec_dada.dart';
import 'package:finsec/features/sni/finsec_dada_backend.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PapaSheet2 extends StatelessWidget {
  const PapaSheet2({
    super.key,
    required this.pageController,
    required this.money,
  });

  final PageController pageController;
  final String money;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 174, 255, 177),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/512/3310/3310653.png",
                      height: 200,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Stack(
                            children: [
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text("UTILIZE my money", style: TextStyle(color: Colors.white)),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen2(
                                        topic: "Give examples of stocks I should add to my portfolio by diversifying ${money}.",
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset("assets/images/smiley.png"),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Row(
                              children: [
                                Text("I dont want to utilise ", style: TextStyle(color: Colors.black)),
                                Image.asset("assets/images/angry.png"),
                              ],
                            ),
                          ),
                          onTap: () {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Image.asset("assets/images/dad.png", height: 100),
              Text(
                "FinSec Papa",
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
