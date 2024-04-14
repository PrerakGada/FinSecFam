import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/glass_container.dart';

class TopInfoSection extends StatelessWidget {
  const TopInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GlassContainer(
        width: double.infinity,
        borderRadius: 10,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Balance"),
                      Text(
                        "₹86,000",
                        style: TextStyle(
                          color: Palette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Buffer Balance"),
                      Text(
                        "₹50,000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              GlassContainerSecondary(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credit",
                          style: TextStyle(
                            color: Palette.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "₹43,000",
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 30, color: Palette.grey),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Debit",
                          style: TextStyle(
                            color: Palette.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "₹24,00",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 30, color: Palette.grey),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TXNs",
                          style: TextStyle(
                            color: Palette.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "347",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
