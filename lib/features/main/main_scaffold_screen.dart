import 'package:auto_route/auto_route.dart';
import 'package:finsec/features/home/home_screen.dart';
import 'package:finsec/features/money_manager/money_manager_screen.dart';
import 'package:finsec/features/profile/transfer/transfer.dart';
import 'package:finsec/features/stocks/stock_screen.dart';
import 'package:finsec/utils/utils.dart';
import 'package:finsec/widgets/family_members.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

@RoutePage()
class MainScaffoldScreen extends StatefulWidget {
  const MainScaffoldScreen({super.key});

  @override
  State<MainScaffoldScreen> createState() => _MainScaffoldScreenState();
}

class _MainScaffoldScreenState extends State<MainScaffoldScreen> {
  PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          MoneyManagerScreen(),
          // TransferScreen(id: "1", balance: 1000, name: "John Doe", photo: "assets/images/profile.png"),
          // EnterMoneyScreen(scannedData: ['', 'Texgt herer', '2', 'https://source.unsplash.com/random/100x100']),
          StockScreen(),
          FamilyManagerScreen(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: Palette.black,
        option: AnimatedBarOptions(
          iconSize: 32,
          // barAnimation: BarAnimation.liquid,
          iconStyle: IconStyle.simple,
          opacity: 0.3,
        ),
        // option: BubbleBarOptions(
        //   barStyle: BubbleBarStyle.vertical,
        //   // barStyle: BubbleBarStyle.vertical,
        //   bubbleFillStyle: BubbleFillStyle.fill,
        //   // bubbleFillStyle: BubbleFillStyle.outlined,
        //   opacity: 0.3,
        // ),
        // option: DotBarOptions(
        //   dotStyle: DotStyle.circle,
        //   gradient: const LinearGradient(
        //     colors: [
        //       Colors.deepPurple,
        //       Colors.pink,
        //     ],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.space_dashboard, size: 30),
            title: const Text('Abc'),
            backgroundColor: Palette.light,
            selectedIcon: const Icon(Icons.space_dashboard, size: 30, color: Palette.primary),
          ),
          BottomBarItem(
            icon: const Icon(Icons.add_business, size: 30),
            title: const Text('Safety'),
            backgroundColor: Palette.light,
            selectedIcon: const Icon(Icons.add_business, size: 30, color: Palette.primary),
          ),
          BottomBarItem(
            icon: const Icon(Icons.cabin, size: 30),
            title: const Text('Cabin'),
            backgroundColor: Palette.light,
            selectedIcon: const Icon(Icons.cabin, size: 30, color: Palette.primary),
          ),
          BottomBarItem(
            icon: const Icon(Icons.trending_up, size: 30),
            title: const Text('Cabin'),
            backgroundColor: Palette.light,
            selectedIcon: const Icon(Icons.trending_up, size: 30, color: Palette.primary),
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        notchStyle: NotchStyle.square,
      ),
      // QR Icon Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TransferScreen(id: '3244341', balance: 500, name: "Prerak", photo: "assets/images/profile.png")));
        },
        child: const Icon(Icons.qr_code),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
