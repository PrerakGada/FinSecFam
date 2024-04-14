import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<String> completedGoals = [
    "Buy a macbook at the end of the month",
    "Buy a car at the end of the year",
    "Save 1 million at the end of the year",
    "Buy a new house at the end of the year",
    "Buy a new building at the end of the decade",
  ];

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          backgroundColor: Palette.primary,
          shape: CircleBorder(),
          onPressed: () {
            TextEditingController goalController = TextEditingController();
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: goalController,
                            decoration: InputDecoration(
                              hintText: 'Enter your goal',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Add to Wishlist'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              completedGoals.add(goalController.text);
                              colors.add(Colors.green);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: ListView.builder(
          itemCount: completedGoals.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GoalCard(
                text: completedGoals[index],
                color: colors[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset("assets/svgs/pin.svg"),
          ),
        ],
      ),
    );
  }
}
