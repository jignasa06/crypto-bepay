import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/models/token_balance.dart';
import 'repository_providers.dart';

final walletProvider = AsyncNotifierProvider<WalletNotifier,List<TokenBalance>>(WalletNotifier.new);

class WalletNotifier extends AsyncNotifier<List<TokenBalance>> {
  @override
  Future<List<TokenBalance>> build() async {
    final repository = ref.read(walletRepositoryProvider);
    return repository.getBalances();
  }

  Future<void> refreshBalance() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(walletRepositoryProvider).getBalances(),
    );
  }
}
