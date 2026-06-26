import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../providers/send_flow_notifier.dart';
import '../../../../shared/enums/numeric_keyboard_type.dart';
import '../../../amount/presentation/widgets/numeric_keyboard.dart';

class PinScreen extends ConsumerWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state = ref.watch(sendFlowProvider);
    final notifier = ref.read(sendFlowProvider.notifier);

    Future<void> _onConfirm() async {
      if (!notifier.verifyPin()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid PIN'),
            backgroundColor: Colors.red,
          ),
        );
        notifier.clearPin();
        return;
      }

      final result = await notifier.sendTransaction();

      if (result != null) {
        context.go(
          AppRoutes.transactionResult,
          extra: result,
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm PIN"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            const Text(
              "Enter your 4-digit PIN",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Secure authentication before sending funds",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 36),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) {
                  final filled = index < state.pin.length;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: filled
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            NumericKeyboard(
              keyboardType: NumericKeyboardType.pin,
              onKeyPressed: notifier.appendPin,
              onBackSpace: notifier.removePin,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: state.isPinComplete && !state.isLoading
                      ? _onConfirm
                      : null,
                  child: state.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "Confirm Transfer",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
