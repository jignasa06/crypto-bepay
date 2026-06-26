import 'package:crypto_bepay/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/send_flow_notifier.dart';
import '../../../../shared/enums/numeric_keyboard_type.dart';
import '../../../../shared/models/send_flow_state.dart';
import '../widgets/amount_display.dart';
import '../widgets/continue_button.dart';
import '../widgets/numeric_keyboard.dart';
import '../widgets/recipient_card.dart';
import '../widgets/token_balance_card.dart';

class AmountScreen extends ConsumerStatefulWidget {
  const AmountScreen({super.key});

  @override
  ConsumerState<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends ConsumerState<AmountScreen> {
  Future<void> _continue() async {
    final error = await ref.read(sendFlowProvider.notifier).prepareReview();

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
    context.push(AppRoutes.review);
  }

  @override
  Widget build(BuildContext context) {
    final SendFlowState state = ref.watch(sendFlowProvider);

    final token = state.selectedToken!;
    final recipient = state.recipient!;

    final validationError = state.amount == '0'
        ? null
        : ref.read(sendFlowProvider.notifier).validateAmount();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    RecipientCard(recipient: recipient.value),
                    const SizedBox(height: 16),
                    TokenBalanceCard(
                      tokenName: token.name,
                      symbol: token.symbol,
                      network: token.network,
                      balance: token.balance,
                    ),

                    const SizedBox(height: 32),

                    AmountDisplay(
                      amount: state.amount,
                      symbol: token.symbol,
                      fiatValue: state.fiatValue,
                      errorMessage: validationError,
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 0,
                      child: ListTile(
                        title: const Text('Remaining Balance'),
                        trailing: Text(
                          '${state.remainingBalance.toStringAsFixed(4)} ${token.symbol}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            NumericKeyboard(
              keyboardType: NumericKeyboardType.amount,
              onKeyPressed: (key) {
                if (key == '.') {
                  ref.read(sendFlowProvider.notifier).appendDecimal();
                } else {
                  ref.read(sendFlowProvider.notifier).appendDigit(key);
                }
              },
              onBackSpace: () {
                ref.read(sendFlowProvider.notifier).removeLastDigit();
              },
            ),

            ContinueButton(onPressed: _continue),
          ],
        ),
      ),
    );
  }
}
