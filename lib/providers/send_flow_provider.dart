import 'package:crypto_bepay/shared/models/token_balance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/models/fee_estimate.dart';
import '../shared/models/recipient.dart';
import '../shared/models/send_flow_state.dart';
import '../shared/models/transaction_result.dart';

class SendFlowNotifier extends Notifier<SendFlowState> {
  @override
  SendFlowState build() {
    return const SendFlowState();
  }

  void selectedToken(TokenBalance token) {
    state = state.copyWith(selectedToken: token);
  }

  void setRecipient(Recipient recipient) {
    state = state.copyWith(recipient: recipient);
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }
  void setFeeEstimate(FeeEstimate feeEstimate) {
    state = state.copyWith(feeEstimate: feeEstimate);
  }
  void setTransactionResult(TransactionResult transactionResult) {
    state = state.copyWith(transactionResult: transactionResult);
  }

  void reset()
  {
    state = const SendFlowState();
  }
}
