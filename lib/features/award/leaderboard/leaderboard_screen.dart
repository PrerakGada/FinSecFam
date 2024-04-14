import 'package:finsec/logic/repo/friend_repo.dart';
import 'package:finsec/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              Image.asset("assets/images/top_leaderboard.png"),
              const Gap(16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Palette.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    ...List.generate(
                        10, (index) => LeaderBoardRow(index: index)),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 90, right: 10),
          child: FloatingActionButton(
            backgroundColor: Palette.primary,
            shape: CircleBorder(),
            child: Icon(
              Icons.add,
              color: Palette.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: AddFriendBottomSheet(),
                ),
              );
            },
          ),
        ));
  }
}

class LeaderBoardRow extends StatelessWidget {
  const LeaderBoardRow({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Text("${index + 1}"),
          const Gap(8),
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/leaderboard.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset("assets/svgs/badge.svg"),
                ),
              ],
            ),
          ),
          const Gap(16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Doe", style: TextStyle(color: Palette.white)),
              Text("1000 points", style: TextStyle(color: Palette.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class AddFriendBottomSheet extends StatefulWidget {
  const AddFriendBottomSheet({super.key});

  @override
  State<AddFriendBottomSheet> createState() => _AddFriendBottomSheetState();
}

class _AddFriendBottomSheetState extends State<AddFriendBottomSheet> {
  List<Friend> friends = [];

  Map<int, bool> selectedFriends = {};

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() async {
    friends = await FriendRepo().getPossibleFriends();
    for (var i = 0; i < friends.length; i++) {
      selectedFriends[i] = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const Gap(16),
        const Text(
          "Add Friends",
          style: TextStyle(
            color: Palette.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search for friends",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xff383839),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      "assets/images/leaderboard.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(friends[index].name),
                trailing: GestureDetector(
                  onTap: () {
                    //FriendRepo().sendFriendRequest(friends[index]);
                    selectedFriends[index] = true;
                  },
                  child: Icon(
                    selectedFriends[index] == true ? Icons.check : Icons.add,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
