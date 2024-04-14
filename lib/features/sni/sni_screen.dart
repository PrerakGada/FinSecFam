import 'package:carousel_slider/carousel_slider.dart';
import 'package:finsec/features/sni/candle_sticks.dart';
import 'package:finsec/features/sni/circular_chart.dart';
import 'package:finsec/utils/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'circular_chart.dart';

class SNI extends StatelessWidget {
  SNI({super.key});
  List<CircularStocks> budgetChart = [
    CircularStocks(stockName: "LICI", investedPartition: 0.5),
    CircularStocks(stockName: "AAPL", investedPartition: 0.25),
    CircularStocks(stockName: "GOOG", investedPartition: 0.25),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // create a square padded widget showing portfolio information and current updown
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Portfolio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CircularChart(investedStocks: budgetChart),
              SizedBox(height: 20),
              // 1. Portfolio value
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Palette.primary.withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Portfolio Value",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "₹ 2340",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    // 2. Portfolio updown
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Palette.primary.withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Portfolio Up/ Down",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          // show a green arrow with up %
                          Text(
                            // red
                            "10% 🔻",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // 3. Portfolio percentage
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Palette.primary.withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Portfolio Percentage",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "10%",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              // show stocks
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Stock trends",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "(LICI)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // create a carousel of stocks
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 240,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Palette.white.withOpacity(0.6), width: 0.4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CandleSticks(code: "LICI", name: "LIC India"),
                ),
              ),

              SizedBox(height: 120),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     height: 200,
              //     aspectRatio: 16 / 9,
              //     viewportFraction: 0.6,
              //     initialPage: 0,
              //     enableInfiniteScroll: true,
              //     reverse: false,
              //     autoPlay: true,
              //     autoPlayInterval: const Duration(seconds: 5),
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     scrollDirection: Axis.horizontal,
              //   ),
              //   items: [
              //     // create empty container
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.9,
              //       height: 300,
              //       child: Row(
              //         children: [
              //           SizedBox(width: 20),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
