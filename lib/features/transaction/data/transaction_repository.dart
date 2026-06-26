import 'dart:async';
import 'dart:math';

import '../../../shared/enums/mock_transaction_mode.dart';
import '../../../shared/enums/transaction_status.dart';
import '../../../shared/models/fee_estimate.dart';
import '../../../shared/models/transaction_result.dart';

class TransactionRepository {
  MockTransactionMode mode = MockTransactionMode.random;

  void setMode(MockTransactionMode newMode) {
    mode = newMode;
  }

  Future<FeeEstimate> estimateFee({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 300));

    switch (token) {
      case 'ETH':
        return const FeeEstimate(fee: 0.005, token: 'ETH');

      case 'SOL':
        return const FeeEstimate(fee: 0.001, token: 'SOL');

      case 'USDT':
        return const FeeEstimate(fee: 0.01, token: 'USDT');

      default:
        return const FeeEstimate(fee: 0.02, token: 'USDC');
    }
  }

  Future<TransactionResult> submitTransaction() async {
    await Future.delayed(const Duration(seconds: 2));

    late TransactionStatus status;

    switch (mode) {
      case MockTransactionMode.success:
        status = TransactionStatus.success;
        break;

      case MockTransactionMode.pending:
        status = TransactionStatus.pending;
        break;

      case MockTransactionMode.failed:
        status = TransactionStatus.failed;
        break;

      case MockTransactionMode.random:
        final second = DateTime.now().second % 3;

        if (second == 0) {
          status = TransactionStatus.success;
        } else if (second == 1) {
          status = TransactionStatus.pending;
        } else {
          status = TransactionStatus.failed;
        }
    }

    return TransactionResult(
      transactionId: 'TX-${DateTime.now().millisecondsSinceEpoch}',
      status: status,
    );
  }
}
