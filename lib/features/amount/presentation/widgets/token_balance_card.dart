import 'package:flutter/material.dart';

class TokenBalanceCard extends StatelessWidget {
  final String tokenName;
  final String symbol;
  final String network;
  final double balance;

  const TokenBalanceCard({
    super.key,
    required this.tokenName,
    required this.symbol,
    required this.network,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Text(
                symbol.substring(0, 1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    tokenName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '$symbol • $network',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text(
                  'Available',
                  style: theme.textTheme.bodySmall,
                ),

                const SizedBox(height: 4),

                Text(
                  balance.toStringAsFixed(4),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}