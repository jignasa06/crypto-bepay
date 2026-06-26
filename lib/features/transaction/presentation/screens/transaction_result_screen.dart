import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../providers/send_flow_notifier.dart';
import '../../../../shared/enums/transaction_status.dart';
import '../../../../shared/models/transaction_result.dart';

class TransactionResultScreen extends ConsumerWidget {
  final TransactionResult result;

  const TransactionResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendFlowProvider);

    final token = state.selectedToken!;
    final recipient = state.recipient!;
    final fee = state.feeEstimate;

    final success = result.status == TransactionStatus.success;
    final pending = result.status == TransactionStatus.pending;

    late IconData icon;
    late Color color;
    late String title;
    late String subtitle;

    if (success) {
      icon = Icons.check_circle_rounded;
      color = Colors.green;
      title = "Transaction Successful";
      subtitle = "${state.amount} ${token.symbol} sent to ${recipient.value}";
    } else if (pending) {
      icon = Icons.schedule_rounded;
      color = Colors.orange;
      title = "Transaction Pending";
      subtitle = "${state.amount} ${token.symbol} is being processed.";
    } else {
      icon = Icons.cancel_rounded;
      color = Colors.red;
      title = "Transaction Failed";
      subtitle = "Your transaction could not be completed.";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Transaction"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              CircleAvatar(
                radius: 42,
                backgroundColor: color.withOpacity(.12),
                child: Icon(icon, size: 48, color: color),
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
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),

              const SizedBox(height: 32),

              Card(
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Amount"),
                      trailing: Text("${state.amount} ${token.symbol}"),
                    ),
                    ListTile(
                      title: const Text("Network"),
                      trailing: Text(token.network),
                    ),
                    ListTile(
                      title: const Text("Fee"),
                      trailing: Text(
                        fee == null ? "-" : "${fee.fee} ${fee.token}",
                      ),
                    ),
                    ListTile(
                      title: const Text("Transaction ID"),
                      subtitle: Text(result.transactionId),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: () {
                    context.go(AppRoutes.wallet);
                  },
                  child: const Text("Back to Wallet"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
