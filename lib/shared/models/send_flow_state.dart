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
  final String pin;

  /// UI State
  final bool isLoading;

  const SendFlowState({
    this.selectedToken,
    this.recipient,
    this.amount = '0',
    this.feeEstimate,
    this.transactionResult,
    this.isLoading = false,
    this.pin = '',
  });

  SendFlowState copyWith({
    TokenBalance? selectedToken,
    Recipient? recipient,
    String? amount,
    FeeEstimate? feeEstimate,
    TransactionResult? transactionResult,
    bool? isLoading,
    String? pin,
  }) {
    return SendFlowState(
      selectedToken: selectedToken ?? this.selectedToken,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      feeEstimate: feeEstimate ?? this.feeEstimate,
      transactionResult: transactionResult ?? this.transactionResult,
      isLoading: isLoading ?? this.isLoading,
      pin: pin ?? this.pin,
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
    pin
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

  bool get isPinComplete => pin.length == 4;
}