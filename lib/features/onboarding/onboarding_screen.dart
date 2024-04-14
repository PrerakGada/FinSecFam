import 'package:auto_route/auto_route.dart';
import 'package:finsec/features/onboarding/onboarding_info.dart';
import 'package:finsec/utils/utils.dart';
import 'package:finsec/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/app_router.gr.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                "assets/svgs/logo.svg",
                width: 80,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to FinSec",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please follow these house rules.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 60),
            RuleCard(
              title: "Be yourself.",
              desc:
                  "Make sure your photos, age, and bio are true to who you are.",
            ),
            SizedBox(height: 20),
            RuleCard(
              title: "Stay safe.",
              desc:
                  "Don't be too quick to give out personal information. Date Safely",
            ),
            SizedBox(height: 20),
            RuleCard(
              title: "Play it cool.",
              desc:
                  "Respect others and treat them as you would like to be treated.",
            ),
            SizedBox(height: 20),
            RuleCard(
              title: "Be proactive.",
              desc: "Always report bad behavior.",
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PrimaryButton(
                text: "I agree",
                onTap: () {
                  AutoRouter.of(context).push(OnboardingInfoRoute());
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class RuleCard extends StatelessWidget {
  const RuleCard({
    super.key,
    required this.title,
    required this.desc,
  });
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svgs/check.svg",
                width: 24,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            desc,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
