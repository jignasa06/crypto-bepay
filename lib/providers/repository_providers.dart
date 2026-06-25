import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/recipient/data/recipient_repository.dart';
import '../features/transaction/data/transaction_repository.dart';
import '../features/wallet/data/wallet_repository.dart';

final walletRepositoryProvider =
Provider<WalletRepository>(
      (ref) => WalletRepository(),
);

final recipientRepositoryProvider =
Provider<RecipientRepository>(
      (ref) => RecipientRepository(),
);

final transactionRepositoryProvider =
Provider<TransactionRepository>(
      (ref) => TransactionRepository(),
);