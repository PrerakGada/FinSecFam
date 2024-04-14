import 'package:auto_route/auto_route.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class PapaSheet extends StatelessWidget {
  const PapaSheet({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

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
                color: Color.fromRGBO(203, 239, 255, 1),
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
                    SizedBox(height: 60),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "I'll suggest to invest",
                        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: " 20% of your balance",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: " in multiple stocks",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Invest distributing in multiple stocks",
                      style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Image.asset(
                                'assets/logos/apple.png',
                                width: 100,
                              ),
                              Text(
                                "5% Growth",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/logos/bestbuy.png',
                                width: 100,
                              ),
                              Text(
                                "10% Growth",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/logos/gap.png',
                                width: 100,
                              ),
                              Text(
                                "2% Growth",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Risk and Ratings",
                      style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black, fontSize: 18),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        SpeedometerChart(
                          dimension: 200,
                          minValue: 0,
                          maxValue: 100,
                          value: 25,
                          minTextValue: 'Min. 0',
                          maxTextValue: 'Max. 100',
                          graphColor: [Colors.green, Colors.yellow, Colors.red],
                          pointerColor: Colors.black,
                          valueVisible: true,
                          rangeVisible: true,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/dad.png", height: 150),
              Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "FinSec Papa",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
