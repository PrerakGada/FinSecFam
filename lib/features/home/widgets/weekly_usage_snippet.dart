import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../weekly_chart.dart';

class WeeklyUsageSnippet extends StatelessWidget {
  const WeeklyUsageSnippet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassContainer(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GlassContainerSecondary(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // child: Padding(
                      //   padding: EdgeInsets.all(2),
                      //   child: Image.asset(
                      //     "assets/images/heart.png",
                      //     width: 36,
                      //   ),
                      // ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Last 7 Day Growth",
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: WeeklyChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
