import 'dart:async';
import 'dart:math';

import '../../../shared/enums/transaction_status.dart';
import '../../../shared/models/fee_estimate.dart';
import '../../../shared/models/transaction_result.dart';

class TransactionRepository {
  Future<FeeEstimate> estimateFee({
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    switch (token) {
      case 'ETH':
        return const FeeEstimate(
          fee: 0.005,
          token: 'ETH',
        );

      case 'SOL':
        return const FeeEstimate(
          fee: 0.001,
          token: 'SOL',
        );

      case 'USDT':
        return const FeeEstimate(
          fee: 0.01,
          token: 'USDT',
        );

      default:
        return const FeeEstimate(
          fee: 0.02,
          token: 'USDC',
        );
    }
  }

  Future<TransactionResult> submitTransaction() async {
    await Future.delayed(const Duration(seconds: 2));

    final random = Random().nextInt(100);

    late TransactionStatus status;

    if (random < 70) {
      status = TransactionStatus.success;
    } else if (random < 90) {
      status = TransactionStatus.pending;
    } else {
      status = TransactionStatus.failed;
    }

    return TransactionResult(
      transactionId:
      'TX-${DateTime.now().millisecondsSinceEpoch}',
      status: status,
    );
  }
}