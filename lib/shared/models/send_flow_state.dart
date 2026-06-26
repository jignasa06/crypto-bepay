import 'package:equatable/equatable.dart';

import 'fee_estimate.dart';
import 'recipient.dart';
import 'token_balance.dart';
import 'transaction_result.dart';

class SendFlowState extends Equatable {
  final TokenBalance? selectedToken;
  final Recipient? recipient;
  final String amount;
  final FeeEstimate? feeEstimate;
  final TransactionResult? transactionResult;

  /// UI State
  final bool isLoading;

  const SendFlowState({
    this.selectedToken,
    this.recipient,
    this.amount = '0',
    this.feeEstimate,
    this.transactionResult,
    this.isLoading = false,
  });

  SendFlowState copyWith({
    TokenBalance? selectedToken,
    Recipient? recipient,
    String? amount,
    FeeEstimate? feeEstimate,
    TransactionResult? transactionResult,
    bool? isLoading,
  }) {
    return SendFlowState(
      selectedToken: selectedToken ?? this.selectedToken,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      feeEstimate: feeEstimate ?? this.feeEstimate,
      transactionResult: transactionResult ?? this.transactionResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    selectedToken,
    recipient,
    amount,
    feeEstimate,
    transactionResult,
    isLoading,
  ];

  double get amountValue => double.tryParse(amount) ?? 0;

  double get fiatValue {
    if (selectedToken == null) return 0;
    return amountValue * selectedToken!.usdPrice;
  }

  double get remainingBalance {
    if (selectedToken == null) return 0;
    return selectedToken!.balance - amountValue;
  }

  bool get canContinue =>
      selectedToken != null &&
          recipient != null &&
          amountValue > 0 &&
          !isLoading;
}