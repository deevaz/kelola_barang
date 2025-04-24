import 'package:flutter/material.dart';

class HistoryModalBottom extends StatelessWidget {
  final Map<String, dynamic> item;
  const HistoryModalBottom({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 358,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Center(
            child: Container(
              width: 104,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Detail Riwayat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          // Add your detail view here
        ],
      ),
    );
  }
}
