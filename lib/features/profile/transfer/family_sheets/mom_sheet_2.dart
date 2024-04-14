import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class MomSheet2 extends StatelessWidget {
  const MomSheet2({
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
                color: Color(0xffFFBECE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        //Gap(40),
                        SvgPicture.asset("assets/svgs/sad_vector.svg"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SAVE money for essentials",
                              style: Typo.titleLarge.copyWith(color: Colors.black),
                            ),
                            SvgPicture.asset("assets/svgs/pin.svg"),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Why you want to buy this product?",
                          style: Typo.bodyLarge.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
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
                                  child: Text("Need", style: TextStyle(color: Colors.white)),
                                ),
                                onTap: () {
                                  // pageController.nextPage(
                                  //   duration: Duration(milliseconds: 300),
                                  //   curve: Curves.easeInOut,
                                  // );
                                  Navigator.of(context).pop();
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
                                Text("Want", style: TextStyle(color: Colors.black)),
                                Image.asset("assets/images/angry.png"),
                              ],
                            ),
                          ),
                          onTap: () {
                            // pageController.nextPage(
                            //   duration: Duration(milliseconds: 300),
                            //   curve: Curves.easeInOut,
                            // );
                            Navigator.of(context).pop();
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
              Image.asset("assets/images/finsec_mumma.png", height: 100),
              Text(
                "FinSec Mom",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
