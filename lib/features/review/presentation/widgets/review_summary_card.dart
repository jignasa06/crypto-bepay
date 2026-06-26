import 'package:flutter/material.dart';

class ReviewSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;

  const ReviewSummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isBold ? 18 : 15,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
    );

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: style),
            Flexible(
              child: Text(
                value,
                style: style,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}