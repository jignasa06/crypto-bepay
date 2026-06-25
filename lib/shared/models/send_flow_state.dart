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

  const SendFlowState({
    this.selectedToken,
    this.recipient,
    this.amount = '0',
    this.feeEstimate,
    this.transactionResult,
  });

  SendFlowState copyWith({
    TokenBalance? selectedToken,
    Recipient? recipient,
    String? amount,
    FeeEstimate? feeEstimate,
    TransactionResult? transactionResult,
  }) {
    return SendFlowState(
      selectedToken: selectedToken ?? this.selectedToken,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      feeEstimate: feeEstimate ?? this.feeEstimate,
      transactionResult: transactionResult ?? this.transactionResult,
    );
  }

  @override
  List<Object?> get props => [
    selectedToken,
    recipient,
    amount,
    feeEstimate,
    transactionResult,
  ];
}