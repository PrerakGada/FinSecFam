import 'package:finsec/features/award/goals/goals_screen.dart';
import 'package:finsec/features/award/leaderboard/leaderboard_screen.dart';
import 'package:finsec/features/award/wishlist/wishlist_screen.dart';
import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AwardScreen extends StatefulWidget {
  const AwardScreen({super.key});

  @override
  State<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends State<AwardScreen> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leaderboard
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                    pageController.jumpToPage(selectedIndex);
                  });
                },
                child: Column(
                  children: [
                    Text('Leaderboard', style: Typo.titleMedium),
                    const Gap(4),
                    Container(
                      height: 2,
                      width: 100,
                      color: selectedIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),

              // Goals
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                    pageController.jumpToPage(selectedIndex);
                  });
                },
                child: Column(
                  children: [
                    Text('Goals', style: Typo.titleMedium),
                    const Gap(4),
                    Container(
                      height: 2,
                      width: 50,
                      color: selectedIndex == 1
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),

              // Wishlist
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                    pageController.jumpToPage(selectedIndex);
                  });
                },
                child: Column(
                  children: [
                    Text('Wishlist', style: Typo.titleMedium),
                    const Gap(4),
                    Container(
                      height: 2,
                      width: 70,
                      color: selectedIndex == 2
                          ? Colors.white
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          LeaderboardScreen(),
          GoalsScreen(),
          WishlistScreen(),
        ],
      ),
    );
  }
}
