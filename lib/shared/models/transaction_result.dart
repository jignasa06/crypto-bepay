import 'package:equatable/equatable.dart';

import '../enums/transaction_status.dart';

class TransactionResult extends Equatable {
  final String transactionId;
  final TransactionStatus status;

  const TransactionResult({
    required this.transactionId,
    required this.status,
  });

  @override
  List<Object> get props => [
    transactionId,
    status,
  ];
}