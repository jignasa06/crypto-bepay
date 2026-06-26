import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/validators/amount_validator.dart';
import '../shared/enums/mock_transaction_mode.dart';
import '../shared/models/fee_estimate.dart';
import '../shared/models/recipient.dart';
import '../shared/models/send_flow_state.dart';
import '../shared/models/token_balance.dart';
import '../shared/models/transaction_result.dart';
import 'repository_providers.dart';

final sendFlowProvider = NotifierProvider<SendFlowNotifier, SendFlowState>(
  SendFlowNotifier.new,
);

class SendFlowNotifier extends Notifier<SendFlowState> {
  @override
  SendFlowState build() {
    return const SendFlowState();
  }

  void selectToken(TokenBalance token) {
    state = state.copyWith(selectedToken: token);
  }

  void setRecipient(Recipient recipient) {
    state = state.copyWith(recipient: recipient);
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void appendDigit(String digit) {
    String current = state.amount;

    if (current == '0') {
      current = digit;
    } else {
      if (current.contains('.')) {
        final decimal = current.split('.').last;

        if (decimal.length >= 6) {
          return;
        }
      }

      current += digit;
    }

    state = state.copyWith(amount: current);
  }

  void appendDecimal() {
    String current = state.amount;

    if (current.contains('.')) return;

    if (current == '0') {
      current = '0.';
    } else {
      current += '.';
    }

    state = state.copyWith(amount: current);
  }

  void removeLastDigit() {
    String current = state.amount;

    if (current.length <= 1) {
      current = '0';
    } else {
      current = current.substring(0, current.length - 1);

      if (current.isEmpty) {
        current = '0';
      }
    }

    state = state.copyWith(amount: current);
  }

  void setMax() {
    final token = state.selectedToken;
    if (token == null) return;

    state = state.copyWith(
      amount: token.balance.toString(),
    );
  }

  String? validateAmount() {
    final token = state.selectedToken;

    if (token == null) {
      return 'Please select a token';
    }

    return AmountValidator.validate(
      amount: state.amount,
      balance: token.balance,
    );
  }

  Future<bool> prepareReview() async {
    final error = validateAmount();

    if (error != null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(transactionRepositoryProvider);

      final fee = await repository.estimateFee(
        token: state.selectedToken!.symbol,
      );

      state = state.copyWith(feeEstimate: fee, isLoading: false);

      return true;
    } catch (_) {
      state = state.copyWith(isLoading: false);

      return false;
    }
  }

  void setFeeEstimate(FeeEstimate fee) {
    state = state.copyWith(feeEstimate: fee);
  }
  void setTransactionMode(MockTransactionMode mode) {
    ref.read(transactionRepositoryProvider).setMode(mode);
  }

  void setTransactionResult(TransactionResult result) {
    state = state.copyWith(transactionResult: result);
  }

  Future<TransactionResult?> sendTransaction() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(transactionRepositoryProvider);

      final result = await repository.submitTransaction();

      state = state.copyWith(
        transactionResult: result,
        isLoading: false,
      );

      return result;
    } catch (_) {
      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  void appendPin(String digit) {
    if (state.pin.length >= 4) return;

    state = state.copyWith(pin: state.pin + digit);
  }

  void removePin() {
    if (state.pin.isEmpty) return;

    state = state.copyWith(pin: state.pin.substring(0, state.pin.length - 1));
  }

  void clearPin() {
    state = state.copyWith(pin: '');
  }
  bool verifyPin() {
    return state.pin == '1234';
  }

  void reset() {
    state = SendFlowState(
      selectedToken: state.selectedToken,
    );
  }
}
