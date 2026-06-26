import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  final String amount;
  final String symbol;
  final double fiatValue;
  final String? errorMessage;

  const AmountDisplay({
    super.key,
    required this.amount,
    required this.symbol,
    required this.fiatValue,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          '$amount $symbol',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          '≈ \$${fiatValue.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 12),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: errorMessage == null
              ? const SizedBox.shrink()
              : Text(
            errorMessage!,
            key: ValueKey(errorMessage),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}