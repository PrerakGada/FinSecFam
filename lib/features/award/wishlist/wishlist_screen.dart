import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<String> completedGoals = [
    "iPhone",
    "Macbook Pro M3",
    "Diamong wedding ring"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset("assets/svgs/checkmark.svg"),
                  ],
                ),
                Text("See more"),
              ],
            ),
          ),
          SizedBox(height: 20),
          CompletedBox(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "In wishlist",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          WishlightGrid(
            completedGoals: completedGoals,
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90, right: 10),
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
    );
  }
}

class WishlightGrid extends StatelessWidget {
  const WishlightGrid({
    super.key,
    required this.completedGoals,
  });

  final List<String> completedGoals;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5,
          ),
          itemCount: completedGoals.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 200,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff8671FD),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            completedGoals[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xff8671FD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "I bought it",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  child: SvgPicture.asset("assets/svgs/fire.svg"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CompletedBox extends StatelessWidget {
  const CompletedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> completedGoals = [
      "Buy an iphone at the end of the month",
      "Buy a new car at the end of the year",
      "Buy a new house at the end of the year",
    ];
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            margin: EdgeInsets.only(left: 20, right: index == 2 ? 20 : 0),
            decoration: BoxDecoration(
              color: Color(0xff256A3A),
              border: Border.all(
                color: Color(0xff70FF66),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  completedGoals[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
