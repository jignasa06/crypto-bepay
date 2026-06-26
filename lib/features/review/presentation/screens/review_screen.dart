import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/send_flow_notifier.dart';
import '../../presentation/widgets/review_summary_card.dart';
import '../../../pin/presentation/screens/pin_screen.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendFlowProvider);

    final token = state.selectedToken!;
    final recipient = state.recipient!;
    final fee = state.feeEstimate!;

    final total = state.amountValue + fee.fee;

    return Scaffold(
      appBar: AppBar(title: const Text("Review Transfer"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(recipient.value),
                  subtitle: const Text("Recipient"),
                ),
              ),

              const SizedBox(height: 20),

              ReviewSummaryCard(
                title: "Asset",
                value: "${token.symbol} (${token.network})",
              ),

              ReviewSummaryCard(
                title: "Amount",
                value:
                    "${state.amountValue.toStringAsFixed(4)} ${token.symbol}",
              ),

              ReviewSummaryCard(
                title: "Network Fee",
                value: "${fee.fee.toStringAsFixed(4)} ${token.symbol}",
              ),

              ReviewSummaryCard(
                title: "Recipient Receives",
                value:
                    "${state.amountValue.toStringAsFixed(4)} ${token.symbol}",
              ),

              const Divider(height: 40),

              ReviewSummaryCard(
                title: "Total Deducted",
                value: "${total.toStringAsFixed(4)} ${token.symbol}",
                isBold: true,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PinScreen()),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PIN Screen will be added next'),
                      ),
                    );
                  },
                  child: const Text("Confirm Transfer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
