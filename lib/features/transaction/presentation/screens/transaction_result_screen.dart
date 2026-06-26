import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/enums/transaction_status.dart';
import '../../../../shared/models/transaction_result.dart';

class TransactionResultScreen extends StatelessWidget {
  final TransactionResult result;

  const TransactionResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final bool success =
        result.status == TransactionStatus.success;

    final bool pending =
        result.status == TransactionStatus.pending;

    IconData icon;
    Color color;
    String title;
    String subtitle;

    if (success) {
      icon = Icons.check_circle_rounded;
      color = Colors.green;

      title = "Transfer Successful";

      subtitle =
      "Your transaction has been completed successfully.";
    } else if (pending) {
      icon = Icons.access_time_filled_rounded;
      color = Colors.orange;

      title = "Transfer Pending";

      subtitle =
      "Your transaction is being processed. It may take a few moments.";
    } else {
      icon = Icons.cancel_rounded;
      color = Colors.red;

      title = "Transfer Failed";

      subtitle =
      "Something went wrong while processing your transaction.";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Transaction Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const Spacer(),

            Icon(
              icon,
              size: 90,
              color: color,
            ),

            const SizedBox(height: 24),

            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 0,
              child: ListTile(
                title: const Text("Transaction ID"),
                subtitle: Text(result.transactionId),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton(
                onPressed: () {
                  context.go(AppRoutes.wallet);
                },
                child: const Text(
                  "Back to Wallet",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}