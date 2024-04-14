import 'package:auto_route/auto_route.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MomSheet1 extends StatelessWidget {
  const MomSheet1({
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
                color: Color(0xfffdfdbc),
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
                    SvgPicture.asset("assets/svgs/sad_vector.svg"),
                    SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Amount for you are buying is ",
                        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "exceeding",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          TextSpan(
                            text: " your Savings balance",
                          ),
                        ],
                      ),
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
                                  child: Text("SAVE my money", style: TextStyle(color: Colors.white)),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  AutoRouter.of(context).push(MainScaffoldRoute());
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
                                Text("I still want to buy ", style: TextStyle(color: Colors.black)),
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
