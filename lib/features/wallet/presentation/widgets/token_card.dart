import 'package:flutter/material.dart';

import '../../../../shared/models/token_balance.dart';

class TokenCard extends StatelessWidget {
  final TokenBalance token;
  final VoidCallback onSend;

  const TokenCard({
    super.key,
    required this.token,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final fiatValue = token.balance * token.usdPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(token.symbol[0]),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      token.symbol,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${token.name} • ${token.network}',
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text('Balance'),
                Text(token.balance.toString()),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text('Value'),
                Text(
                  '\$${fiatValue.toStringAsFixed(2)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onSend,
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}