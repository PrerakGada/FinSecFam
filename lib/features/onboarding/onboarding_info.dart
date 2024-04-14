import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/utils/routes/app_router.gr.dart';
import 'package:finsec/utils/utils.dart';
import 'package:finsec/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingInfoScreen extends StatefulWidget {
  const OnboardingInfoScreen({super.key});

  @override
  State<OnboardingInfoScreen> createState() => _OnboardingInfoScreenState();
}

class _OnboardingInfoScreenState extends State<OnboardingInfoScreen> {
  RangeValues incomeRange =
      RangeValues(0, 500000); // Initial range from 0 to 5 lakh

  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController literateController = TextEditingController();

  int currentImpulsiveIndex = 4;

  void onImpulsiveExpenseClicked(int index) {
    // 1 means good, 5 means bad
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/onboarding_top_design.png"),
                  Positioned(
                    top: 25,
                    left: 25,
                    child: GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Palette.scaffold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Let this be personalized as we are your FinSec family",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Change border radius here
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Change border radius here
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: occupationController,
                  decoration: InputDecoration(
                    labelText: "Occupation",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Change border radius here
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How financially literate are you?",
                        style: TextStyle(
                          color: Palette.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // InkWell, with a container
                          InkWell(
                            onTap: () {
                              setState(() {
                                literateController.text = "Beginner";
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: literateController.text == "Beginner"
                                    ? Palette.primary
                                    : Palette.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Beginner",
                                  style: TextStyle(
                                    color: literateController.text == "Beginner"
                                        ? Palette.white
                                        : Palette.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                literateController.text = "Intermediate";
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: literateController.text == "Intermediate"
                                    ? Palette.primary
                                    : Palette.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Intermediate",
                                  style: TextStyle(
                                    color: literateController.text ==
                                            "Intermediate"
                                        ? Palette.white
                                        : Palette.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // InkWell, with a container
                          InkWell(
                            onTap: () {
                              setState(() {
                                literateController.text = "Advanced";
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: literateController.text == "Advanced"
                                    ? Palette.primary
                                    : Palette.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Advanced",
                                  style: TextStyle(
                                    color: literateController.text == "Advanced"
                                        ? Palette.white
                                        : Palette.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                literateController.text = "Help me find out.";
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              height: 50,
                              decoration: BoxDecoration(
                                color: literateController.text ==
                                        "Help me find out."
                                    ? Palette.primary
                                    : Palette.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Help me find out.",
                                  style: TextStyle(
                                    color: literateController.text ==
                                            "Help me find out."
                                        ? Palette.white
                                        : Palette.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
              // How financially literate are you?
              // provide 4 buttons to select literacy: beginner, advanced, intermediate, help me find out
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Text(
                      "Income range",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "(${incomeRange.start.round()} to ${incomeRange.end.round()})",
                      style: TextStyle(
                        color: Palette.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RangeSlider(
                  values: incomeRange,
                  min: 0,
                  max: 2000000, // 50 lakh
                  divisions: 80, // (2000000 / 25000)
                  activeColor: Palette.white,
                  inactiveColor: Palette.grey.withOpacity(0.4),
                  labels: RangeLabels(
                    '${incomeRange.start.round()}',
                    '${incomeRange.end.round()}',
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      incomeRange = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Text(
                      "Impulsive expenses",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      5,
                      (index) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              onImpulsiveExpenseClicked(index + 1);
                              setState(() {
                                currentImpulsiveIndex = index;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Palette.grey.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: currentImpulsiveIndex == index
                                        ? Palette.primary
                                        : Palette.grey.withOpacity(0.2),
                                  )),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/face_${index + 1}.png",
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: currentImpulsiveIndex == index
                                  ? Palette.primary
                                  : Palette.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ).reversed
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PrimaryButton(
                    text: "Proceed",
                    onTap: () {
                      // write the data to firestore
                      AutoRouter.of(context).replaceAll([MainScaffoldRoute()]);
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'age': ageController.text,
                        'location': locationController.text,
                        'occupation': occupationController.text,
                        'literate': literateController.text,
                        'income_range':
                            (incomeRange.start + incomeRange.end) / 2,
                        'impulsive_expense': currentImpulsiveIndex + 1,
                      });
                    }),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
