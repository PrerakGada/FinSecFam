import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finsec/features/profile/transfer/components/primary_btn.dart';
import 'package:flutter/material.dart';

class Receiver extends StatelessWidget {
  const Receiver({
    super.key,
    required this.scannedData,
    required this.onTap,
  });

  final List<String> scannedData;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Transfer to:",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.4),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                )
              ],
              borderRadius: BorderRadius.circular(35),
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                width: 70,
                height: 70,
                imageUrl: scannedData[3],
                placeholder: (context, url) => Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      shape: BoxShape.circle),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 8,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            scannedData[1],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          PrimaryBtn(
            primaryColor: Theme.of(context).primaryColor,
            secondaryColor: Theme.of(context).primaryColor.withOpacity(0.4),
            padding: 20,
            title: "Continue",
            onTap: onTap,
            titleColor: const Color(0xffFCF7F8),
          ),
        ],
      ),
    );
  }
}
